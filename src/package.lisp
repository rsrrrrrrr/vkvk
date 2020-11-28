(defpackage :vkvk
  (:use :cl :cffi))

(in-package :vkvk)

(define-foreign-library libvulkan
  (:windows "vulkan-1.dll")
  (:unix (:or "libvulkan.so")))

(use-foreign-library libvulkan)

(defparameter *allocated-string* nil)

(defun free-strings ()
  (dolist (obj *allocated-string*)
    (foreign-string-free obj))
  (setf *allocated-string* nil))

(defun obj->list (objs type num)
  (let ((count (1- (mem-ref num :uint32))))
    (loop for i upto count
	  collect (mem-aref objs type i))))

(defun count->list (objs type num)
  (loop for i upto num
	collect (mem-aref objs type i)))

(defun process-write-pointer (struct-name ptr slot-name pointer-type val parse-by bind-name)
  "this function is used to fill the pointer type"
  (cond ((eql pointer-type :char)    ;;process string
	 (unless (null val)
	   (let ((foreign-string (foreign-string-alloc val)))
	     (push foreign-string val)
	     (setf (foreign-slot-value ptr struct-name slot-name) foreign-string))))
	((and (consp pointer-type)
	      (eql pointer-type '(:pointer :char)))   ;;process string pointer
	 (unless (null val)
	   (let ((len (length val))
		 (str-list (foreign-alloc pointer-type)))
	     (push str-list *allocated-string*)
	     (dotimes (i (1- len))
	       (setf (mem-aref str-list pointer-type i)
		     (foreign-string-alloc (nth i val)))
	       (push (mem-aref str-list pointer-type i) *allocated-string*))
	     (setf (foreign-slot-value ptr struct-name slot-name) str-list))))
	((and bind-name parse-by)
	 (let ((num (foreign-slot-value struct-name bind-name :uint32))) ;;get count
	   (dotimes (i (1- num))
	     (setf (mem-aref (foreign-slot-value ptr struct-name slot-name) parse-by i)
		   (nth i val)))))
	(parse-by                               ;;process struct pointer
	 (setf (mem-ref (foreign-slot-value ptr struct-name slot-name) parse-by)
	       val))))

(defun process-write-count (struct-name ptr slot-name type val parse-by count &aux (len (length val)))
  (unless (> len count)
    (error "the val you want set is too big"))
  (cond (parse-by    ;;struct array
	 (dotimes (i (1- len))
	   (setf (mem-aref (foreign-slot-value ptr struct-name slot-name) parse-by i)
		 (nth i val))))
	(t
	 (dotimes (i (1- len))
	   (setf (mem-aref (foreign-slot-value ptr struct-name slot-name) type i)
		 (nth i val))))))

(defun write-closure (struct-name ptr)
  #'(lambda (member val &aux
			  (slot-name (first member))
			  (type (second member))
			  (parse-by (getf member :parse))
			  (bind-name (getf member :bind))
			  (count (getf member :count)))
      (cond ((and (consp type)
		  (eql (first type) :pointer))
	     (process-write-pointer struct-name ptr slot-name (second type) val parse-by bind-name))
	    (count (process-write-count struct-name ptr slot-name type val parse-by count))  ;;process array
	    ((and (consp type)                      ;;process struct not pointer
		  (eql (first type) :struct)
		  parse-by)
	     (setf (mem-ref (foreign-slot-pointer ptr struct-name slot-name) parse-by)
		   val))
	    (t (setf (foreign-slot-value ptr struct-name slot-name) val)))))

(defun process-read-pointer (struct-name ptr slot-name pointer-type parse-by bind-name)
  (cond ((eql pointer-type :char) (foreign-string-to-lisp ptr))
	((and (consp pointer-type)
	      (eql pointer-type '(:pointer :char))
	      bind-name)
	 (let ((count (foreign-slot-value ptr struct-name bind-name)))  ;;get count
	   (loop for i upto (1- count)
		 collect (mem-aref (foreign-slot-value ptr struct-name slot-name) pointer-type i))))
	((and (consp pointer-type)
	      (eql (first pointer-type) :struct)
	      parse-by
	      bind-name)
	 (let ((count (foreign-slot-value ptr struct-name bind-name)))  ;;get count
	   (loop for i upto (1- count)
		 collect (mem-aref (foreign-slot-value ptr struct-name slot-name) parse-by i))))))

(defun process-read-count (struct-name ptr slot-name type parse-by count)
  (cond ((eql type :char) (foreign-string-to-lisp ptr))
	(parse-by
	 (let ((slot-ptr (foreign-slot-value ptr struct-name slot-name)))
	   (loop for i upto (1- count)
		 for p = (mem-aptr slot-ptr parse-by i)
		 until (null-pointer-p p)
		 collect (mem-ref p parse-by))))
	(t
	 (let ((slot-ptr (foreign-slot-value ptr struct-name slot-name)))
	   (loop for i upto (1- count)
		 for p = (mem-aptr slot-ptr type i)
		 until (null-pointer-p p)
		 collect (mem-ref p type))))))

(defun read-closure (struct-name ptr)
  #'(lambda (member val &aux
			  (slot-name (first member))
			  (type (second member))
			  (parse-by (getf member :parse))
			  (bind-name (getf member :bind))
			  (count (getf member :count)))
      (list slot-name
	    (cond ((and (consp type)
			(eql (first type) :pointer))
		   (process-read-pointer struct-name ptr slot-name (second type) parse-by bind-name))
		  (count (process-read-count struct-name ptr slot-name type parse-by count))  ;;process array
		  ((and (consp type)                      ;;process struct not pointer
			(eql (first type) :struct)
			parse-by)
		   (mem-ref (foreign-slot-pointer ptr struct-name slot-name) parse-by))
		  (t (foreign-slot-value ptr struct-name slot-name) val)))))

(defmacro defvkobj (struct-name (type-name parse-name) &body members)
  `(progn
     (define-foreign-type ,type-name ()
       ()
       (:actual-type :struct ,struct-name)
       (:simple-parser ,parse-name))
     (defmethod translate-into-foreign-memory (val (type ,type-name) ptr)
       (let ((fun (write-closure '(:struct ,struct-name) ptr)))
	 (mapcar fun ',members val)))
     (defmethod translate-from-foreign (ptr (type ,type-name))
       (let ((fun (read-closure '(:struct ,struct-name) ptr)))
	 (apply #'append (mapcar fun ',members))))))



