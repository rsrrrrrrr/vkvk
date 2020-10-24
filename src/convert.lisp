(in-package :vkvk)

(defun parse-foreign-type (lst)
  (declare (optimize (speed 3)))
  (coerce lst 'vector))

(define-foreign-type application-info-type ()
  ()
  (:actual-type :struct vk-application-info)
  (:simple-parser app-info))

(defmethod translate-from-foreign (ptr (type application-info-type))
  (with-foreign-slots ((type
			next
			application-name
			application-version
			engine-name
			engine-version
			api-version)
		       ptr
		       (:struct vk-application-info))
    (list type
	  next
	  application-name
	  application-version
	  engine-name
	  engine-version
	  api-version)))

(defmethod translate-into-foreign-memory (value (type application-info-type) ptr)
  (with-foreign-slots ((type
			next
			application-name
			application-version
			engine-name
			engine-version
			api-version)
		       ptr
		       (:struct vk-application-info))
    (setf type :structure-type-application-info
	  next (aref value 0)
	  application-name (convert-to-foreign (aref value 1) :string)
	  application-version (aref value 2)
	  engine-name (convert-to-foreign (aref value 3) :string)
	  engine-version (aref value 4)
	  api-version (aref value 5))))

(define-foreign-type instance-info-type ()
  ()
  (:actual-type :struct vk-instance-create-info)
  (:simple-parser instance-info))

(defmethod translate-from-foreign (ptr (type instance-info-type))
  (with-foreign-slots ((type
			next
			flags
			application-info
			enable-layer-count
			enable-layer-names
			enable-extension-count
			enable-extension-names)
		       ptr
		       (:struct vk-instance-create-info))
    (list type
	  next
	  flags
	  (mem-ref application-info 'app-info)
	  enable-layer-names
	  enable-layer-count
	  enable-extension-names
	  enable-layer-count)))
#|
(defmethod transloat-into-foreign-memory (value (type instance-info-type))
  (with-foreign-slots ((type
			next
			flags
			application-info
			enable-layer-count
			enable-layer-names
			enable-extension-count
			enable-extension-names)
		       ptr
		       (:struct vk-instance-create-info))
    (setf type :structure-type-instance-create-info
	  next (aref value 0)
	  flags (aref value 1)
	  application-info (aref value 2)  ;;pointer
	  enable-layer-count ()
	  enable-layer-names
	  enable-extension-count
	  enable-extension-names)))
|#
