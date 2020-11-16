(in-package :vkvk)

(export '(create-graphics-pipeline-shader-stage-specialization
	  create-graphics-pipeline-shader-stage
	  destroy-graphics-pipeline-shader-stage
	  create-graphics-pipeline-vertex-input-state
	  destroy-graphics-pipeline-vertex-input-state))

;;as you create a pipeline you shoud 
;;  create-graphics-pipeline-shader-stage-specialization
;;  create-graphics-pipeline-shader-stage

;;pipeline shader stage info
(defvar *shader-stages* nil)
(defun create-graphics-pipeline-shader-stage-specialization (&key
							       (map-entries nil)  ;;lsp-specialization-map-entry
							       (data-size 0)
							       (data *vk-nullptr*))
  (let* ((entry-count (length map-entries))
	 (p-entries (foreign-alloc 'specialization-map-entry :count entry-count))
	 (p-specialization-map-entries (foreign-alloc 'specialization-info)))
    (push p-entries *shader-stages*)
    (push p-specialization-map-entries *shader-stages*)
    (loop for entry in map-entries
	  for i from 0
	  unless (lsp-specialization-map-entry-p entry)
	    do (error "entry type is not lsp-specialization-map-entry")
	  do (setf (mem-aref p-entries 'specialization-map-entry i)
		   (list (lsp-specialization-map-entry-constant-id entry)
			 (lsp-specialization-map-entry-offset entry)
			 (lsp-specialization-map-entry-size entry))))
    (setf (mem-ref p-specialization-map-entries 'specialization-info)
	  (list entry-count
		p-entries
		data-size
		data))
    p-specialization-map-entries))
(defun create-graphics-pipeline-shader-stage (shader-module &key
							      (next *vk-nullptr*)
							      (flags 0)
							      (stage :shader-stage-vertex-bit)
							      (name "main")
							      (specialization-info nil))
  "return a c VkPipelineShaderStageCreateInfo pointer"
  (let ((p-shader-stage (foreign-alloc 'pipeline-shader-stage-create-info)))
    (push p-shader-stage *shader-stages*)
    (setf (mem-ref p-shader-stage 'pipeline-shader-stage-create-info)
	  (list :structure-type-pipeline-shader-stage-create-info
		next
		flags
		stage
		shader-module
		name
		specialization-info))))

(defun destroy-graphics-pipeline-shader-stage ()
  ;;will free after create-graphics-pipeline
  (unless (null *shader-stages*)
    (mapcar #'foreign-free *shader-stages*)
    (setf *shader-stages* nil)))

;;pipeline vertex input state info
(defvar *vertex-input-state* nil)
(defun create-graphics-pipeline-vertex-input-state (&key
						      (next *vk-nullptr*)
						      (flags 0)
						      (vertex-binding-descriptions nil)
						      (vertex-attribute-descriptions nil))
  (let* ((binding-count (length vertex-binding-descriptions))
	 (attribute-count (length vertex-attribute-descriptions))
	 (p-binding-descriptions (foreign-alloc 'vertex-input-binding-description :count binding-count))
	 (p-attribute-descriptions (foreign-alloc 'vertex-input-attribute-description :count attribute-count))
	 (p-vertex-input-state (foreign-alloc 'pipeline-vertex-input-state-create-info)))
    (push p-binding-descriptions *vertex-input-state*)
    (push p-attribute-descriptions *vertex-input-state*)
    (push p-vertex-input-state *vertex-input-state*)
    (loop for desc in vertex-binding-descriptions
	  for i from 0
	  unless (lsp-vertex-input-binding-description-p desc)
	    do (error "desc type is not lsp-vertex-input-binding-description")
	  do (setf (mem-aref p-binding-descriptions 'vertex-input-binding-description i)
		   (list (lsp-vertex-input-binding-description-binding desc)
			 (lsp-vertex-input-binding-description-stride desc)
			 (lsp-vertex-input-binding-description-input-rage desc))))
    (loop for desc in vertex-attribute-descriptions
	  for i from 0
	  unless (lsp-vertex-input-attribute-description-p desc)
	    do (error "desc type is not lsp-vertex-input-attribute-description")
	  do (setf (mem-aref p-attribute-descriptions 'vertex-input-attribute-description i)
		   (list (lsp-vertex-input-attribute-description-location desc)
			 (lsp-vertex-input-attribute-description-binding desc)
			 (lsp-vertex-input-attribute-description-format desc)
			 (lsp-vertex-input-attribute-description-offset desc))))
    (setf (mem-ref p-vertex-input-state 'pipeline-vertex-input-state-create-info)
	  (list :structure-type-pipeline-vertex-input-state-create-info
		next
		flags
		binding-count
		p-binding-descriptions
		attribute-count
		p-attribute-descriptions))
    p-binding-descriptions))
(defun destroy-graphics-pipeline-vertex-input-state ()
  (unless (null *vertex-input-state*)
    (mapcar #'foreign-free *vertex-input-state*)
    (setf *vertex-input-state* nil)))
