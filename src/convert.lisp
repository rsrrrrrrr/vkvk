(in-package :vkvk)

(defun to-array-type (lst)
  (declare (optimize (speed 3)))
  (coerce lst 'vector))

(defun c-array->string (point)
  "conver the char[] to lisp string"
  (loop for i upto 255
	for c = (code-char (mem-aref point :char i))
	until (not (or (alpha-char-p c) (char= #\Space c) (char= #\_ c)))
	collect c into lstr
	finally
	   (return  (concatenate 'string lstr))))

(define-foreign-type layer-properties-info ()
  ()
  (:actual-type :struct vk-layer-properties)
  (:simple-parser layer-properties))

(defmethod translate-from-foreign (ptr (type layer-properties-info))
  (with-foreign-slots ((layer-name
			spec-version
			implementation-version
			description)
		       ptr
		       (:struct vk-layer-properties))
    (list :layer (c-array->string layer-name)
	  :version spec-version
	  :implementation-version implementation-version
	  :dsc (c-array->string description))))

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

(defmethod translate-into-foreign-memory (value (type instance-info-type) ptr)
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
    (let* ((usable-extensions (select-usable (aref value 3)
					     (get-instance-extensions)))
	   (usable-layers (select-usable (aref value 4)
					 (get-instance-layers)))
	   (ext-count (length usable-layers))
	   (lay-count (length usable-extensions)))
      (with-foreign-objects ((layers :string lay-count)
			     (extensions :string ext-count))
	(loop for i upto (1- lay-count)
	      do (setf (mem-aref layers :string i)
		       (elt usable-layers i)))
	(loop for i upto (1- ext-count)
	      do (setf (mem-aref extensions :string i)
		       (elt usable-extensions i)))
	(setf type :structure-type-instance-create-info
	      next (aref value 0)
	      flags (aref value 1)
	      application-info (aref value 2)  ;;pointer
	      enable-layer-count lay-count
	      enable-layer-names layers
	      enable-extension-count ext-count
	      enable-extension-names extensions)))))