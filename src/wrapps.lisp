(in-package :vkvk)

(export '(make-vulkan-version
	  get-instance-extensions
	  get-instance-layers
	  create-instance
	  destroy-instance

	  enumerate-physical-device
	  get-physical-device-properties
	  get-physical-device-queue-family-properties
	  get-physical-device-memory-properties
	  get-physical-device-features
	  get-physical-device-format-properties))

(defparameter *vk-nullptr* (null-pointer))
(defparameter *instance-dbg-create-info* *vk-nullptr*)
(defparameter *instance-dbg-callback-handle* nil)
(defparameter *debug-status* nil)

(defconstant +vk-false+ 0)
(defconstant +vk-true+ 1)

;;for debug
(defcallback debug-message vk-bool-32
    ((flags vk-flags)
     (obj-type VkDebugReportObjectTypeExt)
     (src-obj :uint64)
     (location :unsigned-int)
     (msg-code :int32)
     (layer-prefix :string)
     (msg :string)
     (user-data (:pointer :void)))
  (declare (ignore obj-type src-obj location user-data))
  (format t "layer-prefix:~a                                   msg-code: ~a~%" layer-prefix msg-code)
  (cond ((not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-error-bit-ext))))
	 (format t "[debug error] -> message: ~a~%" msg))
	((not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-warning-bit-ext))))
	 (format t "[debug waring] -> message: ~a~%" msg))
	((not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-information-bit-ext))))
	 (format t "[debug information] -> message: ~a~%" msg))
	((not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-performance-warning-bit-ext))))
	 (format t "[debug performance waring] -> message: ~a~%" msg))
	((not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-debug-bit-ext))))
	 (format t "[debug] -> message: ~a~%" msg))
	(t +vk-true+))
  +vk-false+)

(defun create-debug-callback (instance &optional (allocator *vk-nullptr*))
  (setf *instance-dbg-callback-handle* (foreign-alloc 'vk-debug-utils-messenger-ext))
  (with-foreign-object (create-fun :pointer)
    (setf (mem-ref create-fun :pointer) (get-instance-proc-addr instance "vkCreateDebugReportCallbackEXT"))
    (unless (null-pointer-p create-fun)
      (check-result (foreign-funcall-pointer (mem-ref create-fun :pointer) ()
					     vk-instance instance
					     (:pointer (:struct vk-debug-report-callback-create-info-ext)) *instance-dbg-create-info*
					     (:pointer (:struct vk-allocation-callback)) allocator 
					     vk-debug-utils-messenger-ext *instance-dbg-callback-handle*
					     VkResult)))))

(defun destroy-debug-callback (instance &optional (allocator *vk-nullptr*))
  (with-foreign-object (destroy-fun :pointer)
    (setf (mem-ref destroy-fun :pointer) (get-instance-proc-addr instance "vkDestroyDebugReportCallbackEXT"))
    (unless (null-pointer-p destroy-fun)
      (foreign-funcall-pointer (mem-ref destroy-fun :pointer) ()
			       vk-instance instance
			       vk-debug-utils-messenger-ext (mem-ref *instance-dbg-callback-handle* :pointer)
			       (:pointer (:struct vk-allocation-callback)) allocator))))


(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defun check-result (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val))
  (free-strings))

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let ((exts (glfwGetRequiredInstanceExtensions count)))
      (obj->list exts :string count))))

