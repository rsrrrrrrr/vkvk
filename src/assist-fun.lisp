(in-package :vkvk)

(export '(select-queue
	  get-present-queues))

(defun select-queue (physical-device properties)
  (let* ((queue-families (get-physical-device-queue-family-properties physical-device))
	 (num (1- (length queue-families)))
	 (flag (foreign-enum-value 'VkQueueFlagBits properties)))
    (loop for i upto num
	  for queue-family = (nth i queue-families)
	  unless (zerop (logand (second (assoc 'queue-flags queue-family))
				flag)) 
	    collect i)))

(defun get-present-queues (instance physical-device)
  (let* ((queue-families (get-physical-device-queue-family-properties physical-device))
	 (num (1- (length queue-families))))
    (loop for i upto num
	  when (queue-family-index-support-present-p instance physical-device i)
	    collect i)))
