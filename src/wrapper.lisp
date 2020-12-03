(in-package :vkvk)

(export '(create-instance destroy-instance))

(defun check-ret (val)
  (when (not (eql :SUCCESS val))
    (error "error: ~a~%" val)))

;;export
(defun create-instance (create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'instance-create-info)
			 (p-instance 'vk-instance))
    (setf (mem-ref p-info 'instance-create-info)
	  (get-obj create-info 'instance-create-info))
    (check-ret (vkCreateInstance p-info allocator p-instance))
    (free-objs)
    (mem-ref p-instance 'vk-instance)))

(defun destroy-instance (instance &optional (allocator (null-pointer)))
  (vkDestroyInstance instance allocator))

(defun create-device (physical-device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'device-create-info)
			 (p-device 'vk-device))
    (setf (mem-ref p-info 'device-create-info)
	  (get-obj create-info 'device-create-info))
    (check-ret (vkCreateDevice physical-device p-info allocator p-device))
    (free-objs)
    (mem-ref p-device 'vk-device)))

(defun destroy-device (device &optional (allocator (null-pointer)))
  (vkDestroyDevice device allocator))