(defun get-instance-layers ()
  (with-foreign-objects ((count :uint32)
			 (properties 'layper-properties))
    (check-result (vkEnumerateInstanceLayerProperties count (null-pointer)))
    (let ((num (mem-ref count :uint32)))
      (when (funcall (complement #'zerop) num)
	(check-result (vkEnumerateInstanceLayerProperties count properties))
	(obj->list properties 'layper-properties count)))))

(defun get-usable-instance-extensions (exts)
  "return the usable extension list you can use"
  (intersection exts (get-instance-extensions) :test #'string=))

(defun get-usable-instance-layers (lays)
  "return the usable layers list you can use"
  (let* ((usable-layers (get-instance-layers))
	 (layer-names (loop for layer in usable-layers
			    collect (second (assoc 'layer-name layer)))))
    (intersection lays layer-names :test #'string=)))

(defun create-instance (&key
			  (app-next *vk-nullptr*)
			  (app-name "vkvk test")
			  (app-version (make-vulkan-version 0 0 1))
			  (engine-name "vkvk test")
			  (engine-version (make-vulkan-version 0 0 1))
			  (api-version (make-vulkan-version 1 2 0))
			  (info-next *vk-nullptr*)
			  (info-flags 0)
			  (info-lays nil)
			  (info-exts nil)
			  (allocator *vk-nullptr*)
			  (dbg nil))
  (let ((usable-exts (get-usable-instance-extensions info-exts))
	(usable-lays (get-usable-instance-layers info-lays)))
    (with-foreign-objects ((info 'instance-create-info)
			   (app-info 'application-info)
			   (instance 'vk-instance))
      (when dbg
	(push "VK_EXT_debug_report" usable-exts)
	(setf *instance-dbg-create-info*
	      (foreign-alloc 'debug-report-callback-create-info)
	      *debug-status* t
	      (mem-ref *instance-dbg-create-info* 'debug-report-callback-create-info)
	      (list :structure-type-debug-report-callback-create-info-ext
		    *vk-nullptr*
		    (logior (foreign-enum-value 'VkDebugReportFlagBitsEXT
						:debug-report-warning-bit-ext )
			    (foreign-enum-value 'VkDebugReportFlagBitsEXT
						:debug-report-performance-warning-bit-ext)
			    (foreign-enum-value 'VkDebugReportFlagBitsEXT
						:debug-report-error-bit-ext)
			    (foreign-enum-value 'VkDebugReportFlagBitsEXT
						:debug-report-debug-bit-ext))
		    (callback debug-message)
		    *vk-nullptr*)
	      info-next *instance-dbg-create-info*))
      (setf (mem-ref app-info 'application-info)
	    (list :structure-type-application-info
		  app-next
		  app-name
		  app-version
		  engine-name
		  engine-version
		  api-version)
	    (mem-ref info 'instance-create-info)
	    (list :structure-type-instance-create-info
		  info-next
		  info-flags
		  app-info
		  (length usable-lays)
		  usable-lays
		  (length usable-exts)
		  usable-exts))
      (check-result (vkcreateinstance info allocator instance))
      (let ((ist (mem-ref instance 'vk-instance)))
	(when *debug-status*
	  (create-debug-callback ist)
	  (foreign-free *instance-dbg-create-info*))
	ist))))

(defun destroy-instance (instance &optional (allocator *vk-nullptr*))
  (when *debug-status*
    (destroy-debug-callback instance)
    (setf *debug-status* nil))
  (vkdestroyinstance instance allocator))

;;function for get
(defun enumerate-physical-device (instance)
  (with-foreign-object (count :uint32)
    (check-result (vkEnumeratePhysicalDevices instance count *vk-nullptr*))
    (let ((num (mem-ref count :uint32)))
      (with-foreign-object (physical-devices 'vk-physical-device num)
	(check-result (vkEnumeratePhysicalDevices instance count physical-devices))
	(obj->list physical-devices 'vk-physical-device count)))))

(defun get-physical-device-properties (physical-device)
  (with-foreign-object (properties 'physical-device-properties)
    (vkGetPhysicalDeviceProperties physical-device properties)
    (mem-ref properties 'physical-device-properties)))

(defun get-physical-device-queue-family-properties (physical-device)
  (with-foreign-object (count :uint32)
    (vkGetPhysicalDeviceQueueFamilyProperties physical-device count *vk-nullptr*)
    (let ((num (mem-ref count :uint32)))
      (with-foreign-object (properties 'queue-family-properties num)
	(vkGetPhysicalDeviceQueueFamilyProperties physical-device count properties)
	(obj->list properties 'queue-family-properties count)))))

(defun get-physical-device-memory-properties (physical-device)
  (with-foreign-object (properties 'physical-device-memory-properties)
    (vkGetPhysicalDeviceMemoryProperties physical-device properties)
    (mem-ref properties 'physical-device-memory-properties)))

(defun get-physical-device-features (physical-device)
  (with-foreign-object (features 'physical-device-features)
    (vkGetPhysicalDeviceFeatures physical-device features)
    (mem-ref features 'physical-device-features)))

(defun get-physical-device-format-properties (physical-device format)
  (with-foreign-object (properties 'format-properties)
    (vkGetPhysicalDeviceFormatProperties physical-device format properties)
    (mem-ref properties 'format-properties)))
