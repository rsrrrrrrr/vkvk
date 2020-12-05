(in-package :vkvk)

(export '(create-instance destroy-instance))

(defun check-ret (val)
  (when (not (eql :SUCCESS val))
    (error "error: ~a~%" val))
  (free-objs))            ;;if success free the objs you make

;;export
(defun create-instance (create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'instance-create-info)
			 (p-instance 'vk-instance))
    (setf (mem-ref p-info 'instance-create-info)
	  (get-obj create-info 'instance-create-info))
    (check-ret (vkCreateInstance p-info allocator p-instance))
    (mem-ref p-instance 'vk-instance)))

(defun destroy-instance (instance &optional (allocator (null-pointer)))
  (vkDestroyInstance instance allocator))

(defun create-device (physical-device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'device-create-info)
			 (p-device 'vk-device))
    (setf (mem-ref p-info 'device-create-info)
	  (get-obj create-info 'device-create-info))
    (check-ret (vkCreateDevice physical-device p-info allocator p-device))
    (mem-ref p-device 'vk-device)))

(defun destroy-device (device &optional (allocator (null-pointer)))
  (vkDestroyDevice device allocator))

(defun create-fence (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'fence-create-info)
			 (p-fence 'vk-fence))
    (setf (mem-ref p-info 'fence-create-info)
	  (get-obj create-info 'fence-create-info))
    (check-ret (vkCreateFence device p-info allocator p-fence))
    (mem-ref p-fence 'vk-fence)))

(defun destroy-fence (device fence &optional (allocator (null-pointer)))
  (vkDestroyFence device fence allocator))

(defun cerate-semaphore (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'semaphore-create-info)
			 (p-semaphore 'vk-semaphore))
    (setf (mem-ref p-info 'semaphore-create-info)
	  (get-obj create-info 'semaphore-create-info))
    (check-ret (vkCreateSemaphore device p-info allocator p-semaphore))
    (mem-ref p-semaphore 'vk-semaphore)))

(defun destroy-semaphore (device semaphore &optional (allocator (null-pointer)))
  (vkDestroySemaphore device semaphore allocator))

(defun create-event (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'event-create-info)
			 (p-event 'vk-event))
    (setf (mem-ref p-info 'event-create-info)
	  (get-obj create-info 'event-create-info))
    (check-ret (vkCreateEvent device p-info allocator p-event))
    (mem-ref p-event 'vk-event)))

(defun destroy-event (device event &optional (allocator (null-pointer)))
  (vkDestroyEvent device event allocator))

(defun create-query-pool (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'query-pool-create-info)
			 (p-pool 'vk-query-pool))
    (setf (mem-ref p-info 'query-pool-create-info)
	  (get-obj create-info 'query-pool-create-info))
    (check-ret (vkCreateQueryPool device p-info allocator p-pool))
    (mem-ref p-pool 'vk-query-pool)))

(defun destroy-query-pool (device query-pool &optional (allocator (null-pointer)))
  (vkDestroyQueryPool device query-pool allocator))

(defun create-buffer (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'buffer-create-info)
			 (p-buffer 'vk-buffer))
    (setf (mem-ref p-info 'buffer-create-info)
	  (get-obj create-info 'buffer-create-info))
    (check-ret (vkCreateBuffer device p-info allocator p-buffer))
    (mem-ref p-buffer 'vk-buffer)))

(defun destroy-buffer (device buffer &optional (allocator (null-pointer)))
  (vkDestroyBuffer device buffer allocator))

(defun create-buffer-view (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'buffer-view-create-info)
			 (p-buffer-view 'vk-buffer-view))
    (setf (mem-ref p-info 'buffer-view-create-info)
	  (get-obj create-info 'buffer-view-create-info))
    (check-ret (vkCreateBufferView device p-info allocator p-buffer-view))
    (mem-ref p-buffer-view 'vk-buffer-view)))

(defun destroy-buffer-view (device buffer-view &optional (allocator (null-pointer)))
  (vkDestroyBufferView device buffer-view allocator))

(defun create-image (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'image-create-info)
			 (p-image 'vk-image))
    (setf (mem-ref p-info 'image-create-info)
	  (get-obj create-info 'image-create-info))
    (check-ret (vkCreateImage device p-info allocator p-image))
    (mem-ref p-image 'vk-image)))

(defun destroy-image (device image &optional (allocator (null-pointer)))
  (vkDestroyImage device image allocator))

(defun create-image-view (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'image-view-create-info)
			 (p-image-view 'vk-image-view))
    (setf (mem-ref p-info 'image-view-create-info)
	  (get-obj create-info 'image-view-create-info))
    (check-ret (vkCreateImageView device p-info allocator p-image-view))
    (mem-ref p-image-view 'vk-image-view)))

(defun destroy-image-view (device image-view &optional (allocator (null-pointer)))
  (vkDestroyImageView device image-view allocator))

(defun create-shader-module (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'shader-module-create-info)
			 (p-module 'vk-shader-module))
    (setf (mem-ref p-info 'shader-module-create-info)
	  (get-obj create-info 'shader-module-create-info))
    (check-ret (vkCreateShaderModule device p-info allocator p-module))
    (mem-ref p-module 'vk-shader-module)))

(defun destroy-shader-module (device module &optional (allocator (null-pointer)))
  (vkDestroyShaderModule device module allocator))

(defun create-pipeline-cache (device create-info &optional (allocator (null-pointer)))
  (with-foreign-objects ((p-info 'pipeline-cache-create-info)
			 (p-cache 'vk-pipeline-cache))
    (setf (mem-ref p-info 'pipeline-cache-create-info)
	  (get-obj create-info 'pipeline-cache-create-info))
    (check-ret (vkCreatePipelineCache device p-info allocator p-cache))    
    (mem-ref p-cache 'vk-pipeline-cache)))

(defun destroy-pipeline-cache (device pipeline-cache &optional (allocator (null-pointer)))
  (vkDestroyPipelineCache device pipeline-cache allocator))
