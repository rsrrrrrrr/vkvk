(in-package :vkvk)

(export '(select-queue
	  get-present-queues
	  get-usable-device-extensions
	  get-usable-device-layers
	  get-usable-instance-extensions
	  get-usable-instance-layers))

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

(defun create-specialization-info (&key
				     (map-entrys nil)
				     (data-size 0)
				     (data *vk-nullptr*))
  (list :entry-count (length map-entrys)
	:entries (loop for obj in map-entrys
		       unless (lsp-specialization-map-entry-p obj)
			 do (error "obj type is not specialization map entry")
		       collect (list :constant-id (lsp-specialization-map-entry-constant-id obj)
				     :offset (lsp-specialization-map-entry-offset obj)
				     :size (lsp-specialization-map-entry-size obj)))
	:data-size data-size
	:data data))

(defun create-pipeline-shader-stage (module &key
					      (next *vk-nullptr*)
					      (flags 0)
					      (stage :shader-stage-all)
					      (name "main")
					      (specialization-info nil))
  (list :type :structure-type-pipeline-shader-stage-create-info
	:next next
	:flags flags
	:stage stage
	:module module
	:name name
	:specialization-info specialization-info))

(defun create-pipeline-vertex-input-state (&key
					     (next *vk-nullptr*)
					     (flags 0)
					     (vertex-input-binding-description nil)
					     (vertex-input-attribute-description nil))
  (list :type :structure-type-pipeline-vertex-input-state-create-info
	:next next 
	:flags flags
	:vertex-binding-description-count (length vertex-input-binding-description)
	:vertex-binding-description (loop for obj in vertex-input-binding-description
					  unless (lsp-vertex-input-binding-description-p obj)
					    do (error "obj type is not vertex input-binding description")
					  collect (list :binding (lsp-vertex-input-binding-description-binding obj)
							:stride (lsp-vertex-input-binding-description-stride obj)
							:input-rage (lsp-vertex-input-binding-description-input-rage obj)))
	:vertex-attribute-description-count (length vertex-input-attribute-description)
	:vertex-attribute-description (loop for obj in vertex-input-attribute-description
					    unless (lsp-vertex-input-attribute-description-p obj)
					      do (error "obj type is not vertex attribute description")
					    collect (list :location (lsp-vertex-input-attribute-description-location obj)
							  :binding (lsp-vertex-input-attribute-description-binding obj)
							  :format (lsp-vertex-input-attribute-description-format obj)
							  :offset (lsp-vertex-input-attribute-description-offset obj)))))

(defun create-pipeline-input-assembly-state (&key
					       (next *vk-nullptr*)
					       (flags 0)
					       (topology :primitive-restart-enable)
					       (enable 0))
  (list :type :structure-type-pipeline-input-assembly-state-create-info
	:next next
	:flags flags
	:topology topology
	:primitive-restart-enable enable))

(defun create-pipeline-tessellation-state (&key
					     (next *vk-nullptr*)
					     (flags 0)
					     (patch-control-points 0))
  (list :type :structure-type-pipeline-tessellation-state-create-info
	:next next
	:flags flags
	:patch-control-points patch-control-points))

(defun create-pipeline-viewport-state (&key
				(next *vk-nullptr*)
				(flags 0)
				(viewport nil)
				(scissor nil))
  (list :type :structure-type-pipeline-viewport-state-create-info
	:next next
	:flags flags
	:viewport-count (length viewport)
	:viewports (loop for obj in viewport
			 unless (lsp-viewport-p obj)
			   do (error "obj type is not view port")
			 collect (list :x (lsp-viewport-x obj)
				       :y (lsp-viewport-y obj)
				       :width (lsp-viewport-width obj)
				       :height (lsp-viewport-height obj)
				       :min-depth (lsp-viewport-min-depth obj)
				       :max-depth (lsp-viewport-max-depth obj)))
	:scissor-count (length scissor)
	:scissprs (loop for obj in scissor
			unless (lsp-rect-2d-p obj)
			  do (error "obj type is not rect 2d")
			collect (list :offset (list :x (lsp-offset-2d-x (lsp-rect-2d-offset obj))
						    :y (lsp-offset-2d-y (lsp-rect-2d-offset obj)))
				      :extent (list :width (lsp-extent-2d-width (lsp-rect-2d-extent obj))
						    :height (lsp-extent-2d-height (lsp-rect-2d-extent obj)))))))

