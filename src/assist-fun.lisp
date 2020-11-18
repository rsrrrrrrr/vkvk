(in-package :vkvk)

(export '(select-queue
	  get-present-queues
	  get-usable-device-extensions
	  get-usable-device-layers
	  get-usable-instance-extensions
	  get-usable-instance-layers
	  make-vk-flag))

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

(defun get-usable-instance-extensions (exts)
  "return the usable extension list you can use"
  (intersection exts (enumerate-instance-extensions) :test #'string=))

(defun get-usable-instance-layers (lays)
  "return the usable layers list you can use"
  (let* ((usable-layers (enumerate-instance-layers))
	 (layer-names (unless (null usable-layers)
			(loop for layer in usable-layers
			      collect (getf layer :layer-name)))))
    (intersection lays layer-names :test #'string=)))

(defun get-usable-device-layers (physical-device lays)
  (let* ((usable-layers (enumerate-device-layers physical-device))
	 (layer-names (unless (null usable-layers)
			(loop for layer in usable-layers
			      collect (getf layer :layer-name)))))
    (intersection lays layer-names :test #'string=)))

(defun get-usable-device-extensions (physical-device exts)
  (let* ((usable-extensions (enumerate-device-extensions physical-device))
	 (extension-names (unless (null usable-extensions)
			    (loop for extension in usable-extensions
				  collect (getf extension :extension-name)))))
    (intersection exts extension-names :test #'string=)))

(defun make-vk-flag (type &rest args)
  (apply #'logior (mapcar #'(lambda (x)
			      (foreign-enum-value type x))
			  args)))
