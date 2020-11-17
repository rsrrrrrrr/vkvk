(in-package :vkvk)

(export '(create-graphics-pipeline-shader-stage-specialization
	  create-graphics-pipeline-shader-stage
	  destroy-graphics-pipeline-shader-stage
	  create-graphics-pipeline-vertex-input-state
	  destroy-graphics-pipeline-vertex-input-state
	  create-graphics-pipeline-input-assembly-state
	  destroy-graphics-pipeline-input-assembly-state
	  create-graphics-pipeline-tessellation-state
	  destroy-graphics-pipeline-tessellation-state
	  create-graphics-pipeline-viewport-state
	  destroy-graphics-pipeline-viewport-state
	  create-graphics-pipeline-rasterization-state
	  destroy-graphics-pipeline-rasterization-state
	  create-graphics-pipeline-multisample-state
	  destroy-graphics-pipeline-multisample-state
	  create-graphics-pipeline-depth-stencil-state
	  destroy-graphics-pipeline-depth-stencil-state))

;;as you create a pipeline you shoud 
;;  create-graphics-pipeline-shader-stage-specialization
;;  create-graphics-pipeline-shader-stage

;;pipeline shader stage info
(defparameter *shader-stages* nil)
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
(defparameter *vertex-input-state* nil)
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