(defun create-pipeline-rasterization-state (&key
					      (next *vk-nullptr*)
					      (flags 0)
					      (depth-clamp-enable +vk-false+)
					      (rasterizer-discard-enable +vk-false+)
					      (polygon-mode :polygon-mode-line)
					      (cull-mode 0)
					      (front-face :front-face-clockwise)
					      (depth-bias-enable +vk-false+)
					      (depth-bias-constant-factor 0.0)
					      (depth-bias-clamp 0.0)
					      (depth-bias-slope-factor 0.0)
					      (line-width 0.0))
  (list :type :structure-type-pipeline-rasterization-state-create-info
	:next next
	:flags flags
	:depth-clamp-enable depth-clamp-enable
	:rasterizer-discard-enable rasterizer-discard-enable
	:polygon-mode polygon-mode
	:cull-mode cull-mode
	:front-face front-face
	:depth-bias-enable depth-bias-enable
	:depth-bias-constant-factor depth-bias-constant-factor
	:depth-bias-clamp depth-bias-clamp
	:depth-bias-slope-factor depth-bias-slope-factor
	:line-width line-width))

(defun create-pipeline-multisample-state (&key
					    (next *vk-nullptr*)
					    (flags 0)
					    (rasterization-sample :sample-count-1-bit)
					    (sample-shading-enable +vk-false+)
					    (min-sample-shading 0.0)
					    (sample-mask 0)
					    (alpha-to-coverage-enable +vk-false+)
					    (alpha-to-one-enable +vk-false+))
  (list :type :structure-type-pipeline-multisample-state-create-info
	:next next
	:flags flags
	:rasterization-sample rasterization-sample
	:sample-shading-enable sample-shading-enable
	:min-sample-shading min-sample-shading
	:sample-mask sample-mask
	:alpha-to-coverage-enable alpha-to-coverage-enable
	:alpha-to-one-enable alpha-to-one-enable))

(defun create-pipeline-depth-stencil-state (&key
					      (next *vk-nullptr*)
					      (flags 0)
					      (depth-test-enable +vk-false+)
					      (depth-write-enable +vk-false+)
					      (depth-compare-op :compare-op-always)
					      (depth-bounds-test-enable +vk-false+)
					      (stencil-test-enable +vk-false+)
					      (front nil)
					      (back nil)
					      (min-depth-bounds 0.0)
					      (max-depth-bounds 0.0))
  (list :type :structure-type-pipeline-depth-stencil-state-create-info
	:next next 
	:flags flags
	:depth-test-enable depth-test-enable
	:depth-write-enable depth-write-enable
	:depth-compare-op depth-compare-op
	:depth-bounds-test-enable depth-bounds-test-enable
	:stencil-test-enable stencil-test-enable
	:front (if (lsp-stencil-op-state-p front)
		   (list :fail-op (lsp-stencil-op-state-fail-op front)
			 :pass-op (lsp-stencil-op-state-pass-op front)
			 :depth-fail-op (lsp-stencil-op-state-depth-fail-op front)
			 :compare-op (lsp-stencil-op-state-compare-op front)
			 :compare-mask (lsp-stencil-op-state-compare-mask front)
			 :write-mask (lsp-stencil-op-state-write-mask front)
			 :references (lsp-stencil-op-state-references front))
		   (error "front is not type stencil"))
	:back (if (lsp-stencil-op-state-p back)
		   (list :fail-op (lsp-stencil-op-state-fail-op back)
			 :pass-op (lsp-stencil-op-state-pass-op back)
			 :depth-fail-op (lsp-stencil-op-state-depth-fail-op back)
			 :compare-op (lsp-stencil-op-state-compare-op back)
			 :compare-mask (lsp-stencil-op-state-compare-mask back)
			 :write-mask (lsp-stencil-op-state-write-mask back)
			 :references (lsp-stencil-op-state-references back))
		   (error "back is not type stencil"))
	:min-depth-bounds min-depth-bounds
	:max-depth-bounds max-depth-bounds))

