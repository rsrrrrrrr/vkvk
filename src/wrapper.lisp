(in-package :vkvk)

(export '(create-instance destroy-instance))

(defun check-ret (val)
  (when (not (eql :SUCCESS val))
    (error "error: ~a~%" val)))

;;export
(defun create-instance (create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((info 'instance-create-info)
			 (instance 'vk-instance))
    (setf (mem-ref info 'instance-create-info)
	  (get-obj create-info 'instance-create-info))
    (check-ret (vkCreateInstance info allocator instance))
    (free-objs)
    (mem-ref instance 'vk-instance)))

(defun destroy-instance (instance &optional (allocator (null-pointer)))
  (vkDestroyInstance instance allocator))
#|
(defun create-device (physical-device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((info )
			 (device 'vk-device))))
|#
(defun destroy-device (device &optional (allocator (null-pointer)))
  (vkDestroyDevice device allocator))
