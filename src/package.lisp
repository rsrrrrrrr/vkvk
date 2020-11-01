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

(defun fill-closure (struct-name ptr)
  #'(lambda (member val)
      (let ((slot-name (first member))
	    (type (second member)))
	(if (eql type :uint32)
	    (setf (foreign-slot-value ptr struct-name slot-name) val)))))

(defun read-closure (struct-name ptr)
  #'(lambda (member)
      (let ((slot-name (first member)))
	(list slot-name
	      (foreign-slot-value ptr struct-name slot-name)))))

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
