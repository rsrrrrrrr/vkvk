(in-package :vkvk)

(export '(select-queue
	  get-present-queues))

(defun select-queue (physical-device properties)
  (let* ((queue-families (first (get-physical-device-queue-family-properties physical-device)))
	 (flag (foreign-enum-value 'VkQueueFlagBits properties)))
    (loop for queue-family in queue-families
	  for i from 0
	  unless (zerop (logand (getf queue-families :queue-flags)
				flag))
	    collect i)))

(defun get-present-queues (instance physical-device)
  (let* ((queue-families (get-physical-device-queue-family-properties physical-device))
	 (num (1- (length queue-families))))
    (loop for i upto num
	  when (queue-family-index-support-present-p instance physical-device i)
	    collect i)))
