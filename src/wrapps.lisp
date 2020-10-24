(in-package :vkvk)

(export '(make-vulkan-version
	  get-instance-extensions
	  get-instance-layers
	  create-instance
	  destroy-instance))

(defparameter *vk-nullptr* (null-pointer))

;;no need export
(defun obj->list (objs num)
  (let ((count (1- (mem-ref num :uint32))))
    (loop for i upto count
	  collect (mem-aref objs :string i))))

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
      (obj->list exts count))))

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
