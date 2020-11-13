(in-package :vkvk)

(export '(+vk-true+
	  +vk-false+
	  make-vulkan-version
	  create-instance
	  destroy-instance
	  create-device
	  destroy-device
	  glfw-create-surface
	  create-android-surface
	  create-wayland-surface
	  create-win32-surface
	  create-xcb-surface
	  create-xlib-surface
	  create-direct-fb-surface
	  create-image-pipe-surface
	  create-stream-descriptor-surface
	  create-ios-surface
	  create-macos-surface
	  create-vi-surface
	  create-metal-surface
	  create-display-plane-surface
	  destroy-surface
	  create-swapchain
	  destroy-swapchain
	  create-image-view
	  destroy-image-view
	  create-shader-module
	  destroy-shader-module
	  create-pipeline-layout
	  destroy-pipeline-layout
	  create-graphics-pipeline
	  destroy-graphics-pipeline
	  
	  enumerate-physical-device
	  enumerate-device-extensions
	  enumerate-device-layers
	  enumerate-instance-extensions
	  enumerate-instance-layers
	  get-physical-device-properties
	  get-physical-device-queue-family-properties
	  get-physical-device-memory-properties
	  get-physical-device-features
	  get-physical-device-format-properties
	  enumerate-instance-version
	  get-physical-device-image-format-properties
	  get-device-memory-commitment
	  get-physical-device-surface-capabilities
	  get-physical-device-surface-format
	  get-physical-device-surfaec-present-mode
	  get-device-queue
	  get-swapchain-images))

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

(defun enumerate-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let ((exts (glfwGetRequiredInstanceExtensions count)))
      (obj->list exts :string count))))