(defun create-pipeline-color-blend-state (&key
					    (next *vk-nullptr*)
					    (flags 0)
					    (logic-op-enable +vk-false+)
					    (logic-op :logic-op-and)
					    (attachments nil)
					    (blend-constants '(0.0 0.0 0.0 0.0)))
  (list :type :structure-type-pipeline-color-blend-state-create-info
	:next next
	:flags flags
	:logic-op-enable logic-op-enable
	:logic-op logic-op
	:attachment-count (length attachments)
	:attachments (loop for obj in attachments
			   unless (lsp-pipeline-color-blend-attachment-state-p obj)
			     do (error "obj is not type of pipeline color blend attachment state")
			   collect (list :blend-enable (lsp-pipeline-color-blend-attachment-state-blend-enable obj)
					 :src-color-blend-factor (lsp-pipeline-color-blend-attachment-state-src-color-blend-factor obj)
					 :dst-color-blend-factor (lsp-pipeline-color-blend-attachment-state-dst-color-blend-factor obj)
					 :color-blend-op (lsp-pipeline-color-blend-attachment-state-color-blend-op obj)
					 :src-alpha-blend-factor (lsp-pipeline-color-blend-attachment-state-src-alpha-blend-factor obj)
					 :dst-alpha-blend-factor (lsp-pipeline-color-blend-attachment-state-dst-alpha-blend-factor obj)
					 :alpha-blend-op (lsp-pipeline-color-blend-attachment-state-alpha-blend-op obj)
					 :color-write-mask (lsp-pipeline-color-blend-attachment-state-color-write-mask obj)))
	:blend-constants blend-constants))

(defun create-pipeline-dynamic-state (&key
					(next *vk-nullptr*)
					(flags 0)
					(dynamic-state nil))
  (list :type :structure-type-pipeline-dynamic-state-create-info
	:next next
	:flags flags
	:dynamic-state-count (length dynamic-state)
	:dynamic-states dynamic-state))

(defun create-graphics-pipeline-info (layout
				      render-pass
				      sub-pass
				      base-pipeline-handle
				      base-pipeline-index
				      &key
					(next *vk-nullptr*)
					(flags 0)
					(stages nil)                ;;create-pipeline-shader-stage
					(vertex-input-state nil)    ;;create-pipeline-vertex-input-state
					(input-assembly-state nil)  ;;create-pipeline-input-assembly-state
					(tessellation-state nil)    ;;create-pipeline-tessellation-state
					(viewport-state nil)        ;;create-pipeline-viewport-state
					(rasterization-state nil)   ;;create-pipeline-rasterization-state
					(multisample-state nil)     ;;create-pipeline-multisample-state
					(depth-stencil-state nil)   ;;create-pipeline-depth-stencil-state
					(color-blend-state nil)     ;;create-pipeline-color-blend-state
					(dynamic-state nil))        ;;create-pipeline-dynamic-state
  (list :type :structure-type-graphics-pipeline-create-info
	:next next
	:flags flags
	:stage-count (length stages) 
	:stages stages
	:vertex-input-state vertex-input-state
	:input-assembly-state input-assembly-state
	:tessellation-state tessellation-state
	:viewport-state viewport-state
	:rasterization-state rasterization-state
	:multisample-state multisample-state
	:depth-stencil-state depth-stencil-state
	:color-blend-state color-blend-state
	:dynamic-state dynamic-state
	:layout layout 
	:render-pass render-pass
	:subpass sub-pass
	:base-pipeline-handle base-pipeline-handle
	:base-pipeline-index base-pipeline-index))
