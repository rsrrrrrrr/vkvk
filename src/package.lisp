(defpackage :vkvk
  (:use :cl :cffi :cl-glfw3))

(in-package :vkvk)

(define-foreign-library libvulkan
  (:windows "vulkan-1.dll")
  (:unix (:or "libvulkan.so")))

(define-foreign-library libglfw3
     (:unix (:or "libglfw.so.3.1" "libglfw.so.3"))
     (:windows "glfw3.dll")
     (t (:or (:default "libglfw3") (:default "libglfw"))))

(use-foreign-library libvulkan)
(use-foreign-library libglfw3)

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

(defun fill-closure (struct-name ptr)
  #'(lambda (member val)
      (let ((slot-name (first member))
	    (parse-by (getf member :parse))
	    (type (second member)))
	(cond ((equal type '(:pointer :char))
	       (let ((foreign-string (foreign-string-alloc val)))
		 (push foreign-string val)
		 (setf (foreign-slot-value ptr struct-name slot-name) foreign-string)))
	      ((equal type '(:pointer (:pointer :char)))
	       (unless (null val)
		 (let ((len (length val))
		       (str-list (foreign-alloc type)))
		   (push str-list *allocated-string*)
		   (loop for i upto (1- len)
			 do
			    (progn
			      (setf (mem-aref str-list type i) (foreign-string-alloc (nth i val)))
			      (push (mem-aref str-list type i) *allocated-string*)))
		   (setf (foreign-slot-value ptr struct-name slot-name) str-list))))
	      ((and (consp type)
		    (eql (first type) :struct)
		    parse-by)
	       (setf (mem-ref (foreign-slot-pointer ptr struct-name slot-name) parse-by)
		     val))
	      (t (setf (foreign-slot-value ptr struct-name slot-name) val))))))

(defun process-count (type num ptr &optional (bind-p nil))
  (cond ((eql type :char) (foreign-string-to-lisp ptr))
	(bind-p (loop for i upto (1- num)
		 collect (mem-aref ptr type i)))
	(t (loop for i upto (1- num)
		 for p = (mem-aptr ptr type i)
		 until (null-pointer-p p)
		 collect (mem-ref p type)))))

(defun read-closure (struct-name ptr)
  #'(lambda (member)
      (let ((slot-name (first member))
	    (type (second member))
	    (count (getf member :count))
	    (bind (getf member :bind))
	    (parse-by (getf member :parse)))
	(cond (bind (list slot-name
			  (process-count type
					 (foreign-slot-value ptr struct-name bind)
					 (foreign-slot-pointer ptr struct-name slot-name)
					 t)))
	      (count (list slot-name
			   (process-count type
					  count
					  (foreign-slot-value ptr struct-name slot-name))))
	      (parse-by (list slot-name
			      (mem-ref (foreign-slot-pointer ptr struct-name slot-name)
				       parse-by)))
	      (t (list slot-name
		       (foreign-slot-value ptr struct-name slot-name)))))))

(defmacro def-struct-translator (struct-name (type-name parse-name) &body members)
  `(progn
     (define-foreign-type ,type-name ()
       ()
       (:actual-type :struct ,struct-name)
       (:simple-parser ,parse-name))
     (defmethod translate-into-foreign-memory (val (type ,type-name) ptr)
       (let ((fun (fill-closure '(:struct ,struct-name) ptr)))
	 (mapcar fun ',members val)))
     (defmethod translate-from-foreign (ptr (type ,type-name))
       (let ((fun (read-closure '(:struct ,struct-name) ptr)))
	 (mapcar fun ',members)))))