(defun enumerate-instance-layers ()
  (with-foreign-object (count :uint32)
    (check-result (vkEnumerateInstanceLayerProperties count (null-pointer)))
    (let ((num (mem-ref count :uint32)))
      (unless (zerop num)
	(with-foreign-object (properties 'layer-properties num)
	  (check-result (vkEnumerateInstanceLayerProperties count properties))
	  (obj->list properties 'layer-properties count))))))

(defun enumerate-device-layers (physical-device)
  (with-foreign-object (count :uint32)
    (check-result (vkEnumerateDeviceLayerProperties physical-device count (null-pointer)))
    (let ((num (mem-ref count :uint32)))
      (unless (zerop num)
	(with-foreign-object (properties 'layer-properties num)
	  (check-result (vkEnumerateDeviceLayerProperties physical-device count properties))
	  (obj->list properties 'layer-properties count))))))

(defun enumerate-device-extensions (physical-device)
  (with-foreign-object (count :uint32)
    (check-result (vkEnumerateDeviceExtensionProperties physical-device *vk-nullptr* count *vk-nullptr*))
    (let ((num (mem-ref count :uint32)))
      (unless (zerop num)
	(with-foreign-object (properties 'extension-properties num)
	  (check-result (vkEnumerateDeviceExtensionProperties physical-device *vk-nullptr* count properties))
	  (obj->list properties 'extension-properties count))))))

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

(defun create-device (physical-device &key
					(info-next *vk-nullptr*)
					(info-flags 0)
					(info-queues nil)
					(info-lays nil)
					(info-exts nil)
					(info-features nil)
					(allocate *vk-nullptr*))
  (let ((queue-count (length info-queues))
	(features (get-physical-device-features physical-device))
	(usable-layers (get-usable-device-layers physical-device info-lays))
	(usable-extensions (get-usable-device-extensions physical-device info-exts)))
    (labels ((set-features (lst)
	       (cond ((null lst) nil)
		     (t (progn
			  (setf (getf features (first lst))
				(second lst))
			  (set-features (rest (rest lst)))))))
	     (to-fill-struct (lst)
	       (cond ((null lst) nil)
		     (t (cons (second lst)
			      (to-fill-struct (rest (rest lst)))))))
	     (clear-features (lst)
	       (cond ((null lst) nil)
		     (t (cons (first lst)
			      (cons 0
				    (clear-features (rest (rest lst)))))))))
      (setf features (clear-features features))
      (set-features info-features)
      (setf features (to-fill-struct features)))
    (with-foreign-objects ((device 'vk-device)
			   (queues 'device-queue-create-info queue-count)
			   (queue-properties :float queue-count)
			   (p-feature 'physical-device-features)
			   (create-info 'device-create-info))
      (unless (zerop queue-count)
	(loop for i upto (1- queue-count)
	      for struct = (nth i info-queues)
	      for queue-property = (mem-aptr queue-properties :float i)
	      do (progn
		   (unless (lsp-device-queue-create-info-p struct)
		     (error "not the queue info struct"))
		   (setf (mem-ref queue-property :float)
			 (lsp-device-queue-create-info-queue-properties struct))
		   (setf (mem-aref queues 'device-queue-create-info i)
			 (list (lsp-device-queue-create-info-type struct) 
			       (lsp-device-queue-create-info-next struct) 
			       (lsp-device-queue-create-info-flag struct) 
			       (lsp-device-queue-create-info-queue-family-index struct) 
			       (lsp-device-queue-create-info-queue-count struct) 
			       queue-property)))))
      (setf (mem-ref p-feature 'physical-device-features)
	    features
	    (mem-ref create-info 'device-create-info)
	    (list :structure-type-device-create-info
		  info-next
		  info-flags
		  queue-count
		  queues
		  (length usable-layers)
		  usable-layers
		  (length usable-extensions)
		  usable-extensions
		  p-feature))
      (check-result (vkCreateDevice physical-device create-info allocate device))
      (mem-ref device 'vk-device))))

(defun destroy-device (device &optional (allocator *vk-nullptr*))
  (vkDestroyDevice device allocator))

(defun glfw-create-surface (instance window &key
					 (allocator *vk-nullptr*))
  (with-foreign-object (surface 'vk-surface-khr)
    (check-result (glfwCreateWindowSurface instance
					   window
					   allocator
					   surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-android-surface (instance window &key
						 (next *vk-nullptr*)
						 (flags 0)
						 (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'andorid-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'andorid-surface-create-info)
	  (list :structure-type-android-surface-create-info-khr
		next
		flags
		window))
    (check-result (vkCreateAndroidSurfaceKHR instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-wayland-surface (instance display way-surface &key
							  (next *vk-nullptr*)
							  (flags 0)
							  (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'wayland-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'wayland-surface-create-info)
	  (list :structure-type-wayland-surface-create-info-khr
		next
		flags
		display
		way-surface))
    (check-result (vkCreateWaylandSurfaceKHR instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-win32-surface (instance hinstance hwnd &key
						       (next *vk-nullptr*)
						       (flags 0)
						       (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'win32-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'win32-surface-create-info)
	  (list :structure-type-win32-surface-create-info-khr
		next
		flags
		hinstance
		hwnd))
    (check-result (vkCreateWin32SurfaceKHR instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-xcb-surface (instance connection window &key
				      (next *vk-nullptr*)
				      (flags 0)
				      (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'xcb-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'xcb-surface-create-info)
	  (list :structure-type-xcb-surface-create-info-khr
		next
		flags
		connection
		window))
    (check-result (vkCreateXcbSurfaceKHR  instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-xlib-surface (instance dpy window &key
				       (next *vk-nullptr*)
				       (flags 0)
				       (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'xlib-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'xlib-surface-create-info)
	  (list :structure-type-xlib-surface-create-info-khr
		next
		flags
		dpy
		window))
    (check-result (vkCreateXlibSurfaceKHR instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-direct-fb-surface (instance dfb dfb-surface &key
					    (next *vk-nullptr*)
					    (flags 0)
					    (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'direct-fb-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'direct-fb-surface-create-info)
	  (list :structure-type-directfb-surface-create-info-ext
		next
		flags
		dfb
		dfb-surface))
    (check-result (vkCreateDirectFBSurfaceEXT instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-image-pipe-surface (instance image-pipe-handle &key
					     (next *vk-nullptr*)
					     (flags 0)
					     (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'image-pipe-surface-fuchsia-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'image-pipe-surface-fuchsia-create-info)
	  (list :structure-type-imagepipe-surface-create-info-fuchsia
		next
		flags
		image-pipe-handle))
    (check-result (vkCreateImagePipeSurfaceFUCHSIA instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-stream-descriptor-surface (instance descriptor &key
						    (next *vk-nullptr*)
						    (flags 0)
						    (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'stream-descriptor-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'stream-descriptor-surface-create-info)
	  (list :structure-type-stream-descriptor-surface-create-info-ggp
		next
		flags
		descriptor))
    (check-result (vkCreateStreamDescriptorSurfaceGGP instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-ios-surface (instance view &key
				      (next *vk-nullptr*)
				      (flags 0)
				      (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'ios-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'ios-surface-create-info)
	  (list :structure-type-ios-surface-create-info-mvk
		next
		flags
		view))
    (check-result (vkCreateIOSSurfaceMVK instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-macos-surface (instance view &key
					(next *vk-nullptr*)
					(flags 0)
					(allocator *vk-nullptr*))
  (with-foreign-objects ((info 'mac-os-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'mac-os-surface-create-info)
	  (list :structure-type-macos-surface-create-info-mvk
		next
		flags
		view))
    (check-result (vkCreateMacOSSurfaceMVK instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-vi-surface (instance window &key
				     (next *vk-nullptr*)
				     (flags 0)
				     (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'vi-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'vi-surface-create-info)
	  (list :structure-type-vi-surface-create-info-nn
		next
		flags
		window))
    (check-result (vkCreateViSurfaceNN instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-metal-surface (instance layer &key
					(next *vk-nullptr*)
					(flags 0)
					(allocator *vk-nullptr*))
  (with-foreign-objects ((info 'metal-surfaec-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'metal-surfaec-create-info)
	  (list :structure-type-metal-surface-create-info-ext
		next
		flags
		layer))
    (check-result (vkCreateMetalSurfaceEXT instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-display-plane-surface (instance
				     display-mode
				     plane-index
				     plane-stack-index
				     transform
				     global-alpha
				     alpha-mode
				     extent-2d
				     &key
				       (next *vk-nullptr*)
				       (flags 0)
				       (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'display-plane-surface-create-info)
			 (surface 'vk-surface-khr))
    (setf (mem-ref info 'display-plane-surface-create-info)
	  (list :structure-type-display-surface-create-info-khr
		next
		flags
		display-mode
		plane-index
		plane-stack-index
		transform
		global-alpha
		alpha-mode
		extent-2d))
    (check-result (vkCreateDisplayPlaneSurfaceKHR instance info allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun destroy-surface (instance surface &optional (allocator *vk-nullptr*))
  (vkDestroySurfaceKHR instance surface allocator))

(defun create-swapchain (device surface &key
					  (info-next *vk-nullptr*)
					  (info-flags 0)
					  (info-min-image-count 0)
					  (info-image-format :format-r8g8b8a8-srgb)
					  (info-image-color-space :color-space-srgb-nonlinear-khr)
					  (info-image-extent (make-lsp-extent-2d :width 600
										 :height 600))
					  (info-image-array-layers 1)
					  (info-image-usage :image-usage-color-attachment-bit)
					  (info-image-sharing-mode :sharing-mode-exclusive)
					  (info-queue-family-indices nil)
					  (info-pre-transform :surface-transform-identity-bit-khr)
					  (info-composite-alpha :composite-alpha-opaque-bit-khr)
					  (info-present-mode :present-mode-fifo-khr)
					  (info-clipped +vk-true+)
					  (info-old-swapchain *vk-nullptr*)
					  (allocator *vk-nullptr*))
  (let ((indices-count (length info-queue-family-indices)))
    (with-foreign-objects ((info 'swapchain-create-info)
			   (swapchain 'vk-swapchain-khr)
			   (indicate :uint32 indices-count))
      (when info-queue-family-indices
	(loop for i upto (1- indices-count)
	      do (setf (mem-ref indicate :uint32 i)
		       (nth i info-queue-family-indices))))
      (unless (lsp-extent-2d-p info-image-extent)
	(error "error type of info image extent is not type of extent 2d"))
      (setf (mem-ref info 'swapchain-create-info)
	    (list :structure-type-swapchain-create-info-khr 
		  info-next                                 
		  info-flags                                
		  surface                                   
		  info-min-image-count                      
		  info-image-format                         
		  info-image-color-space                    
		  (list (lsp-extent-2d-width info-image-extent)   
			(lsp-extent-2d-height info-image-extent))
		  info-image-array-layers
		  info-image-usage
		  info-image-sharing-mode
		  indices-count
		  indicate
		  info-pre-transform
		  info-composite-alpha
		  info-present-mode
		  info-clipped
		  info-old-swapchain))
      (check-result (vkCreateSwapchainKHR device info allocator swapchain))
      (mem-ref swapchain 'vk-swapchain-khr))))

(defun destroy-swapchain (device swapchain &optional (allocator *vk-nullptr*))
  (vkDestroySwapchainKHR device swapchain allocator))

(defun create-image-view (device image &key
					 (info-next *vk-nullptr*)
					 (info-flags 0)
					 (info-view-type :image-view-type-2d)
					 (info-format :format-r8g8b8a8-srgb)
					 (info-components (make-lsp-component-mapping))
					 (info-subresource-range (make-lsp-image-subresource-range))
					 (allocator *vk-nullptr*))
  (with-foreign-objects ((info 'image-view-create-info)
			 (image-view 'vk-image-view))
    (when (and (lsp-component-mapping-p info-components)
	       (lsp-image-subresource-range-p info-subresource-range))
      (setf (mem-ref info 'image-view-create-info)
	  (list :structure-type-image-view-create-info
		info-next
		info-flags
		image
		info-view-type
		info-format
		(list (lsp-component-mapping-r info-components)
		      (lsp-component-mapping-g info-components)
		      (lsp-component-mapping-b info-components)
		      (lsp-component-mapping-a info-components))
		(list (lsp-image-subresource-range-aspect-mask info-subresource-range)
		      (lsp-image-subresource-range-base-mip-level info-subresource-range)
		      (lsp-image-subresource-range-level-count info-subresource-range)
		      (lsp-image-subresource-range-base-array-layer info-subresource-range)
		      (lsp-image-subresource-range-layer-count info-subresource-range))))
          (check-result (vkCreateImageView device info allocator image-view))
	  (mem-ref image-view 'vk-image-view))))

(defun destroy-image-view (device image-view &optional (allocator *vk-nullptr*))
  (vkDestroyImageView device image-view allocator))

(defun create-shader-module (device file-path &key
						(info-next *vk-nullptr*)
						(info-flags 0)
						(allocator *vk-nullptr*))
  (with-open-file (in file-path :element-type '(unsigned-byte 8))
    (let ((size (file-length in)))
      (with-foreign-pointer (ptr size)
	(loop for i from 0 below size
	      do (setf (mem-ref (inc-pointer ptr i) :uint8)
		       (read-byte in nil)))
	(with-foreign-objects ((shader-module 'vk-shader-module)
			       (info 'shader-module-create-info))
	  (setf (mem-ref info 'shader-module-create-info)
		(list :structure-type-shader-module-create-info
		      info-next
		      info-flags
		      size
		      ptr))
	  (check-result (vkCreateShaderModule device info allocator shader-module))
	  (mem-ref shader-module 'vk-shader-module))))))

(defun destroy-shader-module (device shader-module &optional (allocator *vk-nullptr*))
  (vkDestroyShaderModule device shader-module allocator))

(defun create-pipeline-layout (device &key
					(info-next *vk-nullptr*)
					(info-flags 0)
					(info-layouts nil)
					(info-constant-ranges nil)
					(allocator *vk-nullptr*))
  (let ((set-layout-count (length info-layouts))
	(constant-range-count (length info-constant-ranges)))
    (with-foreign-objects ((info 'pipeline-layout-create-info)
			   (set-layouts 'vk-descriptor-set-layout set-layout-count)
			   (constant-ranges 'push-constant-range constant-range-count)
			   (layout 'vk-pipeline-layout))
      (when info-layouts
	(loop for layout in info-layouts
	      for i from 0
	      do (setf (mem-aref set-layouts 'vk-descriptor-set-layout i)
		       layout)))
      (when info-constant-ranges
	(loop for range in info-constant-ranges
	      for i from 0
	      for s-obj = (nth i info-constant-ranges)
	      do (if (lsp-push-constant-range-p s-obj)
		     (setf (mem-aref set-layouts 'push-constant-range i)
			   (list (lsp-push-constant-range-stage-flags s-obj)
				 (lsp-push-constant-range-offset s-obj)
				 (lsp-push-constant-range-size s-obj)))
		     (error "type error constant range is not type of lsp-pysg-constant-range"))))
      (setf (mem-ref info 'pipeline-layout-create-info)
	    (list :structure-type-pipeline-layout-create-info
		  info-next
		  info-flags
		  set-layout-count
		  set-layouts
		  constant-range-count
		  constant-ranges))
      (check-result (vkCreatePipelineLayout device info allocator layout))
      (mem-ref layout 'vk-pipeline-layout))))

(defun destroy-pipeline-layout (device pipeline-layout &optional (allocator *vk-nullptr*))
  (vkDestroyPipelineLayout device pipeline-layout allocator))

(defun create-graphics-pipeline (device ))
(defun destroy-graphics-pipeline (device))
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

(defun enumerate-instance-version ()
  (with-foreign-object (version :uint32)
    (check-result (vkEnumerateInstanceVersion version))
    (mem-ref version :uint32)))

(defun get-physical-device-image-format-properties (physical-device &key
								      (format :format-undefined)
								      (type :image-type-2d)
								      (tiling :image-tiling-linear)
								      (usage-flag 0)
								      (create-flag 0))
  (with-foreign-object (properties 'image-format-properties)
    (check-result (vkGetPhysicalDeviceImageFormatProperties physical-device
							    format
							    type
							    tiling
							    usage-flag
							    create-flag
							    properties))
    (mem-ref properties 'image-format-properties)))

(defun get-device-memory-commitment (device device-memory)
  (with-foreign-object (size 'vk-device-size)
    (vkGetDeviceMemoryCommitment device device-memory size)
    (mem-ref size 'vk-device-size)))

(defun get-physical-device-surface-capabilities (physical-device surface)
  (with-foreign-object (cap 'surface-capabilities)
    (check-result (vkGetPhysicalDeviceSurfaceCapabilitiesKHR physical-device surface cap))
    (mem-ref cap 'surface-capabilities)))

(defun get-physical-device-surface-format (physical-device surface)
  (with-foreign-object (count :uint32)
    (check-result (vkGetPhysicalDeviceSurfaceFormatsKHR physical-device
							surface
							count
							*vk-nullptr*))
    (let ((num (mem-ref count :uint32)))
      (unless (zerop num)
	(with-foreign-object (format 'surface-formt num)
	  (check-result (vkGetPhysicalDeviceSurfaceFormatsKHR physical-device
							surface
							count
							format))
	  (obj->list format 'surface-formt count))))))

(defun get-physical-device-surfaec-present-mode (physical-device surface)
  (with-foreign-object (count :uint32)
    (check-result (vkGetPhysicalDeviceSurfacePresentModesKHR physical-device
							     surface
							     count
							     *vk-nullptr*))
    (let ((num (mem-ref count :uint32)))
      (unless (zerop num)
	(with-foreign-object (mode 'VkPresentModeKHR num)
	  (check-result (vkGetPhysicalDeviceSurfacePresentModesKHR physical-device
							surface
							count
							mode))
	  (obj->list mode 'VkPresentModeKHR count))))))

(defun get-device-queue (device family-index index)
  (with-foreign-object (queue 'vk-queue)
    (vkGetDeviceQueue device family-index index queue)
    (mem-ref queue 'vk-queue)))

(defun get-swapchain-images (device swapchain)
  (with-foreign-object (count :uint32)
    (check-result (vkGetSwapchainImagesKHR device swapchain count *vk-nullptr*))
    (let ((num (mem-ref count :uint32)))
      (with-foreign-object (images 'vk-image num)
	(check-result (vkGetSwapchainImagesKHR device swapchain count images))
	(obj->list images 'vk-image count)))))