;;pipeline input assembly state
(defparameter *assembly-state* nil)
(defun create-graphics-pipeline-input-assembly-state (&key
							(next *vk-nullptr*)
							(flags 0)
							(topology :primitive-topology-point-list)
							(enable +vk-false+))
  (let ((p-assembly (foreign-alloc 'pipeline-input-assembly-state-create-info)))
    (push p-assembly *assembly-state*)
    (setf (mem-ref p-assembly 'pipeline-input-assembly-state-create-info)
	  (list :structure-type-pipeline-input-assembly-state-create-info
		next
		flags
		topology
		enable))
    p-assembly))
(defun destroy-graphics-pipeline-input-assembly-state ()
  (unless (null *assembly-state*)
    (mapcar #'foreign-free *assembly-state*)
    (setf *assembly-state* nil)))

;;pipeline tessellation state
(defparameter *tessellation-state* nil)
(defun create-graphics-pipeline-tessellation-state (&key
						      (next *vk-nullptr*)
						      (flags 0)
						      (control-points 0))
  (let ((p-tessellation (foreign-alloc 'pipeline-tessellation-state-create-info)))
    (push p-tessellation *tessellation-state*)
    (setf (mem-ref p-tessellation 'pipeline-tessellation-state-create-info)
	  (list :structure-type-pipeline-tessellation-state-create-info
		next
		flags
		control-points))
    p-tessellation))
(defun destroy-graphics-pipeline-tessellation-state ()
  (unless (null *tessellation-state*)
    (mapcar #'foreign-free *assembly-state*)
    (setf *tessellation-state* nil)))

;;pipeline viewport
(defparameter *viewport-state* nil)
(defun create-graphics-pipeline-viewport-state (&key
						  (next *vk-nullptr*)
						  (flags 0)
						  (viewports nil)
						  (scissors nil))
  (let* ((viewport-count (length viewports))
	 (scissor-count (length scissors))
	 (p-viewport (foreign-alloc 'viewport :count viewport-count))
	 (p-scissor (foreign-alloc 'rect-2d :count scissor-count))
	 (p-viewport-state (foreign-alloc 'pipeline-viewport-state-create-info)))
    (push p-viewport *viewport-state*)
    (push p-scissor *viewport-state*)
    (push p-viewport-state *viewport-state*)
    ;;porcess p-viewport
    (loop for vp in viewports
	  for i from 0
	  unless (lsp-viewport-p vp)
	    do (error "vp type is not lsp-viewport")
	  do (setf (mem-aref p-viewport 'viewport i)
		   (list (lsp-viewport-x vp)
			 (lsp-viewport-y vp)
			 (lsp-viewport-width vp)
			 (lsp-viewport-height vp)
			 (lsp-viewport-min-depth vp)
			 (lsp-viewport-max-depth vp))))
    (loop for rect in scissors
	  for i from 0
	  unless (lsp-rect-2d-p rect)
	    do (error "scissors is not type of lsp-rect-2d")
	  do (setf (mem-aref p-scissor 'rect-2d i)
		   (list (list (lsp-offset-2d-x (lsp-rect-2d-offset rect))
			       (lsp-offset-2d-y (lsp-rect-2d-offset rect)))
			 (list (lsp-extent-2d-width (lsp-rect-2d-extent rect))
			       (lsp-extent-2d-height (lsp-rect-2d-extent rect))))))
    (setf (mem-ref p-viewport-state 'pipeline-viewport-state-create-info)
	  (list :structure-type-pipeline-viewport-state-create-info
		next
		flags
		viewport-count
		p-viewport
		scissor-count
		p-scissor))
    p-viewport-state))
(defun destroy-graphics-pipeline-viewport-state ()
  (unless (null *viewport-state*)
    (mapcar #'foreign-free *viewport-state*)
    (setf *viewport-state* nil)))

;;pipeline rsterization state
(defparameter *rasterization-state* nil)
(defun create-graphics-pipeline-rasterization-state (&key
						       (next *vk-nullptr*)
						       (flags 0)
						       (depth-clamp-enable +vk-false+)
						       (rasterizer-discard-enable +vk-false+)
						       (pology-mode :polygon-mode-point)
						       (cull-mode :cull-mode-none)
						       (front-face :front-face-clockwise)
						       (depth-bias-enable +vk-false+)
						       (depth-bias-constant-factor 0.0)
						       (depth-bias-clamp 0.0 )
						       (depth-bias-slop-factor 0.0)
						       (depth-bias-line-width 0.0))
  (let ((p-rasterization (foreign-alloc 'pipeline-rasterization-state-create-info)))
    (push p-rasterization *rasterization-state*)
    (setf (mem-ref p-rasterization 'pipeline-rasterization-state-create-info)
	  (list :structure-type-pipeline-rasterization-state-create-info
		next
		flags
		depth-clamp-enable
		rasterizer-discard-enable
		pology-mode
		cull-mode
		front-face
		depth-bias-enable
		depth-bias-constant-factor
		depth-bias-clamp
		depth-bias-slop-factor
		depth-bias-line-width))
    p-rasterization))
(defun destroy-graphics-pipeline-rasterization-state ()
  (unless (null *rasterization-state*)
    (mapcar #'foreign-free *rasterization-state*)
    (setf *rasterization-state* nil)))

;;pipeline multisample state
(defparameter *multisample-state* nil)
(defun create-graphics-pipeline-multisample-state (&key
						     (next *vk-nullptr*)
						     (flags 0)
						     (rasterization-samples :sample-count-1-bit)
						     (sample-shading-enable +vk-false+)
						     (min-sample-shading 0.0)
						     (sample-mask nil)
						     (alpha-to-coverage-enable +vk-false+)
						     (alpha-to-one-enable +vk-false+))
  (let* ((mask-count (length sample-mask))
	 (p-sample-mask (foreign-alloc 'vk-sample-mask :count mask-count))
	 (p-multisample (foreign-alloc 'pipeline-multisample-state-create-info)))
    (push p-sample-mask *multisample-state*)
    (push p-multisample *multisample-state*)
    (loop for mask in sample-mask
	  for i from 0
	  do (setf (mem-aref p-sample-mask 'vk-sample-mask i)
		   mask))
    (setf (mem-ref p-multisample 'pipeline-multisample-state-create-info)
	  (list :structure-type-pipeline-multisample-state-create-info
		next
		flags
		rasterization-samples
		sample-shading-enable
		min-sample-shading
		p-sample-mask
		alpha-to-coverage-enable
		alpha-to-one-enable))
    p-multisample))
(defun destroy-graphics-pipeline-multisample-state ()
  (unless (null *multisample-state*)
    (mapcar #'foreign-free *multisample-state*)
    (setf *multisample-state* nil)))

;;pipeline depth stencil state
(defparameter *depth-stencil-state* nil)
(defun create-graphics-pipeline-depth-stencil-state (&key
						       (next *vk-nullptr*)
						       (flags 0)
						       (depth-test-enable +vk-false+)
						       (depth-write-enable +vk-false+)
						       (depth-compare-op :compare-op-equal)
						       (depth-bound-test-enable +vk-false+)
						       (stencil-test-enable +vk-false+)
						       (front nil)  ;;stencil-op-state
						       (back nil)   ;;stencil-op-state
						       (min-depth-bounds 0.0)
						       (max-depth-bounds 0.0))
  (let ((p-depth-stencil (foreign-alloc 'pipeline-depth-stencil-state-create-info)))
    (push p-depth-stencil *depth-stencil-state*)
    (if (and (lsp-stencil-op-state-p front)
	     (lsp-stencil-op-state-p back))
	(setf (mem-ref p-depth-stencil 'pipeline-depth-stencil-state-create-info)
	  (list :structure-type-pipeline-depth-stencil-state-create-info
		next
		flags
		depth-test-enable
		depth-write-enable
		depth-compare-op
		depth-bound-test-enable
		stencil-test-enable
		(list (lsp-stencil-op-state-fail-op front)
		      (lsp-stencil-op-state-pass-op front)
		      (lsp-stencil-op-state-depth-fail-op front)
		      (lsp-stencil-op-state-compare-op front)
		      (lsp-stencil-op-state-compare-mask front)
		      (lsp-stencil-op-state-write-mask front)
		      (lsp-stencil-op-state-references front))
		(list (lsp-stencil-op-state-fail-op back)
		      (lsp-stencil-op-state-pass-op back)
		      (lsp-stencil-op-state-depth-fail-op back)
		      (lsp-stencil-op-state-compare-op back)
		      (lsp-stencil-op-state-compare-mask back)
		      (lsp-stencil-op-state-write-mask back)
		      (lsp-stencil-op-state-references back))
		min-depth-bounds
		max-depth-bounds))
	(error "front or back type is not lsp-stencil-op-state"))))
(defun destroy-graphics-pipeline-depth-stencil-state ()
  (unless (null *depth-stencil-state*)
    (mapcar #'foreign-free *depth-stencil-state*)
    (setf *depth-stencil-state* nil)))
