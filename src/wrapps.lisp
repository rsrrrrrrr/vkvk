(in-package :vkvk)

(export '(make-vulkan-version
	  get-instance-extensions
	  get-instance-layers
	  create-instance
	  destroy-instance

	  enumerate-physical-device
	  get-physical-device-properties
	  get-physical-device-queue-family-properties
	  get-physical-device-memory-properties))

(defparameter *vk-nullptr* (null-pointer))

;;no need export
(defun select-usable (need-use can-use)
  (intersection need-use can-use :test #'string=))

(defun check-result (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val)))
;;export
(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let ((exts (glfwGetRequiredInstanceExtensions count)))
      (obj->list exts :string (mem-ref count :uint32)))))

(defun get-instance-layers ()
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-layer-properties)))
    (check-result (vkEnumerateInstanceLayerProperties count (null-pointer)))
    (let ((num (mem-ref count :uint32)))
      (when (funcall (complement #'zerop) num)
	(check-result (vkEnumerateInstanceLayerProperties count properties))
	(loop for i upto (1- num)
	      collect (getf (mem-aref properties 'layer-properties i) :layer))))))

(defun create-instance (&key
			  (app-next *vk-nullptr*)
			  (app-name "vkvk test")
			  (app-version (make-vulkan-version 0 0 1))
			  (engine-name "vkvk test")
			  (engine-version (make-vulkan-version 0 0 1))
			  (api-version (make-vulkan-version 1 2 0))
			  (info-next *vk-nullptr*)
			  (info-flags 0)
			  (info-lays *vk-nullptr*)
			  (info-exts *vk-nullptr*)
			  (allocator *vk-nullptr*))
  (with-foreign-objects ((info '(:struct vk-instance-create-info))
			 (app-info '(:struct vk-application-info))
			 (instance 'vk-instance))
    (setf (mem-ref app-info 'app-info)
	  (to-array-type
	   (list app-next
		 app-name
		 app-version
		 engine-name
		 engine-version
		 api-version))
	  (mem-ref info 'instance-info)
	  (to-array-type
	   (list info-next
		 info-flags
		 app-info
		 info-lays
		 info-exts)))
    (check-result (vkcreateinstance info allocator instance))
    (mem-ref instance 'vk-instance)))

(defun destroy-instance (instance &optional (allocator *vk-nullptr*))
  (vkdestroyinstance instance allocator))

(defun enumerate-physical-device (instance)
  (with-foreign-object (count :uint32)
    (check-result (vkEnumeratePhysicalDevices instance count *vk-nullptr*))
    (let ((num (mem-ref count :uint32)))
      (with-foreign-object (physical-devices 'vk-physical-device num)
	(check-result (vkEnumeratePhysicalDevices instance count physical-devices))
	(obj->list physical-devices 'vk-physical-device num)))))

(defun get-physical-device-properties (physical-device)
  (with-foreign-object (properties '(:struct vk-physical-device-properties))
    (vkGetPhysicalDeviceProperties physical-device properties)
    (mem-ref properties '(:struct vk-physical-device-properties))))

(defun get-physical-device-queue-family-properties (physical-device)
  (with-foreign-object (count :uint32)
    (vkGetPhysicalDeviceQueueFamilyProperties physical-device count *vk-nullptr*)
    (let ((num (mem-ref count :uint32)))
      (with-foreign-object (properties '(:struct vk-queue-family-properties) num)
	(vkGetPhysicalDeviceQueueFamilyProperties physical-device count properties)
	(obj->list properties 'queue-family-property num)))))

(defun get-physical-device-memory-properties (physical-device)
  (with-foreign-object (properties '(:struct vk-physical-device-memory-properties))
    (vkGetPhysicalDeviceMemoryProperties physical-device properties)
    (mem-ref properties 'physical-device-memory-property)))
