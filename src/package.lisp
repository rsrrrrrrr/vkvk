(defpackage :vkvk
  (:use :cl :cffi))

(in-package :vkvk)

(define-foreign-library libvulkan
  (:windows "vulkan-1.dll")
  (:unix (:or "libvulkan.so")))

(use-foreign-library libvulkan)

(defparameter *allocated-obj* nil)

(defun free-objs ()
  (dolist (obj *allocated-obj*)
    (foreign-string-free obj))
  (setf *allocated-obj* nil))

(defun obj->list (objs type num)
  (let ((count (1- (mem-ref num :uint32))))
    (loop for i upto count
	  collect (mem-aref objs type i))))

(defun count->list (objs type num)
  (loop for i upto num
	collect (mem-aref objs type i)))

(defun process-write-pointer (struct-name ptr slot-name pointer-type val parse-by bind-name)
  "this function is used to fill the pointer type"
  (cond ((eql pointer-type :void)    ;;process void pointer
	 (setf (foreign-slot-value ptr struct-name slot-name) val))
	((eql pointer-type :char)    ;;process string
	 (unless (null val)
	   (let ((foreign-string (foreign-string-alloc val)))
	     (push foreign-string val)
	     (setf (foreign-slot-value ptr struct-name slot-name) foreign-string))))
	((and (consp pointer-type)
	      (equal pointer-type '(:pointer :char)))   ;;process string pointer
	 (unless (null val)
	   (let* ((len (length val))
		  (str-list (foreign-alloc pointer-type :count len)))
	     (push str-list *allocated-obj*)
	     (dotimes (i len)
	       (setf (mem-aref str-list pointer-type i)
		     (foreign-string-alloc (nth i val))))
	     (setf (foreign-slot-value ptr struct-name slot-name) str-list))))
	((and bind-name parse-by)
	 (progn
	   (let* ((num (foreign-slot-value struct-name bind-name :uint32)) ;;get count
		  (sub-obj (foreign-alloc parse-by :count num)))           ;;alloc sub obj
	     (dotimes (i num)
	       (setf (mem-aref sub-obj parse-by i) (nth i val)))
	     (setf (foreign-slot-value ptr struct-name slot-name) sub-obj)
	     (push sub-obj *allocated-obj*))))
	(parse-by                               ;;process struct pointer
	 (progn
	   (let ((sub-obj (foreign-alloc parse-by)))
	     (setf (mem-ref sub-obj parse-by) val
		   (foreign-slot-value ptr struct-name slot-name) sub-obj)
	     (push sub-obj *allocated-obj*))))))

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
			  (parse-by (getf member :parser))
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
  (cond ((eql pointer-type :void)
	 (foreign-slot-value ptr struct-name slot-name))
	((eql pointer-type :char)
	 (foreign-string-to-lisp (foreign-slot-value ptr struct-name slot-name)))
	((and (consp pointer-type)
	      (equal pointer-type '(:pointer :char))
	      bind-name)
	 (let ((count (foreign-slot-value ptr struct-name bind-name))   ;;get count
	       (strs (foreign-slot-value ptr struct-name slot-name)))
	   (loop for i upto (1- count)		 
		 collect (foreign-string-to-lisp (mem-aref strs pointer-type i)))))
	((and (consp pointer-type)
	      (eql (first pointer-type) :struct)
	      parse-by
	      bind-name)
	 (let ((count (foreign-slot-value ptr struct-name bind-name)))  ;;get count
	   (loop for i upto (1- count)
		 collect (mem-aref (foreign-slot-value ptr struct-name slot-name) parse-by i))))
	((and (consp pointer-type)
	      (eql (first pointer-type) :struct)
	      parse-by)
	 (mem-aref (foreign-slot-value ptr struct-name slot-name) parse-by))))

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
  #'(lambda (member &aux
		      (slot-name (first member))
		      (type (second member))
		      (parse-by (getf member :parser))
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
		  (t (foreign-slot-value ptr struct-name slot-name))))))

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
