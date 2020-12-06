(in-package :vkvk)

;;intern
(defun get-obj (obj type)
  "for struct"
  (unless (eql type (first obj))
    (error "struct type check error"))
  (rest obj))

(defun get-pointer-obj (obj type)
  "for normal like enum or uint32 pointer"
  (if (or (null obj)
	  (and (consp obj)
	       (every #'(lambda (x)
			  (typep x type))
		      obj)))
      obj
      (error "the member in list is not type of ~a" type)))

(defun check-enum (obj type)
  "for one enum"
  (if (typep obj type)
      obj
      (error "check type error ~a" obj)))

(defun get-objs (objs type)
  "for struct list"
  (mapcar #'(lambda (obj)
	      (get-obj obj type))
	  objs))
;;export
(declaim (inline make-vulkan-version))
(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defun make-offset-2d (&key (x 0) (y 0))
  (cons 'offset-2d
	(list x y)))

(defun make-offset-3d (&key (x 0) (y 0) (z 0))
  (cons 'offset-3d
	(list x y z)))

(defun make-extent-2d (&key (width 0) (height 0))
  (cons 'extent-2d
	(list width height)))

(defun make-extent-3d (&key (width 0) (height 0) (depth 0))
  (cons 'extent-3d
	(list width height depth)))

(defun make-rect-2d (&key
		       (offset (make-offset-2d))
		       (extent (make-extent-2d)))
  (cons 'rect-2d
	(list (get-obj offset 'offset-2d)
	      (get-obj extent 'extent-2d))))

(defun make-viewport (&key
			(x 0.0)
			(y 0.0)
			(width 0.0)
			(height 0.0)
			(min 0.0)
			(max 0.0))
  (cons 'viewport
	(list x y
	      width height
	      min max)))

(defun make-image-subresource-range (&key
				       (aspect-mask :image-aspect-color-bit)
				       (base-mip-level 0)
				       (level-count 0)
				       (base-array-layer 0)
				       (layer-count 0))
  (cons 'image-subresource-range
	(list (check-enum aspect-mask 'VkImageAspectFlagBits)
	      base-mip-level
	      level-count
	      base-array-layer
	      layer-count)))

(defun make-application-info (&key
				(next (null-pointer))
				(app-name "vk-test")
				(app-version (make-vulkan-version 0 0 0))
				(engine-name "vk-test")
				(engine-version (make-vulkan-version 0 0 0))
				(api-version (make-vulkan-version 1 2 0))
				&aux (type :structure-type-application-info))
  (cons 'application-info
	(list type next
	      app-name app-version
	      engine-name engine-version
	      api-version)))

(defun make-instance-create-info (&key
				    (next (null-pointer))
				    (flags 0)
				    (app-info (make-application-info))
				    (layers nil)
				    (extensions nil)
				  &aux
				    (type :structure-type-instance-create-info)
				    (layer-count (length layers))
				    (extension-count (length extensions)))
  (cons 'instance-create-info
	(list type next flags
	      (get-obj app-info 'application-info)
	      layer-count layers
	      extension-count extensions)))

(defun make-device-queue-create-info (&key
					(next (null-pointer))
					(flags 0)
					(queue-family-index 0)
					(queue-count 0)
					(queue-properties 0.0)
				      &aux (type :structure-type-device-queue-create-info))
  (cons 'device-queue-create-info
	(list type next flags
	      queue-family-index
	      queue-count
	      queue-properties)))

(defun make-physical-device-features (&key
					(robust-buffer-access +vk-false+)
					(full-draw-index-uint32 +vk-false+)
					(image-cube-array +vk-false+)
					(independent-blend +vk-false+)
					(geometry-shader +vk-false+)
					(tessellation-shader +vk-false+)
					(sample-rate-shading +vk-false+)
					(dual-src-blend +vk-false+)
					(logic-op +vk-false+)
					(multi-draw-indirect +vk-false+)
					(draw-indirect-first-instance +vk-false+)
					(depth-clamp +vk-false+)
					(depth-bias-clamp +vk-false+)
					(fill-mode-non-solid +vk-false+)
					(depth-bounds +vk-false+)
					(wide-lines +vk-false+)
					(large-points +vk-false+)
					(alpha-to-one +vk-false+)
					(multi-viewport +vk-false+)
					(sampler-anisotropy +vk-false+)
					(texture-compression-etc2 +vk-false+)
					(texture-compression-astc-ldr +vk-false+)
					(texture-compression-bc +vk-false+)
					(occlusion-query-precise +vk-false+)
					(pipeline-statistics-query +vk-false+)
					(vertex-pipeline-stores-and-atomics +vk-false+)
					(fragment-stores-and-atomics +vk-false+)
					(shader-tessellation-and-geometry-point-size +vk-false+)
					(shader-image-gather-extended +vk-false+)
					(shader-storage-image-extended-formats +vk-false+)
					(shader-storage-image-multisample +vk-false+)
					(shader-storage-image-read-without-format +vk-false+)
					(shader-storage-image-write-without-format +vk-false+)
					(shader-uniform-buffer-array-dynamic-indexing +vk-false+)
					(shader-sampled-image-array-dynamic-indexing +vk-false+)
					(shader-storage-buffer-array-dynamic-indexing +vk-false+)
					(shader-storage-image-array-dynamic-indexing +vk-false+)
					(shader-clip-distance +vk-false+)
					(shader-cull-distance +vk-false+)
					(shader-float64 +vk-false+)
					(shader-int64 +vk-false+)
					(shader-int16 +vk-false+)
					(shader-resource-residency +vk-false+)
					(shader-resource-min-lod +vk-false+)
					(sparse-binding +vk-false+)
					(sparse-residency-buffer +vk-false+)
					(sparse-residency-image2-d +vk-false+)
					(sparse-residency-image3-d +vk-false+)
					(sparse-residency2-samples +vk-false+)
					(sparse-residency4-samples +vk-false+)
					(sparse-residency8-samples +vk-false+)
					(sparse-residency16-samples +vk-false+)
					(sparse-residency-aliased +vk-false+)
					(variable-multisample-rate +vk-false+)
					(inherited-queries +vk-false+))
  (cons 'physical-device-features
	(list robust-buffer-access
	      full-draw-index-uint32
	      image-cube-array
	      independent-blend
	      geometry-shader
	      tessellation-shader
	      sample-rate-shading
	      dual-src-blend
	      logic-op
	      multi-draw-indirect
	      draw-indirect-first-instance
	      depth-clamp
	      depth-bias-clamp
	      fill-mode-non-solid
	      depth-bounds
	      wide-lines
	      large-points
	      alpha-to-one
	      multi-viewport
	      sampler-anisotropy
	      texture-compression-etc2
	      texture-compression-astc-ldr
	      texture-compression-bc
	      occlusion-query-precise
	      pipeline-statistics-query
	      vertex-pipeline-stores-and-atomics
	      fragment-stores-and-atomics
	      shader-tessellation-and-geometry-point-size
	      shader-image-gather-extended
	      shader-storage-image-extended-formats
	      shader-storage-image-multisample
	      shader-storage-image-read-without-format
	      shader-storage-image-write-without-format
	      shader-uniform-buffer-array-dynamic-indexing
	      shader-sampled-image-array-dynamic-indexing
	      shader-storage-buffer-array-dynamic-indexing
	      shader-storage-image-array-dynamic-indexing
	      shader-clip-distance
	      shader-cull-distance
	      shader-float64
	      shader-int64
	      shader-int16
	      shader-resource-residency
	      shader-resource-min-lod
	      sparse-binding
	      sparse-residency-buffer
	      sparse-residency-image2-d
	      sparse-residency-image3-d
	      sparse-residency2-samples
	      sparse-residency4-samples
	      sparse-residency8-samples
	      sparse-residency16-samples
	      sparse-residency-aliased
	      variable-multisample-rate
	      inherited-queries)))

(defun make-device-create-info (&key
				  (next (null-pointer))
				  (flags 0)
				  (queue-create-infos nil)
				  (layers nil)
				  (extensions nil)
				  (enable-features (make-physical-device-features))
				&aux
				  (type :structure-type-device-create-info)
				  (queue-create-info-count (length queue-create-infos))
				  (layer-count (length layers))
				  (extension-count (length extensions)))
  (cons 'device-create-info
	(list type next flags
	      queue-create-info-count (get-objs queue-create-infos 'device-queue-create-info)
	      layer-count layers
	      extension-count extensions
	      (get-obj enable-features 'physical-device-features))))

(defun make-fence-create-info (&key
				 (next (null-pointer))
				 (flags 0)
			       &aux
				 (type :structure-type-fence-create-info))
  (cons 'fence-create-info
	(list type next flags)))

(defun make-semaphore-create-info (&key
				     (next (null-pointer))
				     (flags 0)
				   &aux
				     (type :structure-type-semaphore-create-info))
  (cons 'semaphore-create-info
	(list type next flags)))

(defun make-event-create-info (&key
				 (next (null-pointer))
				 (flags 0)
			       &aux
				 (type :structure-type-event-create-info))
  (cons 'event-create-info
	(list type next flags)))

(defun make-query-pool-create-info (&key
				      (next (null-pointer))
				      (flags 0)
				      (query-type :query-type-pipeline-statistics)
				      (query-count 0)
				      (pipeline-statistics 0)
				    &aux
				      (type :structure-type-query-pool-create-info))
  (cons 'query-pool-create-info
	(list type next flags
	      query-type query-count
	      pipeline-statistics)))

(defun make-buffer-create-info (&key
				  (next (null-pointer))
				  (flags 0)
				  (size 0)
				  (usage 0)
				  (sharing-mode :sharing-mode-concurrent)
				  (indices nil)
				&aux
				  (type :structure-type-buffer-create-info))
  (cons 'buffer-create-info
	(list type next flags
	      size usage sharing-mode
	      (length indices) (get-pointer-obj indices 'integer))))

(defun make-buffer-view-create-info (buffer &key
					      (next (null-pointer))
					      (flags 0)
					      (format :format-r8g8b8a8-sint)
					      (offset 0)
					      (range 0)
				     &aux
				       (type :structure-type-buffer-view-create-info))
  (cons 'buffer-view-create-info
	(list type next flags
	      buffer
	      format
	      offset range)))

(defun make-image-create-info (&key
				 (next (null-pointer))
				 (flags 0)
				 (image-type :image-type-1d)
				 (format :format-r8g8b8a8-sint)
				 (extent (make-extent-3d))
				 (mip-levels 0)
				 (array-layers 0)
				 (samples :sample-count-1-bit)
				 (tiling :image-tiling-linear)
				 (usage 0)
				 (sharing-mode :sharing-mode-concurrent)
				 (queue-family-indices nil)
				 (initial-layout :image-layout-color-attachment-optimal)
			       &aux
				 (type :structure-type-image-create-info))
  (cons 'image-create-info
	(list type next flags
	      image-type
	      format
	      (get-obj extent 'extent-3d)
	      mip-levels
	      array-layers
	      samples
	      tiling
	      usage
	      sharing-mode
	      (length queue-family-indices) (get-pointer-obj queue-family-indices 'integer)
	      initial-layout)))

(defun make-component-mapping (&key
				 (r :component-swizzle-identity)
				 (g :component-swizzle-identity)
				 (b :component-swizzle-identity)
				 (a :component-swizzle-identity))
  (cons 'component-mapping
	(get-pointer-obj (list r g b a) 'vk-component-swizzle)))

(defun make-image-view-create-info (image &key
					    (next (null-pointer))
					    (flags 0)
					    (view-type :image-view-type-1d)
					    (format :format-r8g8b8a8-sint)
					    (components (make-component-mapping))
					    (range (make-image-subresource-range))
				    &aux
				      (type :structure-type-image-view-create-info))
  (cons 'image-view-create-info
	(list type next flags
	      image
	      view-type format
	      (get-obj components 'component-mapping)
	      (get-obj range 'image-subresource-range))))

(defun make-shader-module-create-info (file-path &key
						   (next (null-pointer))
						   (flags 0)
				       &aux
					 (type :structure-type-shader-module-create-info))
  (with-open-file (in file-path :element-type '(unsigned-byte 8))
    (let ((size (file-length in))
	  (ptr (foreign-alloc :pointer)))
      (dotimes (i (1- size))
	(setf (mem-ref (inc-pointer ptr i) :uint8)
	      (read-byte in nil)))
      (cons 'shader-module-create-info
	    (list type next flags
		  size ptr)))))

(defun make-pipeline-cache-create-info ( &key
					   (next (null-pointer))
					   (flags 0)
					   (file-path nil)
					&aux
					  (type :structure-type-pipeline-cache-create-info))
  (if (null file-path)
      (cons 'pipeline-cache-create-info
	    (list type next flags 0 (null-pointer)))
      (with-open-file (in file-path :element-type '(unsigned-byte 8))
	(let ((size (file-length in))
	      (ptr (foreign-alloc :pointer)))
	  (dotimes (i (1- size))
	    (setf (mem-ref (inc-pointer ptr i) :uint8)
		  (read-byte in nil)))
	  (cons 'pipeline-cache-create-info
		(list type next flags
		      size ptr))))))

;;for graphics pipeline
(defun make-specialization-map-entry (&key
					(id 0)
					(offset 0)
					(size 0))
  (cons 'specialization-map-entry
	(list id offset size)))

(defun make-specialization-info (&key
				   (entries nil)
				   (file-path nil))
  (if (null file-path)
      (cons 'specialization-info
	    (list (length entries) (get-objs entries 'specialization-map-entry)
		  0 (null-pointer)))
      (with-open-file (in file-path :element-type '(unsigned-byte 8))
	(let ((size (file-length in))
	      (ptr (foreign-alloc :pointer)))
	  (dotimes (i (1- size))
	    (setf (mem-ref (inc-pointer ptr i) :uint8)
		  (read-byte in nil)))
	  (cons 'specialization-info
	    (list (length entries) (get-objs entries 'specialization-map-entry)
		  size ptr))))))

(defun make-pipeline-shader-stage-create-info (module &key
							(next (null-pointer))
							(flags 0)
							(stage :shader-stage-all-graphics)
							(name "main")
							(specialization-info nil)
					       &aux
						 (type :structure-type-pipeline-shader-stage-create-info))
  (cons 'pipeline-shader-stage-create-info
	(list type next flags
	      stage module name
	      (get-obj specialization-info 'specialization-info))))

(defun make-vertex-input-binding-description (&key
						(binding 0)
						(stride 0)
						(rate :vertex-input-rate-instance))
  (cons 'vertex-input-binding-description
	(list binding stride (check-enum rate 'vk-vertex-input-rate))))

(defun make-vertex-input-attribute-description (&key
						  (location 0)
						  (binding 0)
						  (format :format-r8g8b8a8-sint)
						  (offset 0))
  (cons 'vertex-input-attribute-description
	(list location binding (check-enum format 'vk-format) offset)))

(defun make-pipeline-vertex-input-state-create-info (&key
						       (next (null-pointer))
						       (flags 0)
						       (binding nil)
						       (attribute nil)
						     &aux
						       (type :structure-type-pipeline-vertex-input-state-create-info))
  (cons 'pipeline-vertex-input-state-create-info
	(list type next flags
	      (length binding) (get-objs binding 'vertex-input-binding-description)
	      (length attribute) (get-objs attribute 'vertex-input-attribute-description))))

(defun make-pipeline-input-assembly-state-create-info (&key
							 (next (null-pointer))
							 (flags 0)
							 (topology :primitive-topology-line-list)
							 (enable +vk-false+)
						       &aux
							 (type :structure-type-pipeline-input-assembly-state-create-info))
  (cons 'pipeline-input-assembly-state-create-info
	(list type next flags
	      (check-enum topology 'vk-primitive-topology) enable)))

(defun make-pipeline-tessellation-state-create-info (&key
						       (next (null-pointer))
						       (flags 0)
						       (points 0)
						     &aux
						       (type :structure-type-pipeline-tessellation-state-create-info))
  (cons 'pipeline-tessellation-state-create-info
	(list type next flags
	      points)))

(defun make-pipeline-viewport-state-create-info (&key
						   (next (null-pointer))
						   (flags 0)
						   (viewports (list (make-viewport)))
						   (scissors (list (make-rect-2d)))
						 &aux
						   (type :structure-type-pipeline-viewport-state-create-info))
  (cons 'pipeline-viewport-state-create-info
	(list type next flags
	      (length viewports) (get-objs viewports 'viewport)
	      (length scissors) (get-objs scissors 'rect-2d))))

(defun make-pipeline-rasterization-state-create-info (&key
							(next (null-pointer))
							(flags 0)
							(depth-clamp-enable +vk-false+)
							(rasterizer-discard-enable +vk-false+)
							(polygon-mode :polygon-mode-point)
							(cull-mode 0)
							(front-face :front-face-clockwise)
							(depth-bias-enable +vk-false+)
							(depth-bias-constant-factor 0.0)
							(depth-bias-clamp 0.0)
							(depth-bias-slope-factor 0.0)
							(line-width 0.0)
						      &aux
							(type :structure-type-pipeline-rasterization-state-create-info))
  (cons 'pipeline-rasterization-state-create-info
	(list type next flags
	      depth-clamp-enable rasterizer-discard-enable
	      (check-enum polygon-mode 'vk-polygon-mode)
	      cull-mode
	      (check-enum front-face 'vk-front-face)
	      depth-bias-enable depth-bias-constant-factor depth-bias-clamp depth-bias-slope-factor
	      line-width)))

(defun make-pipeline-multisample-state-create-info (&key
						      (next (null-pointer))
						      (flags 0)
						      (sample :sample-count-1-bit)
						      (sample-shading-enable +vk-false+)
						      (min-shading 0.0)
						      (mask 0)
						      (alpha-to-coverage-enable +vk-false+)
						      (alpha-to-one-enable +vk-false+)
						    &aux
						      (type :structure-type-pipeline-multisample-state-create-info))
  (cons 'pipeline-multisample-state-create-info
	(list type next flags
	      (check-enum sample 'vk-sample-count-flag-bits) sample-shading-enable
	      min-shading mask
	      alpha-to-coverage-enable alpha-to-one-enable)))

(defun make-stencil-op-state (&key
				(fail-op :stencil-op-zero)
				(pass-op :stencil-op-zero)
				(depth-fail-op :stencil-op-zero)
				(compare-op :compare-op-equal)
				(compare-mask 0)
				(write-mask 0)
				(references 0))
  (cons 'stencil-op-state
	(list fail-op pass-op depth-fail-op
	      compare-op compare-mask
	      write-mask references)))

(defun make-pipeline-depth-stencil-state-create-info (&key
							(next (null-pointer))
							(flags 0)
							(depth-test-enable +vk-false+)
							(depth-write-enable +vk-false+)
							(depth-compare-op :compare-op-equal)
							(depth-bounds-test-enable +vk-false+)
							(stencil-test-enable +vk-false+)
							(front (make-stencil-op-state))
							(back (make-stencil-op-state))
							(min 0.0)
							(max 0.0)
						      &aux
							(type :structure-type-pipeline-depth-stencil-state-create-info))
  (cons 'pipeline-depth-stencil-state-create-info
	(list type next flags
	      depth-test-enable depth-write-enable depth-compare-op depth-bounds-test-enable
	      stencil-test-enable
	      (get-obj front 'stencil-op-state)
	      (get-obj back 'stencil-op-state)
	      min max)))

(defun make-pipeline-color-blend-attachment-state (&key
						     (blend-enable +vk-false+)
						     (src-color-blend-factor :blend-factor-one)
						     (dst-color-blend-factor :blend-factor-one)
						     (color-blend-op :blend-op-add)
						     (src-alpha-blend-factor :blend-factor-one)
						     (dst-alpha-blend-factor :blend-factor-one)
						     (alpha-blend-op :blend-op-add)
						     (color-write-mask 0))
  (cons 'pipeline-color-blend-attachment-state
	(list blend-enable
	      src-color-blend-factor
	      dst-color-blend-factor
	      color-blend-op
	      src-alpha-blend-factor
	      dst-alpha-blend-factor
	      alpha-blend-op
	      color-write-mask)))

(defun make-pipeline-color-blend-state-create-info (&key
						      (next (null-pointer))
						      (flags 0)
						      (enable +vk-false+)
						      (logic-op :logic-op-and)
						      (attachments nil)
						      (blend-constants '(0.0 0.0 0.0 0.0))
						    &aux
						      (type :structure-type-pipeline-color-blend-state-create-info))
  (cons 'pipeline-color-blend-state-create-info
	(list type next flags
	      enable logic-op
	      (length attachments) (get-objs attachments 'pipeline-color-blend-attachment-state)
	      (get-pointer-obj blend-constants 'float))))

(defun make-pipeline-dynamic-state-create-info (&key
						  (next (null-pointer))
						  (flags 0)
						  (states nil)
						&aux
						  (type :structure-type-pipeline-dynamic-state-create-info))
  (cons 'pipeline-dynamic-state-create-info
	(list type next flags
	      (length states) (get-pointer-obj states 'vk-dynamic-state))))

(defun make-graphics-pipeline-create-info (&key
					     (next (null-pointer))
					     (flags 0)
					     (stages nil)
					     (vertex-state nil)
					     (assembly-state nil)
					     (tessellation-state nil)
					     (viewport-state nil)
					     (rasterization-state nil)
					     (multisample-state nil)
					     (depth-stencil-state nil)
					     (color-blend-state nil)
					     (dynamic-state nil)
					     (layout (null-pointer))
					     (render-pass (null-pointer))
					     (sub-pass 0)
					     (base-pipeline (null-pointer))
					     (index 0)
					   &aux
					     (type :structure-type-graphics-pipeline-create-info))
  (cons 'graphics-pipeline-create-info
	(list type next flags
	      (length stages) (get-objs stages 'pipeline-shader-stage-create-info)
	      (get-obj vertex-state 'pipeline-vertex-input-state-create-info)
	      (get-obj assembly-state 'pipeline-input-assembly-state-create-info)
	      (get-obj tessellation-state 'pipeline-tessellation-state-create-info)
	      (get-obj viewport-state 'pipeline-viewport-state-create-info)
	      (get-obj rasterization-state 'pipeline-rasterization-state-create-info)
	      (get-obj multisample-state 'pipeline-multisample-state-create-info)
	      (get-obj depth-stencil-state 'pipeline-depth-stencil-state-create-info)
	      (get-obj color-blend-state 'pipeline-color-blend-state-create-info)
	      (get-obj dynamic-state 'pipeline-dynamic-state-create-info)
	      layout
	      render-pass
	      sub-pass
	      base-pipeline
	      index)))
;;end graphics pipeline

(defun make-compute-pipeline-create-info (&key
					    (next (null-pointer))
					    (flags 0)
					    (stages nil)
					    (layout (null-pointer))
					    (base-pipeline (null-pointer))
					    (index (null-pointer))
					  &aux
					    (type :structure-type-compute-pipeline-create-info))
  (cons 'compute-pipeline-create-info
	(list type next flags
	      (get-obj stages 'pipeline-shader-stage-create-info)
	      layout
	      base-pipeline index)))

(defun make-validation-flag-ext (&key
				   (next (null-pointer))
				   (checks nil)
				 &aux (type :structure-type-validation-flags-ext))
  (cons 'validation-flag-ext
	(list type
	      next
	      checks)))

(defun make-physical-device-limits (&key
				      (max-image-dimension1-d 0)
				      (max-image-dimension2-d 0)
				      (max-image-dimension3-d 0)
				      (max-image-dimension-cube 0)
				      (max-image-array-layers 0)
				      (max-texel-buffer-elements 0)
				      (max-uniform-buffer-range 0)
				      (max-storage-buffer-range 0)
				      (max-push-constants-size 0)
				      (max-memory-allocation-count 0)
				      (max-sampler-allocation-count 0)
				      (buffer-image-granularity 0)
				      (sparse-address-space-size 0)
				      (max-bound-descriptor-sets 0)
				      (max-per-stage-descriptor-samplers 0)
				      (max-per-stage-descriptor-uniform-buffers 0)
				      (max-per-stage-descriptor-storage-buffers 0)
				      (max-per-stage-descriptor-sampled-images 0)
				      (max-per-stage-descriptor-storage-images 0)
				      (max-per-stage-descriptor-input-attachments 0)
				      (max-per-stage-resources 0)
				      (max-descriptor-set-samplers 0)
				      (max-descriptor-set-uniform-buffers 0)
				      (max-descriptor-set-uniform-buffers-dynamic 0)
				      (max-descriptor-set-storage-buffers 0)
				      (max-descriptor-set-storage-buffers-dynamic 0)
				      (max-descriptor-set-sampled-images 0)
				      (max-descriptor-set-storage-images 0)
				      (max-descriptor-set-input-attachments 0)
				      (max-vertex-input-attributes 0)
				      (max-vertex-input-bindings 0)
				      (max-vertex-input-attribute-offset 0)
				      (max-vertex-input-binding-stride 0)
				      (max-vertex-output-components 0)
				      (max-tessellation-generation-level 0)
				      (max-tessellation-patch-size 0)
				      (max-tessellation-control-per-vertex-input-components 0)
				      (max-tessellation-control-per-vertex-output-components 0)
				      (max-tessellation-control-per-patch-output-components 0)
				      (max-tessellation-control-total-output-components 0)
				      (max-tessellation-evaluation-input-components 0)
				      (max-tessellation-evaluation-output-components 0)
				      (max-geometry-shader-invocations 0)
				      (max-geometry-input-components 0)
				      (max-geometry-output-components 0)
				      (max-geometry-output-vertices 0)
				      (max-geometry-total-output-components 0)
				      (max-fragment-input-components 0)
				      (max-fragment-output-attachments 0)
				      (max-fragment-dual-src-attachments 0)
				      (max-fragment-combined-output-resources 0)
				      (max-compute-shared-memory-size 0)
				      (max-compute-work-group-count nil)
				      (max-compute-work-group-invocations 0)
				      (max-compute-work-group-size nil)
				      (sub-pixel-precision-bits 0)
				      (sub-texel-precision-bits 0)
				      (mipmap-precision-bits 0)
				      (max-draw-indexed-index-value 0)
				      (max-draw-indirect-count 0)
				      (max-sampler-lod-bias 0.0)
				      (max-sampler-anisotropy 0.0)
				      (max-viewports 0)
				      (max-viewport-dimensions nil)
				      (viewport-bounds-range nil)
				      (viewport-sub-pixel-bits 0)
				      (min-memory-map-alignment 0)
				      (min-texel-buffer-offset-alignment 0)
				      (min-uniform-buffer-offset-alignment 0)
				      (min-storage-buffer-offset-alignment 0)
				      (min-texel-offset 0)
				      (max-texel-offset 0)
				      (min-texel-gather-offset 0)
				      (max-texel-gather-offset 0)
				      (min-interpolation-offset 0.0)
				      (max-interpolation-offset 0.0)
				      (sub-pixel-interpolation-offset-bits 0)
				      (max-framebuffer-width 0)
				      (max-framebuffer-height 0)
				      (max-framebuffer-layers 0)
				      (framebuffer-color-sample-counts 0)
				      (framebuffer-depth-sample-counts 0)
				      (framebuffer-stencil-sample-counts 0)
				      (framebuffer-no-attachments-sample-counts 0)
				      (max-color-attachments 0)
				      (sampled-image-color-sample-counts 0)
				      (sampled-image-integer-sample-counts 0)
				      (sampled-image-depth-sample-counts 0)
				      (sampled-image-stencil-sample-counts 0)
				      (storage-image-sample-counts 0)
				      (max-sample-mask-words 0)
				      (timestamp-compute-and-graphics +vk-false+)
				      (timestamp-period 0.0)
				      (max-clip-distances 0)
				      (max-cull-distances 0)
				      (max-combined-clip-and-cull-distances 0)
				      (discrete-queue-priorities 0)
				      (point-size-range nil)
				      (line-width-range nil)
				      (point-size-granularity 0.0)
				      (line-width-granularity 0.0)
				      (strict-lines +vk-false+)
				      (standard-sample-locations +vk-false+)
				      (optimal-buffer-copy-offset-alignment 0)
				      (optimal-buffer-copy-row-pitch-alignment 0)
				      (non-coherent-atom-size 0))
  (cons 'physical-device-limits
	(list max-image-dimension1-d
	      max-image-dimension2-d
	      max-image-dimension3-d
	      max-image-dimension-cube
	      max-image-array-layers
	      max-texel-buffer-elements
	      max-uniform-buffer-range
	      max-storage-buffer-range
	      max-push-constants-size
	      max-memory-allocation-count
	      max-sampler-allocation-count
	      buffer-image-granularity
	      sparse-address-space-size
	      max-bound-descriptor-sets
	      max-per-stage-descriptor-samplers
	      max-per-stage-descriptor-uniform-buffers
	      max-per-stage-descriptor-storage-buffers
	      max-per-stage-descriptor-sampled-images
	      max-per-stage-descriptor-storage-images
	      max-per-stage-descriptor-input-attachments
	      max-per-stage-resources
	      max-descriptor-set-samplers
	      max-descriptor-set-uniform-buffers
	      max-descriptor-set-uniform-buffers-dynamic
	      max-descriptor-set-storage-buffers
	      max-descriptor-set-storage-buffers-dynamic
	      max-descriptor-set-sampled-images
	      max-descriptor-set-storage-images
	      max-descriptor-set-input-attachments
	      max-vertex-input-attributes
	      max-vertex-input-bindings
	      max-vertex-input-attribute-offset
	      max-vertex-input-binding-stride
	      max-vertex-output-components
	      max-tessellation-generation-level
	      max-tessellation-patch-size
	      max-tessellation-control-per-vertex-input-components
	      max-tessellation-control-per-vertex-output-components
	      max-tessellation-control-per-patch-output-components
	      max-tessellation-control-total-output-components
	      max-tessellation-evaluation-input-components
	      max-tessellation-evaluation-output-components
	      max-geometry-shader-invocations
	      max-geometry-input-components
	      max-geometry-output-components
	      max-geometry-output-vertices
	      max-geometry-total-output-components
	      max-fragment-input-components
	      max-fragment-output-attachments
	      max-fragment-dual-src-attachments
	      max-fragment-combined-output-resources
	      max-compute-shared-memory-size
	      max-compute-work-group-count
	      max-compute-work-group-invocations
	      max-compute-work-group-size
	      sub-pixel-precision-bits
	      sub-texel-precision-bits
	      mipmap-precision-bits
	      max-draw-indexed-index-value
	      max-draw-indirect-count
	      max-sampler-lod-bias
	      max-sampler-anisotropy
	      max-viewports
	      max-viewport-dimensions
	      viewport-bounds-range
	      viewport-sub-pixel-bits
	      min-memory-map-alignment
	      min-texel-buffer-offset-alignment
	      min-uniform-buffer-offset-alignment
	      min-storage-buffer-offset-alignment
	      min-texel-offset
	      max-texel-offset
	      min-texel-gather-offset
	      max-texel-gather-offset
	      min-interpolation-offset
	      max-interpolation-offset
	      sub-pixel-interpolation-offset-bits
	      max-framebuffer-width
	      max-framebuffer-height
	      max-framebuffer-layers
	      framebuffer-color-sample-counts
	      framebuffer-depth-sample-counts
	      framebuffer-stencil-sample-counts
	      framebuffer-no-attachments-sample-counts
	      max-color-attachments
	      sampled-image-color-sample-counts
	      sampled-image-integer-sample-counts
	      sampled-image-depth-sample-counts
	      sampled-image-stencil-sample-counts
	      storage-image-sample-counts
	      max-sample-mask-words
	      timestamp-compute-and-graphics
	      timestamp-period
	      max-clip-distances
	      max-cull-distances
	      max-combined-clip-and-cull-distances
	      discrete-queue-priorities
	      point-size-range
	      line-width-range
	      point-size-granularity
	      line-width-granularity
	      strict-lines
	      standard-sample-locations
	      optimal-buffer-copy-offset-alignment
	      optimal-buffer-copy-row-pitch-alignment
	      non-coherent-atom-size)))

(defun make-validation-features-ext (&key
				       (next (null-pointer))
				       (enable-features nil)
				       (disable-features nil)
				     &aux (type :structure-type-validation-features-ext))
  (cons 'validation-features-ext
	(list type
	      next
	      (length enable-features)
	      (get-pointer-obj enable-features 'vk-validation-feature-enable-ext)
	      (length disable-features)
	      (get-pointer-obj disable-features 'vk-validation-feature-disable-ext))))

(defun make-conformance-version (major minor submitor patch)
  (cons 'conformance-version
	(list major minor submitor patch)))

#|
no need wrapp 
vk-physical-device-sparse-properties
vk-physical-device-properties
vk-physical-device-properties2
vk-physical-device-vulkan-11-properties
vk-physical-device-vulkan-12-properties

(defun make-physical-device-id-properties
(:type VkStructureType)
(:next (:pointer :void))
(:device-uuid :uint8 :count 16)
(:driver-uuid :uint8 :count 16)
(:device-luid :uint8 :count 16)
(:device-node-mask :uint32)
(:device-luid-vaild vk-bool-32))

(defun make-physical-device-driver-properties
(:type VkStructureType)
(:next (:pointer :void))
(:driver-id VkDriverid)
(:driver-name :char :count 256)
(:driver-info :char :count 256)
(:conformance-version (:struct vk-conformance-version)))

(defun make-physical-device-pci-bus-info-properties-ext
(:type VkStructureType)
(:next (:pointer :void))
(:pci-domain :uint32)
(:pci-bus :uint32)
(:pci-device :uint32)
(:pci-function :uint32))

(defun make-queue-family-properties
(:queue-flags vk-queue-flags)
(:queue-count :uint32)
(:timestamp-valid-bits :uint32)
(:min-image-transfer-granularity (:struct vk-extent-3d)))

(defun make-queue-family-properties2
(:type VkStructureType)
(:next (:pointer :void))
(:queue-family-properties (:struct vk-queue-family-properties)))

(defun make-queue-family-checkpoint-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:checkpoint-execution-stage-mask vk-pipeline-stage-flags))

(defun make-performance-counter-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:unit VkPerformanceCounterunitkhr)
  (:scope VkPerformanceCounterscopekhr)
  (:storage VkPerformanceCounterStoragekhr)
  (:uuid :uint8 :count 16))

(defun make-performance-counter-description-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-performance-counter-description-flags-khr)
  (:name :char :count 256)
  (:category :char :count 256)
  (:description :char :count 256))

(defun make-physical-device-group-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:physical-device-count :uint32)
  (:physical-devices vk-physical-device :count 32)
  (:subset-allocation vk-bool-32))


(defun make-device-group-device-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:physical-device-count :uint32)
  (:physical-device (:pointer vk-physical-device)))

(defun make-device-memory-overallocation-create-info-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:overallocation-behavior VkMemoryOverallocationbehavioramd))

(defun make-device-diagnostics-config-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-device-diagnostics-config-flags-nv))

(defun make-device-private-data-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:private-data-slot-request-count :uint32))

(defun make-device-queue-global-priority-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:global-priority VkQueueGlobalPriorityExt))

(defun make-device-queue-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-device-queue-create-flags)
  (:queue-family-index :uint32)
  (:queue-index :uint32))

(defun make-command-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-command-pool-create-flags)
  (:queue-family-index :uint32))

(defun make-command-buffer-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:command-pool vk-command-pool)
  (:level VKCommandbufferlevel)
  (:command-buffer-count :uint32))

(defun make-command-buffer-inheritance-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:render-pass vk-render-pass)
  (:sub-pass :uint32)
  (:framebuffer vk-framebuffer)
  (:occlusion-query-enable vk-bool-32)
  (:flags vk-query-control-flags)
  (:pipeline-statistics vk-query-pipeline-statistic-flags))

(defun make-command-buffer-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-command-buffer-usage-flags)
  (:inheritance-info (:pointer (:struct vk-command-buffer-inheritance-info))))

(defun make-command-buffer-inheritance-conditional-rendering-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conditional-rendering-enable vk-bool-32))

(defun make-command-buffer-inheritance-render-pass-transform-info-qcom
  (:type VkStructureType)
  (:next (:pointer :void))
  (:transform VkSurfaceTransformflagbitskhr)
  (:render-area (:struct vk-rect-2d)))

(defun make-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphores (:pointer vk-semaphore))
  (:wait-dst-stage-masks (:pointer vk-pipeline-stage-flags))
  (:command-buffer-count :uint32)
  (:command-buffers (:pointer vk-command-buffer))
  (:signal-semaphore-count :uint32)
  (:signal-semaphores (:pointer vk-semaphore)))

(defun make-timeline-semaphore-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-value-count :uint32)
  (:wait-semaphore-values (:pointer :uint64))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-values (:pointer :uint64)))

(defun make-d3d12-fence-submit-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-value-count :uint32)
  (:wait-semaphore-values (:pointer :uint64))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-values (:pointer :uint64)))

(defun make-win32-keyed-mutex-acquire-release-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acquire-count :uint32)
  (:acquire-syncs vk-device-memory)
  (:acquire-keys (:pointer :uint64))
  (:acquire-timeout (:pointer :uint32))
  (:release-count :uint32)
  (:release-syncs (:pointer vk-device-memory))
  (:release-keys (:pointer :uint64)))

(defun make-win32-keyed-mutex-acquire-release-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acquire-count :uint32)
  (:acquire-syncs vk-device-memory)
  (:acquire-keys (:pointer :uint64))
  (:acquire-timeout (:pointer :uint32))
  (:release-count :uint32)
  (:release-syncs (:pointer vk-device-memory))
  (:release-keys (:pointer :uint64)))

(defun make-protected-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:protected-submit vk-bool-32))

(defun make-device-group-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphore-device-indices (:pointer :uint32))
  (:command-buffer-count :uint32)
  (:command-buffer-device-masks (:pointer :uint32))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-device-indices (:pointer :uint32)))

(defun make-performance-query-submit-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:count-pass-index :uint32))

(defun make-device-group-command-buffer-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-mask :uint32))



(defun make-export-fence-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-external-fence-handle-type-flags))

;;in windows 
(defun security-attributes
  (:length :uint32)
  (:lp-void (:pointer :void))
  (:bool :int32))

(defun make-export-fence-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defun make-fence-get-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:handle-type VkExternalFenceHandleTypeFlagBits))
;;end windows

(defun make-fence-get-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:handle-type VkExternalFenceHandleTypeFlagBits))

(defun make-device-event-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-event VkDeviceEventTypeExt))

(defun make-display-event-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-event VkDisplayEventTypeExt))

(defun make-import-fence-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:flags vk-fence-import-flags)
  (:handle-type VkExternalFenceFeatureFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defun make-import-fence-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:flags vk-fence-import-flags)
  (:handle-type VkExternalFenceFeatureFlagBits)
  (:fd :int))

(defun make-semaphore-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-semaphore-create-flags))

(defun make-semaphore-type-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore-type VkSemaphoreType)
  (:initial-value :uint64))

(defun make-export-semaphore-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-semaphore-handle-type-flags))

(defun make-export-semaphore-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defun make-semaphore-get-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:handle-type VkExternalSemaphoreHandleTypeFlagbits))

(defun make-semaphore-get-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:handle-type VkExternalSemaphoreHandleTypeFlagbits))

(defun make-semaphore-wait-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-semaphore-wait-flags)
  (:semaphore-count :uint32)
  (:semaphores (:pointer vk-semaphore))
  (:value (:pointer :uint64)))

(defun make-semaphore-signal-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:value :uint64))

(defun make-import-semaphore-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:flags vk-semaphore-import-flags)
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defun make-import-semaphore-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:flags vk-semaphore-import-flags)
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits)
  (:fd :int))



(defun make-memory-barrier
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags))

(defun make-buffer-memory-barrier
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:src-queue-family-index :uint32)
  (:dst-queue-family-index :uint32)
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:size vk-device-size))



(defun make-image-memory-barrier
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:old-layout VkImageLayout)
  (:new-layout VkImageLayout)
  (:src-queue-family-index :uint32)
  (:dst-queue-family-index :uint32)
  (:image vk-image)
  (:sub-resource-range (:struct vk-image-subresource-range)))

(defun make-calibrated-timestamp-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:time-domain VkTimedomainext))

(defun make-attachment-description
  (:flags vk-attachment-description-flags)
  (:format VkFormat)
  (:samples VkSampleCountFlagbits)
  (:load-op VkAttachmentLoadop)
  (:store-op VkAttachmentStoreop)
  (:stencil-load-op VkAttachmentLoadop)
  (:stencil-store-op VkAttachmentStoreop)
  (:initial-layout VkImageLayout)
  (:final-layout VkImageLayout))

(defun make-attachment-reference
  (:attachment :uint32)
  (:layout VkImageLayout))

(defun make-subpass-description
  (:flags vk-subpass-description-flags)
  (:pipeline-bind-point VkPipelineBindpoint)
  (:input-attachment-cout :uint32)
  (:input-attachments (:pointer (:struct vk-attachment-reference)))
  (:color-attachment-count :uint32)
  (:color-attachments (:pointer (:struct vk-attachment-reference)))
  (:reslove-attachments (:pointer (:struct vk-attachment-reference)))
  (:depth-stencil-attachments (:pointer (:struct vk-attachment-reference)))
  (:reserve-attachment-count :uint32)
  (:preserve-attachments (:pointer :uint32)))

(defun make-subpass-dependency
  (:src-subpass :uint32)
  (:dst-subpass :uint32)
  (:src-stage-mask vk-pipeline-stage-flags)
  (:dst-stage-mask vk-pipeline-stage-flags)
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:dependency-flags vk-dependency-flags))

(defun make-render-pass-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-render-pass-create-flags)
  (:attachment-count :uint32)
  (:attachments (:pointer (:struct vk-attachment-description)))
  (:subpass-count :uint32)
  (:subpasses (:pointer (:struct vk-subpass-description)))
  (:dependency-count :uint32)
  (:dependencies (:pointer (:struct vk-subpass-dependency))))

(defun make-render-pass-multiview-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subpass-count :uint32)
  (:view-mask (:pointer :uint32))
  (:dependency-count :uint32)
  (:view-offsets (:pointer :uint32))
  (:correlation-mask-count :uint32)
  (:correlation-mask (:pointer :uint32)))

(defun make-render-pass-fragment-density-map-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-density-map-attachment (:struct vk-attachment-reference)))

(defun make-input-attachment-aspect-reference
  (:subpass :uint32)
  (:input-attachment-index :uint32)
  (:aspect-mask vk-image-aspect-flags))

(defun make-render-pass-input-attachment-aspect-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aspect-reference-count :uint32)
  (:aspect-reference (:pointer (:struct vk-input-attachment-aspect-reference))))

(defun make-attachment-description2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-attachment-description-flags)
  (:format VkFormat)
  (:samples VkSampleCountFlagbits)
  (:load-op VkAttachmentLoadop)
  (:store-op VkAttachmentStoreop)
  (:stencil-load-op VkAttachmentLoadop)
  (:stencil-store-op VkAttachmentStoreop)
  (:initial-layout VkImageLayout)
  (:final-layout VkImageLayout))

(defun make-attachment-reference2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment :uint32)
  (:layout VkImageLayout)
  (:aspect-mask vk-image-aspect-flags))

(defun make-subpass-description2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-subpass-description-flags)
  (:pipeline-bind-point VkPipelineBindpoint)
  (:view-mask :uint32)
  (:input-attachment-cout :uint32)
  (:input-attachment (:pointer (:struct vk-attachment-reference2)))
  (:color-attachment-count :uint32)
  (:color-attachments (:pointer (:struct vk-attachment-reference2)))
  (:reslove-attachments (:pointer (:struct vk-attachment-reference2)))
  (:depth-stencil-attachments (:pointer (:struct vk-attachment-reference2)))
  (:reserve-attachment-count :uint32)
  (:preserve-attachments (:pointer :uint32)))

(defun make-subpass-dependency2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-subpass :uint32)
  (:dst-subpass :uint32)
  (:src-stage-mask vk-pipeline-stage-flags)
  (:dst-stage-mask vk-pipeline-stage-flags)
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:dependency-flags vk-dependency-flags)
  (:view-offset :uint32))

(defun make-render-pass-create-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-render-pass-create-flags)
  (:attachment-count :uint32)
  (:attachment (:pointer (:struct vk-attachment-description2)))
  (:subpass-count :uint32)
  (:subpasses (:pointer (:struct vk-subpass-description2)))
  (:dependency-count :uint32)
  (:dependenies (:pointer (:struct vk-subpass-dependency2)))
  (:correlate-view-mask-count :uint32)
  (:correlated-view-masks (:pointer :uint32)))

(defun make-attachment-description-stenci-layout
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stencil-initial-layout VkImageLayout)
  (:stencil-final-layout VkImageLayout))

(defun make-subpass-description-depth-stencil-reslove
  (:type VkStructureType)
  (:next (:pointer :void))
  (:depth-reslove-mode VkResolveModeFlagbits)
  (:stencil-reslove-mode VkResolveModeFlagbits)
  (:depth-stencil-resolve-attachment (:struct vk-attachment-reference2)))

(defun make-attachment-reference-stencil-layout
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stencil-layout VkImageLayout))

(defun make-framebuffer-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-framebuffer-create-flags)
  (:render-pass vk-render-pass)
  (:attachment-count :uint32)
  (:attachments (:pointer vk-image-view))
  (:width :uint32)
  (:height :uint32)
  (:layers :uint32))

(defun make-framebuffer-attachment-image-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-image-create-flags)
  (:usage vk-image-usage-flags)
  (:width :uint32)
  (:height :uint32)
  (:layer-count :uint32)
  (:voew-format-count :uint32)
  (:view-formats (:pointer VkFormat)))

(defun make-framebuffer-attachments-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment-image-info-count :uint32)
  (:attachment-image-infos (:pointer (:struct vk-framebuffer-attachment-image-info))))

(defcfun vk-clear-color-value
  (:f32 (:pointer :float))
  (:i32 (:pointer :int32))
  (:ui32 (:pointer :uint32)))

(defun make-clear-depth-stencil-value
  (:depth :float)
  (:stencil :uint32))

(defcfun vk-clear-value
  (:color (:union vk-clear-color-value))
  (:depth-stencil (:struct vk-clear-depth-stencil-value)))

(defun make-render-pass-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:render-pass vk-render-pass)
  (:framebuffer vk-framebuffer)
  (:render-area (:struct vk-rect-2d))
  (:clear-value-count :uint32)
  (:clear-values (:pointer (:union vk-clear-value))))

(defun make-sample-location-ext
  (:x :float)
  (:y :float))

(defun make-sample-locations-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sample-locations-per-pixel VkSampleCountFlagbits)
  (:sample-location-grid-size (:struct vk-extent-2d))
  (:sample-locations-count :uint32)
  (:sample-locations (:pointer (:struct vk-sample-location-ext))))

(defun make-attachment-sample-locations-ext
  (:attachment-index :uint32)
  (:sample-locations-info (:struct vk-sample-locations-info-ext)))

(defun make-subpass-sample-locations-ext
  (:subpass-index :uint32)
  (:sample-location-info (:struct vk-sample-locations-info-ext)))

(defun make-render-pass-sample-locations-begin-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment-initial-sample-locations-count :uint32)
  (:attachment-initial-sample-locations (:pointer (:struct vk-attachment-sample-locations-ext)))
  (:post-subpass-sample-locations-count :uint32)
  (:post-subpass-sample-locations (:struct vk-subpass-sample-locations-ext)))

(defun make-render-pass-transform-begin-info-qcom
  (:type VkStructureType)
  (:next (:pointer :void))
  (:transform VkSurfaceTransformFlagbitsKHR))

(defun make-subpass-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:contents VkSubpassContents))

(defun make-device-group-render-pass-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-mask :uint32)
  (:device-render-area-count :uint32)
  (:device-render-areas (:pointer (:struct vk-rect-2d))))

(defun make-render-pass-attachment-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment-count :uint32)
  (:attachment (:pointer vk-image-view)))

(defun make-subpass-end-info
  (:type VkStructureType)
  (:next (:pointer :void)))



(defun make-shader-module-validation-cache-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:validation-cache vk-validation-cache-ext))

(defun make-cooperative-matrix-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:m-size :uint32)
  (:n-size :uint32)
  (:k-size :uint32)
  (:a-type VkComponentTypeNV)
  (:b-type VkComponentTypeNV)
  (:c-type VkComponentTypeNV)
  (:d-type VkComponentTypeNV)
  (:scope VkScopeNV))

(defun make-validation-cache-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-validation-cache-create-flags-ext)
  (:initial-data-size size-t)
  (:initial-data (:pointer :void)))









(defun make-pipeline-shader-stage-required-subground-size-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:required-subground-size :uint32))























(defun make-graphics-shader-group-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:vetex-input-state (:pointer (:struct vk-pipeline-vertex-input-state-create-info)))
  (:tessellation-stage (:pointer (:struct vk-pipeline-tessellation-state-create-info))))

(defun make-graphics-pipeline-shader-groups-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:group-count :uint32)
  (:groups (:pointer (:struct vk-graphics-shader-group-create-info-nv)))
  (:pipeline-count :uint32)
  (:pipelines (:pointer vk-pipeline)))



(defun make-pipeline-library-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:library-count :uint32)
  (:libraries (:pointer vk-pipeline)))

(defun make-pipeline-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline vk-pipeline))

(defun make-pipeline-executable-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stage vk-shader-stage-flags)
  (:name :char :count 256)
  (:description :char :count 256)
  (:subgroup-size :uint32))

(defun make-pipeline-executable-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline vk-pipeline)
  (:executable-index :uint32))

(defcfun vk-pipeline-executable-statistic-value-khr
  (:b32 vk-bool-32)
  (:i64 :int64)
  (:u64 :uint64)
  (:f64 :double))

(defun make-pipeline-executable-statistic-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:name :char :count 256)
  (:description :char :count 256)
  (:format VkPipelineExecutableStatisticFormatKHR)
  (:value (:union vk-pipeline-executable-statistic-value-khr)))

(defun make-pipeline-executable-internal-representation-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:name :char :count 256)
  (:description :char :count 256)
  (:is-text vk-bool-32)
  (:data-size size-t)
  (:data (:pointer :void)))

(defun make-shader-resource-usage-amd
  (:num-used-vgprs :uint32)
  (:num-used-sgprs :uint32)
  (:lds-size-per-local-work-group :uint32)
  (:lds-usage-size-in-bytes size-t)
  (:scratch-mem-usage-in-bytes size-t))

(defun make-shader-statistics-info-amd
  (:shader-stage-mask vk-shader-stage-flags)
  (:resource-usage (:struct vk-shader-resource-usage-amd))
  (:num-physical-vgprs :uint32)
  (:num-physical-sgprs :uint32)
  (:num-available-vgprs :uint32)
  (:num-available-sgprs :uint32)
  (:computeWorkGroupSize :uint32 :count 3))

(defun make-pipeline-compiler-control-create-info-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compiler-control-flags vk-pipeline-compiler-control-flags-amd))

(defun make-ray-tracing-shader-group-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkRayTracingShaderGroupTypeKHR)
  (:general-shader :uint32)
  (:closes-hit-shader :uint32)
  (:any-hit-shader :uint32)
  (:intersection-shader :uint32))

(defun make-ray-tracing-pipeline-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-create-flags)
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:group-count :uint32)
  (:groups (:pointer (:struct vk-ray-tracing-shader-group-create-info-nv)))
  (:layout vk-pipeline-layout)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))

(defun make-ray-tracing-shader-group-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkRayTracingShaderGroupTypeKHR)
  (:general-shader :uint32)
  (:closes-hit-shader :uint32)
  (:any-hit-shader :uint32)
  (:intersection-shader :uint32)
  (:shader-group-capture-replay-handle (:pointer :void)))

(defun make-pipeline-library-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:library-count :uint32)
  (:library (:pointer vk-pipeline)))

(defun make-ray-tracing-pipeline-interface-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-payload-size :uint32)
  (:max-attribute-size :uint32)
  (:max-callable-size :uint32))

(defun make-ray-tracing-pipeline-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-create-flags)
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:group-count :uint32)
  (:groups (:pointer (:struct vk-ray-tracing-shader-group-create-info-khr)))
  (:max-recursion-depth :uint32)
  (:library (:struct vk-pipeline-library-create-info-khr))
  (:library-interface (:pointer (:struct vk-ray-tracing-pipeline-interface-create-info-khr)))
  (:layout vk-pipeline-layout)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))

(defun make-pipeline-creation-feedback-ext
  (:flags vk-pipeline-creation-feedback-flags-ext)
  (:duration :uint64))

(defun make-pipeline-creation-feedback-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-creation-feedback (:pointer (:struct vk-pipeline-creation-feedback-ext)))
  (:pipeline-stage-creation-feedback-count :uint32)
  (:pipeline-stage-creation-feedbacks (:pointer (:struct vk-pipeline-creation-feedback-ext))))

(defun make-allocation-callback
  (:user-data (:pointer :void))
  (:fn-allocation vk-allocation-function)
  (:fn-reallocation vk-reallocation-function)
  (:fn-free vk-free-function)
  (:fn-internal-allocation vk-internal-allocation-notification)
  (:fn-internal-free vk-internal-free-notification))

(defun make-memory-type
  (:property-flags vk-memory-property-flags)
  (:hape-index :uint32))

(defun make-memory-heap
  (:size vk-device-size)
  (:flags vk-memory-heap-flags))

(defun make-physical-device-memory-properties
  (:memory-type-count :uint32)
  (:memory-types (:struct vk-memory-type) :count 32) 
  (:memory-heap-count :uint32)
  (:memory-heaps (:struct vk-memory-heap) :count 16))

(defun make-physical-device-memory-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-properties (:struct vk-physical-device-properties)))

(defun make-physical-device-memory-budget-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:heap-budget vk-device-size :count 32)
  (:heap-usage vk-device-size :count 32))

(defun make-memory-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:allocation-size vk-device-size)
  (:memory-type-index :uint32))

(defun make-memory-dedicated-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image)
  (:buffer vk-buffer))

(defun make-dedicated-allocation-memory-allocate-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image)
  (:buffer vk-buffer))

(defun make-memory-priority-allocate-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:priority :float))

(defun make-export-memory-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags))

(defun make-export-memory-win32-handle-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defun make-import-memory-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defun make-memory-get-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defun make-memory-win32-handle-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-type-bits :uint32))

(defun make-import-memory-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:fd :int))

(defun make-memory-get-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defun make-memory-fd-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-type-bits :uint32))

(defun make-import-memory-host-pointer-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:host-pointer (:pointer :void)))

(defun make-memory-host-pointer-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-type-bits :uint32))

#|
i don't know how to set up android in lisp
(defun make-import-android-hardware-buffer-info-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defcstuct vk-memory-get-android-hardware-buffer-info-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defun make-android-hardware-buffer-properties-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defun make-android-hardware-buffer-format-properties-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defun make-external-format-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defun make-android-surface-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void)))

|#

(defun make-export-memory-allocate-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv))

(defun make-export-memory-win32-handle-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32))

(defun make-import-memory-win32-handle-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv)
  (:handle (:pointer :void)))

(defun make-memory-allocate-flags-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-memory-allocate-flags)
  (:device-mask :uint32))

(defun make-memory-opaque-capture-address-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:opaque-capture-address :uint64))

(defun make-memory-opaque-capture-address-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:opaque-capture-address :uint64))

(defun make-mapped-memory-range
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory)
  (:offset vk-device-size)
  (:size vk-device-size))

(defun make-device-memory-opaque-capture-address-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory))



(defun make-dedicated-allocation-buffer-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:dedicated-allocation vk-bool-32))

(defun make-external-memory-buffer-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-types vk-external-memory-handle-type-flags))

(defun make-buffer-opaque-capture-address-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:opaque-capture-address :uint64))

(defun make-buffer-device-address-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-address vk-device-address))





(defun make-image-stencil-usage-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stencil-usage vk-image-usage-flags))

(defun make-dedicated-allocation-image-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:dedicated-allocation vk-bool-32))

(defun make-external-memory-image-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-types vk-external-memory-handle-type-flags))

(defun make-external-memory-image-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv))

(defun make-image-swapchain-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr))

(defun make-image-format-list-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:view-format-count :uint32)
  (:view-format (:pointer VkFormat)))

(defun make-image-drm-format-modifier-list-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier-count :uint32)
  (:drm-format-modifiers (:pointer :uint64)))

(defun make-subresource-layout
  (:offset vk-device-size)
  (:size vk-device-size)
  (:row-pitch vk-device-size)
  (:array-pitch vk-device-size)
  (:depth-pitch vk-device-size))

(defun make-image-drm-format-modifier-explicit-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier :uint64)
  (:drm-format-modifier-plane-count :uint32)
  (:plane-layouts (:pointer (:struct vk-subresource-layout))))

(defun make-image-subresource
  (:aspect-mask vk-image-aspect-flags)
  (:mip-level :Uint32)
  (:array-layer :uint32))

(defun make-image-drm-format-modifier-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier :uint64))





(defun make-image-view-usage-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:usage vk-image-usage-flags))

(defun make-image-view-a-s-t-c-decode-mode-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:decode-mode VkFormat))

(defun make-image-view-handle-info-nvx
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-view vk-image-view)
  (:descriptor-type VkDescriptorType)
  (:sampler vk-sampler))

(defun make-image-view-address-properties-nvx
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-address vk-device-address)
  (:size vk-device-size))

(defun make-memory-requirements
  (:size vk-device-size)
  (:alignment vk-device-size)
  (:memory-type-bits :uint32))

(defun make-buffer-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))

(defun make-image-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defun make-image-plane-memory-requirements-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defun make-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-memory-requirements)))

(defun make-memory-dedicated-requirements
  (:type VkStructureType)
  (:next (:pointer :void))
  (:prefers-dedicated-allocation vk-bool-32)
  (:requires-dedicated-allocation vk-bool-32))

(defun make-bind-buffer-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defun make-bind-buffer-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defun make-bind-image-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg vk-image)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defun make-bind-image-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32))
  (:split-instance-bind-region-count :uint32)
  (:split-instance-bind-regions (:pointer (:struct vk-rect-2d))))

(defun make-bind-image-memory-swapchain-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:image-index :uint32))

(defun make-bind-image-plane-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defun make-geometry-triangles-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-data vk-buffer)
  (:veretex-offset vk-device-size)
  (:vertex-count :uint32)
  (:vertex-stride vk-device-size)
  (:vertex-format VkFormat)
  (:index-data vk-buffer)
  (:index-offset vk-device-size)
  (:index-count :uint32)
  (:index-type VkIndexType)
  (:transform-data vk-buffer)
  (:transform-offset vk-device-size))

(defun make-geometry-aabb-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aabb-data vk-buffer)
  (:num-aabbs :uint32)
  (:stride :uint32)
  (:offset vk-device-size))

(defun make-geometry-data-nv
  (:triangles (:struct vk-geometry-triangles-nv))
  (:aabbs (:struct vk-geometry-aabb-nv)))

(defun make-geometry-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry-data (:struct vk-geometry-data-nv))
  (:flags vk-geometry-flags-khr))

(defun make-acceleration-structure-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-nv)
  (:instance-count :uint32)
  (:geometry-count :uint32)
  (:geometries (:pointer (:struct vk-geometry-nv))))

(defun make-acceleration-structure-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:info (:struct vk-acceleration-structure-info-nv)))

(defun make-acceleration-structure-create-geometry-type-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:max-primitive-count :uint32)
  (:index-type VkIndexType)
  (:max-vertex-count :uint32)
  (:vertex-format VkFormat)
  (:allows-transforms vk-bool-32))

(defun make-acceleration-structure-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:max-geometry-count :uint32)
  (:geometry-infos (:pointer (:struct vk-acceleration-structure-create-geometry-type-info-khr)))
  (:device-address vk-device-address))

(defun make-acceleration-structure-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-acceleration-structure-memory-requirements-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:build-type VkAccelerationStructureBuildTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-bind-acceleration-structure-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defun make-acceleration-structure-device-address-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-sampler-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-sampler-create-flags)
  (:mag-filter VkFilter)
  (:min-filter VkFilter)
  (:mipmap-mode VkSamplerMipmapMode)
  (:address-mode-u VkSamplerAddressMode)
  (:address-mode-v VkSamplerAddressMode)
  (:address-mode-w VkSamplerAddressMode)
  (:mip-load-bias :float)
  (:anisotropy-enable vk-bool-32)
  (:max-anisotropy vk-bool-32)
  (:compare-enable vk-bool-32)
  (:compare-op VkCompareOp)
  (:min-lod :float)
  (:max-lod :float)
  (:border-color VkBorderColor)
  (:unnormalized-coordinates vk-bool-32))

(defun make-sampler-reduction-mode-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:reduction-mode VkSamplerReductionMode))

(defun make-sampler-ycbcr-conversion-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conversion vk-sampler-ycbcr-conversion))

(defun make-sampler-ycbcr-conversion-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format VkFormat)
  (:ycbcr-model VkSamplerYcbcrModelConversion)
  (:ycbcr-range VkSamplerYcbcrRange)
  (:components (:struct vk-component-mapping))
  (:x-chroma-offset VkChromaLocation)
  (:y-chroma-offset VkChromaLocation)
  (:chroma-filter VkFilter)
  (:force-explicit-reconstruction vk-bool-32))

(defun make-sampler-custom-border-color-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-color (:union vk-clear-value))
  (:format VkFormat))

(defun make-descriptor-set-layout-binding
  (:binding :uint32)
  (:descriptor-type VkDescriptorType)
  (:descriptor-count :uint32)
  (:stage-flags vk-shader-stage-flags)
  (:immutable-samplers (:pointer vk-sampler)))

(defun make-descriptor-set-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-set-layout-create-flags)
  (:binding-count :uint32)
  (:bindings (:pointer (:struct vk-descriptor-set-layout-binding))))

(defun make-descriptor-set-layout-binding-flags-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:binding-count :uint32)
  (:binding-flags (:pointer vk-descriptor-binding-flags)))

(defun make-descriptor-set-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported vk-bool-32))

(defun make-descriptor-set-variable-descriptor-count-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-variable-descriptor-count :uint32))

(defun make-push-constant-range
  (:stage-flags vk-shader-stage-flags)
  (:offset :uint32)
  (:size :uint32))

(defun make-pipeline-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-layout-create-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout))
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range))))

(defun make-descriptor-pool-size
  (:type VkDescriptorType)
  (:descriptor-count :uint32))

(defun make-descriptor-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-pool-create-flags)
  (:max-sets :uint32)
  (:pool-size-count :uint32)
  (:pool-sizes (:pointer (:struct vk-descriptor-pool-size))))

(defun make-descriptor-pool-inline-uniform-block-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-bindings :uint32))

(defun make-descriptor-set-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descript-pool vk-descriptor-pool)
  (:descript-set-count :uint32)
  (:set-layouts vk-descriptor-set-layout))

(defun make-descriptor-set-variable-descriptor-count-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descriptor-set-count :uint32)
  (:descriptor-counts (:pointer :uint32)))

(defun make-memory-requirements
  (:size vk-device-size)
  (:alignment vk-device-size)
  (:memory-type-bits :uint32))

(defun make-buffer-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))

(defun make-image-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defun make-image-plane-memory-requirements-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defun make-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-memory-requirements)))

(defun make-memory-dedicated-requirements
  (:type VkStructureType)
  (:next (:pointer :void))
  (:prefers-dedicated-allocation vk-bool-32)
  (:requires-dedicated-allocation vk-bool-32))

(defun make-bind-buffer-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defun make-bind-buffer-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defun make-bind-image-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg vk-image)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defun make-bind-image-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32))
  (:split-instance-bind-region-count :uint32)
  (:split-instance-bind-regions (:pointer (:struct vk-rect-2d))))

(defun make-bind-image-memory-swapchain-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:image-index :uint32))

(defun make-bind-image-plane-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defun make-geometry-triangles-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-data vk-buffer)
  (:veretex-offset vk-device-size)
  (:vertex-count :uint32)
  (:vertex-stride vk-device-size)
  (:vertex-format VkFormat)
  (:index-data vk-buffer)
  (:index-offset vk-device-size)
  (:index-count :uint32)
  (:index-type VkIndexType)
  (:transform-data vk-buffer)
  (:transform-offset vk-device-size))

(defun make-geometry-aabb-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aabb-data vk-buffer)
  (:num-aabbs :uint32)
  (:stride :uint32)
  (:offset vk-device-size))

(defun make-geometry-data-nv
  (:triangles (:struct vk-geometry-triangles-nv))
  (:aabbs (:struct vk-geometry-aabb-nv)))

(defun make-geometry-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry-data (:struct vk-geometry-data-nv))
  (:flags vk-geometry-flags-khr))

(defun make-acceleration-structure-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-nv)
  (:instance-count :uint32)
  (:geometry-count :uint32)
  (:geometries (:pointer (:struct vk-geometry-nv))))

(defun make-acceleration-structure-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:info (:struct vk-acceleration-structure-info-nv)))

(defun make-acceleration-structure-create-geometry-type-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:max-primitive-count :uint32)
  (:index-type VkIndexType)
  (:max-vertex-count :uint32)
  (:vertex-format VkFormat)
  (:allows-transforms vk-bool-32))

(defun make-acceleration-structure-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:max-geometry-count :uint32)
  (:geometry-infos (:pointer (:struct vk-acceleration-structure-create-geometry-type-info-khr)))
  (:device-address vk-device-address))

(defun make-acceleration-structure-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-acceleration-structure-memory-requirements-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:build-type VkAccelerationStructureBuildTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-bind-acceleration-structure-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defun make-acceleration-structure-device-address-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-sampler-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-sampler-create-flags)
  (:mag-filter VkFilter)
  (:min-filter VkFilter)
  (:mipmap-mode VkSamplerMipmapMode)
  (:address-mode-u VkSamplerAddressMode)
  (:address-mode-v VkSamplerAddressMode)
  (:address-mode-w VkSamplerAddressMode)
  (:mip-lod-bias :float)
  (:anisotropy-enable vk-bool-32)
  (:max-anisotropy vk-bool-32)
  (:compare-enable vk-bool-32)
  (:compare-op VkCompareOp)
  (:min-lod :float)
  (:max-lod :float)
  (:border-color VkBorderColor)
  (:unnormalized-coordinates vk-bool-32))

(defun make-sampler-reduction-mode-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:reduction-mode VkSamplerReductionMode))

(defun make-sampler-ycbcr-conversion-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conversion vk-sampler-ycbcr-conversion))

(defun make-sampler-ycbcr-conversion-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format VkFormat)
  (:ycbcr-model VkSamplerYcbcrModelConversion)
  (:ycbcr-range VkSamplerYcbcrRange)
  (:components (:struct vk-component-mapping))
  (:x-chroma-offset VkChromaLocation)
  (:y-chroma-offset VkChromaLocation)
  (:chroma-filter VkFilter)
  (:force-explicit-reconstruction vk-bool-32))

(defun make-sampler-custom-border-color-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-color (:union vk-clear-value))
  (:format VkFormat))

(defun make-descriptor-set-layout-binding
  (:binding :uint32)
  (:descriptor-type VkDescriptorType)
  (:descriptor-count :uint32)
  (:stage-flags vk-shader-stage-flags)
  (:immutable-samplers (:pointer vk-sampler)))

(defun make-descriptor-set-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-set-layout-create-flags)
  (:binding-count :uint32)
  (:bindings (:pointer (:struct vk-descriptor-set-layout-binding))))

(defun make-descriptor-set-layout-binding-flags-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:binding-count :uint32)
  (:binding-flags (:pointer vk-descriptor-binding-flags)))

(defun make-descriptor-set-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported vk-bool-32))

(defun make-descriptor-set-variable-descriptor-count-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-variable-descriptor-count :uint32))

(defun make-push-constant-range
  (:stage-flags vk-shader-stage-flags)
  (:offset :uint32)
  (:size :uint32))

(defun make-pipeline-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-layout-create-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout))
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range))))

(defun make-descriptor-pool-size
  (:type VkDescriptorType)
  (:descriptor-count :uint32))

(defun make-descriptor-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-pool-create-flags)
  (:max-sets :uint32)
  (:pool-size-count :uint32)
  (:pool-sizes (:pointer (:struct vk-descriptor-pool-size))))

(defun make-descriptor-pool-inline-uniform-block-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-bindings :uint32))

(defun make-descriptor-set-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descript-pool vk-descriptor-pool)
  (:descript-set-count :uint32)
  (:set-layouts vk-descriptor-set-layout))

(defun make-descriptor-set-variable-descriptor-count-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descriptor-set-count :uint32)
  (:descriptor-counts (:pointer :uint32)))

(defun make-memory-requirements
  (:size vk-device-size)
  (:alignment vk-device-size)
  (:memory-type-bits :uint32))

(defun make-buffer-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))

(defun make-image-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defun make-image-plane-memory-requirements-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defun make-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-memory-requirements)))

(defun make-memory-dedicated-requirements
  (:type VkStructureType)
  (:next (:pointer :void))
  (:prefers-dedicated-allocation vk-bool-32)
  (:requires-dedicated-allocation vk-bool-32))

(defun make-bind-buffer-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defun make-bind-buffer-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defun make-bind-image-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg vk-image)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defun make-bind-image-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32))
  (:split-instance-bind-region-count :uint32)
  (:split-instance-bind-regions (:pointer (:struct vk-rect-2d))))

(defun make-bind-image-memory-swapchain-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:image-index :uint32))

(defun make-bind-image-plane-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defun make-geometry-triangles-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-data vk-buffer)
  (:veretex-offset vk-device-size)
  (:vertex-count :uint32)
  (:vertex-stride vk-device-size)
  (:vertex-format VkFormat)
  (:index-data vk-buffer)
  (:index-offset vk-device-size)
  (:index-count :uint32)
  (:index-type VkIndexType)
  (:transform-data vk-buffer)
  (:transform-offset vk-device-size))

(defun make-geometry-aabb-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aabb-data vk-buffer)
  (:num-aabbs :uint32)
  (:stride :uint32)
  (:offset vk-device-size))

(defun make-geometry-data-nv
  (:triangles (:struct vk-geometry-triangles-nv))
  (:aabbs (:struct vk-geometry-aabb-nv)))

(defun make-geometry-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry-data (:struct vk-geometry-data-nv))
  (:flags vk-geometry-flags-khr))

(defun make-acceleration-structure-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-nv)
  (:instance-count :uint32)
  (:geometry-count :uint32)
  (:geometries (:pointer (:struct vk-geometry-nv))))

(defun make-acceleration-structure-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:info (:struct vk-acceleration-structure-info-nv)))

(defun make-acceleration-structure-create-geometry-type-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:max-primitive-count :uint32)
  (:index-type VkIndexType)
  (:max-vertex-count :uint32)
  (:vertex-format VkFormat)
  (:allows-transforms vk-bool-32))

(defun make-acceleration-structure-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:max-geometry-count :uint32)
  (:geometry-infos (:pointer (:struct vk-acceleration-structure-create-geometry-type-info-khr)))
  (:device-address vk-device-address))

(defun make-acceleration-structure-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-acceleration-structure-memory-requirements-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:build-type VkAccelerationStructureBuildTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-bind-acceleration-structure-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defun make-acceleration-structure-device-address-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr))

(defun make-sampler-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-sampler-create-flags)
  (:mag-filter VkFilter)
  (:min-filter VkFilter)
  (:mipmap-mode VkSamplerMipmapMode)
  (:address-mode-u VkSamplerAddressMode)
  (:address-mode-v VkSamplerAddressMode)
  (:address-mode-w VkSamplerAddressMode)
  (:mip-lod-bias :float)
  (:anisotropy-enable vk-bool-32)
  (:max-anisotropy vk-bool-32)
  (:compare-enable vk-bool-32)
  (:compare-op VkCompareOp)
  (:min-lod :float)
  (:max-lod :float)
  (:border-color VkBorderColor)
  (:unnormalized-coordinates vk-bool-32))

(defun make-sampler-reduction-mode-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:reduction-mode VkSamplerReductionMode))

(defun make-sampler-ycbcr-conversion-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conversion vk-sampler-ycbcr-conversion))

(defun make-sampler-ycbcr-conversion-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format VkFormat)
  (:ycbcr-model VkSamplerYcbcrModelConversion)
  (:ycbcr-range VkSamplerYcbcrRange)
  (:components (:struct vk-component-mapping))
  (:x-chroma-offset VkChromaLocation)
  (:y-chroma-offset VkChromaLocation)
  (:chroma-filter VkFilter)
  (:force-explicit-reconstruction vk-bool-32))

(defun make-sampler-custom-border-color-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-color (:union vk-clear-value))
  (:format VkFormat))

(defun make-descriptor-set-layout-binding
  (:binding :uint32)
  (:descriptor-type VkDescriptorType)
  (:descriptor-count :uint32)
  (:stage-flags vk-shader-stage-flags)
  (:immutable-samplers (:pointer vk-sampler)))

(defun make-descriptor-set-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-set-layout-create-flags)
  (:binding-count :uint32)
  (:bindings (:pointer (:struct vk-descriptor-set-layout-binding))))

(defun make-descriptor-set-layout-binding-flags-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:binding-count :uint32)
  (:binding-flags (:pointer vk-descriptor-binding-flags)))

(defun make-descriptor-set-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported vk-bool-32))

(defun make-descriptor-set-variable-descriptor-count-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-variable-descriptor-count :uint32))

(defun make-push-constant-range
  (:stage-flags vk-shader-stage-flags)
  (:offset :uint32)
  (:size :uint32))

(defun make-pipeline-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-layout-create-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout))
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range))))

(defun make-descriptor-pool-size
  (:type VkDescriptorType)
  (:descriptor-count :uint32))

(defun make-descriptor-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-pool-create-flags)
  (:max-sets :uint32)
  (:pool-size-count :uint32)
  (:pool-sizes (:pointer (:struct vk-descriptor-pool-size))))

(defun make-descriptor-pool-inline-uniform-block-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-bindings :uint32))

(defun make-descriptor-set-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descript-pool vk-descriptor-pool)
  (:descript-set-count :uint32)
  (:set-layouts vk-descriptor-set-layout))

(defun make-descriptor-set-variable-descriptor-count-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descriptor-set-count :uint32)
  (:descriptor-counts (:pointer :uint32)))

(defun make-descriptor-image-info
  (:sampler vk-sampler)
  (:image-view vk-image-view)
  (:image-layout VkImageLayout))

(defun make-descriptor-buffer-info
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:range vk-device-size))

(defun make-write-descriptor-set
  (:type VkStructureType)
  (:next (:pointer :void))
  (:dst-set vk-descriptor-set)
  (:dst-binding :uint32)
  (:dst-array-element :uint32)
  (:descript-count :uint32)
  (:descriptor-type VkDescriptorType)
  (:image-info (:pointer (:struct vk-descriptor-image-info)))
  (:buffer-info (:pointer (:struct vk-descriptor-buffer-info)))
  (:texel-buffer-view (:pointer vk-buffer-view)))

(defun make-write-descriptor-set-inline-uniform-block-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:data-size :uint32)
  (:data (:pointer :void)))

(defun make-write-descriptor-set-acceleration-structure-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure-count :uint32)
  (:acceleration-structures vk-acceleration-structure-khr))

(defun make-copy-descriptor-set
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-set vk-descriptor-set)
  (:src-binding :uint32)
  (:src-array-element :uint32)
  (:dst-set vk-descriptor-set)
  (:dst-binding :uint32)
  (:dst-array-element :uint32)
  (:descriptor-count :uint32))

(defun make-descriptor-update-template-entry
  (:dst-binding :uint32)
  (:dst-array-element :uint32)
  (:descript-count :uint32)
  (:descriptor-type VkDescriptorType)
  (:offset size-t)
  (:stride size-t))

(defun make-descriptor-update-template-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-update-template-create-flags)
  (:descriptor-update-entry-count :uint32)
  (:descriptor-update-entries (:pointer (:struct vk-descriptor-update-template-entry)))
  (:template-type VkDescriptorUpdateTemplateType)
  (:descriptor-set-layout vk-descriptor-set-layout)
  (:pipeline-bind-point VkPipelineBindPoint)
  (:pipeline-layout vk-pipeline-layout)
  (:set :uint32))

(defun make-buffer-device-address-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))



(defun make-query-pool-performance-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:queue-family-index :uint32)
  (:counter-index-count :uint32)
  (:counter-indices (:pointer :uint32)))

(defcfun vk-performance-counter-result-khr
  (:i32 :uint32)
  (:i64 :uint64)
  (:u32 :uint32)
  (:u64 :uint64)
  (:f :float)
  (:d :double))

(defun make-acquire-profiling-lock-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-acquire-profiling-lock-flags-khr)
  (:timeout :uint64))

(defun make-initialize-performance-api-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:user-data (:pointer :void)))

(defcfun vk-performance-value-data-intel
  (:value32 :uint32)
  (:value64 :uint64)
  (:value-float :float)
  (:value-bool vk-bool-32)
  (:value-string (:pointer :char)))

(defun make-performance-value-intel
  (:type VkPerformanceValueTypeINTEL)
  (:data (:union vk-performance-value-data-intel)))

(defun make-query-pool-performance-query-create-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:performance-counters-sampling VkQueryPoolSamplingModeINTEL))

(defun make-performance-marker-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:marker :uint64))

(defun make-performance-stream-marker-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:marker :uint32))

(defun make-performance-override-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkPerformanceOverrideTypeINTEL)
  (:enable vk-bool-32)
  (:parameter :uint64))

(defun make-performance-configuration-acquire-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkPerformanceConfigurationTypeINTEL))

(defun make-clear-rect
  (:rect (:struct vk-rect-2d))
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(defun make-clear-attachment
  (:aspect-mask vk-image-aspect-flags)
  (:color-attachment :uint32)
  (:clear-values (:union vk-clear-value)))

(defun make-buffer-copy
  (:src-offset vk-device-size)
  (:dst-offset vk-device-size)
  (:size vk-device-size))

(defun make-image-subresource-layers
  (:aspect-mask vk-image-aspect-flags)
  (:mip-level :uint32)
  (:base-array-layer :uint32)
  (:layers-count :uint32))

(defun make-image-copy
  (:src-subresource (:struct vk-image-subresource-layers))
  (:src-offset (:struct vk-offset-3d))
  (:dst-subresource (:struct vk-image-subresource-layers))
  (:dst-offset (:struct vk-offset-3d))
  (:extent (:struct vk-extent-3d)))

(defun make-buffer-image-copy
  (:buffer-offset vk-device-size)
  (:buffer-row-length :uint32)
  (:buffer-image-height :uint32)
  (:image-subresource (:struct vk-image-subresource-layers))
  (:image-offset (:struct vk-offset-3d))
  (:image-extent (:struct vk-extent-3d)))

(defun make-image-blit
  (:src-subresource (:struct vk-image-subresource-layers))
  (:src-offset (:struct vk-offset-3d) :count 2)
  (:dst-subresource (:struct vk-image-subresource-layers))
  (:dst-offset (:struct vk-offset-3d) :count 2))

(defun make-image-resloved
  (:src-subresource (:struct vk-image-subresource-layers))
  (:src-offset (:struct vk-offset-3d))
  (:dst-subresource (:struct vk-image-subresource-layers))
  (:dst-offset (:struct vk-offset-3d))
  (:extent (:struct vk-extent-3d)))

(defun make-draw-indirect-command
  (:vertex-count :uint32)
  (:instance-count :uint32)
  (:firset-vertex :uint32)
  (:firset-instance :uint32))

(defun make-draw-indexed-indirect-command
  (:index-count :uint32)
  (:instance-count :uint32)
  (:firset-index :uint32)
  (:vertex-offset :int32)
  (:firset-instance :uint32))

(defun make-conditional-rendering-begin-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:flags vk-conditional-rendering-flags-ext))

(defun make-draw-mesh-tasks-indirect-command-nv
  (:task-count :uint32)
  (:first-task :uint32))

(defun make-pipeline-vertex-input-divisor-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-binding-divisor-count :uint32)
  (:vertex-binding-divisors (:pointer vk-conditional-rendering-flags-ext)))

(defun make-vertex-input-binding-divisor-description-ext
  (:binding :uint32)
  (:divisor :uint32))

(defun make-pipeline-tessellation-domain-origin-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:domain-origin VkTessellationDomainOrigin))

(defun make-viewport-swizzle-nv
  (:x VkViewportCoordinateSwizzleNV)
  (:y VkViewportCoordinateSwizzleNV)
  (:z VkViewportCoordinateSwizzleNV)
  (:w VkViewportCoordinateSwizzleNV))

(defun make-pipeline-viewport-swizzle-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-viewport-swizzle-state-create-flags-nv)
  (:view-port-count :uint32)
  (:view-port-swizzles (:pointer (:struct vk-viewport-swizzle-nv))))

(defun make-viewport-w-scaling-nv
  (:xcoeff :float)
  (:ycoeff :float))

(defun make-pipeline-viewport-w-scaling-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:view-port-w-scaling-enable vk-bool-32)
  (:view-port-count :uint32)
  (:view-port-w-scalings (:pointer (:struct vk-viewport-w-scaling-nv))))

(defun make-pipeline-rasterization-depth-clip-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-rasterization-depth-clip-state-create-flags-ext)
  (:depth-clip-enable vk-bool-32))

(defun make-pipeline-rasterization-state-stream-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-rasterization-state-stream-create-flags-ext)
  (:rasterization-stream :uint32))

(defun make-pipeline-rasterization-state-rasterization-order-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:rasterization-order VkRasterizationOrderAMD))

(defun make-pipeline-sample-locations-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sampler-locations-enable vk-bool-32)
  (:sampler-locations-info (:struct vk-sample-locations-info-ext)))

(defun make-shading-rate-palette-nv
  (:shading-rate-palette-entry-count :uint32)
  (:shading-rate-palette-entries (:pointer VkShadingRatePaletteEntryNV)))

(defun make-pipeline-viewport-shading-rate-image-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shading-rate-image-enable vk-bool-32)
  (:view-port-count :uint32)
  (:shading-rate-palettes (:pointer (:struct vk-shading-rate-palette-nv))))

(defun make-coarse-sample-location-nv
  (:pixel-x :uint32)
  (:pixel-y :uint32)
  (:sample :uint32))

(defun make-coarse-sample-order-custom-nv
  (:shading-rate VkShadingRatePaletteEntryNV)
  (:sample-count :uint32)
  (:sample-location-count :uint32)
  (:sample-locations (:pointer (:struct vk-coarse-sample-location-nv))))

(defun make-pipeline-viewport-coarse-sample-order-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sample-order-type VkCoarseSampleOrderTypeNV)
  (:custom-sample-order-count :uint32)
  (:custom-sample-orders (:pointer (:struct vk-coarse-sample-order-custom-nv))))

(defun make-pipeline-rasterization-line-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:line-rasterization-mode VkLineRasterizationModeEXT)
  (:stippled-line-enable vk-bool-32)
  (:line-stipple-factor :uint32)
  (:line-stipple-pattern :uint16))

(defun make-pipeline-rasterization-conservative-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-rasterization-conservative-state-create-flags-ext)
  (:conservative-rasterization-mode VkConservativeRasterizationModeEXT)
  (:extra-primitive-overestimation-size :float))

(defun make-pipeline-discard-rectangle-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-discard-rectangle-state-create-flags-ext)
  (:discard-rectangle-mode VkDiscardRectangleModeEXT)
  (:discard-rectangle-count :uint32)
  (:discard-rectangles (:pointer (:struct vk-rect-2d))))

(defun make-pipeline-viewport-exclusive-scissor-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:exclusive-scissor-count :uint32)
  (:discard-rectangle-count (:pointer (:struct vk-rect-2d))))

(defun make-pipeline-representative-fragment-test-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:representative-fragment-test-enable vk-bool-32))

(defun make-pipeline-coverage-to-color-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-coverage-to-color-state-create-flags-nv)
  (:coverage-to-color-enable vk-bool-32)
  (:coverage-to-color-location :uint32))

(defun make-pipeline-coverage-reduction-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-coverage-reduction-state-create-flags-nv)
  (:coverage-reduction-mode VkCoverageReductionModeNV))

(defun make-framebuffer-mixed-samples-combination-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:coverage-reduction-mode VkCoverageReductionModeNV)
  (:rasterization-samples VkSampleCountFlagBits)
  (:depth-stencil-samples vk-sample-count-flags)
  (:color-samples vk-sample-count-flags))

(defun make-pipeline-coverage-modulation-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-coverage-modulation-state-create-flags-nv)
  (:coverage-modulation-mod VkCoverageModulationModeNV)
  (:coverage-modulation-table-enable vk-bool-32)
  (:coverage-modulation-table-count :uint32)
  (:coverage-modulation-table (:pointer :float)))

(defun make-pipeline-color-blend-advanced-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-premultiplied vk-bool-32)
  (:dst-premultiplied vk-bool-32)
  (:blend-overlap VkBlendOverlapEXT))

(defun make-dispatch-indirect-command
  (:x :uint32)
  (:y :uint32)
  (:z :uint32))

(defun make-indirect-commands-layout-token-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:token-type VkIndirectCommandsTokenTypeNV)
  (:stream :uint32)
  (:offset :uint32)
  (:vertex-binding-unit :uint32)
  (:vertex-dynamic-stride :uint32)
  (:pushconstant-pipeline-layout vk-pipeline-layout)
  (:pushconstant-shader-stage-flags vk-shader-stage-flags)
  (:pushconstant-offset :uint32)
  (:pushconstant-size :uint32)
  (:indirect-state-flags vk-indirect-state-flags-nv)
  (:index-type-count :uint32)
  (:index-type (:pointer VkIndexType))
  (:index-type-value (:pointer :uint32)))

(defun make-indirect-commands-layout-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-indirect-commands-layout-usage-flags-nv)
  (:pipeline-bind-point VkPipelineBindPoint)
  (:token-count :uint32)
  (:tokens (:pointer (:struct vk-indirect-commands-layout-token-nv)))
  (:stream-count :uint32)
  (:stream-strides (:pointer :uint32)))

(defun make-indirect-commands-stream-nv
  (:buffer vk-buffer)
  (:offset vk-device-size))

(defun make-bind-shader-group-indirect-command-nv
  (:group-index :uint32))

(defun make-bind-index-buffer-indirect-command-nv
  (:buffer-address vk-device-address)
  (:size :uint32)
  (:index-type VkIndexType))

(defun make-bind-vertex-buffer-indirect-command-nv
  (:buffer-address vk-device-address)
  (:size :uint32)
  (:stride :uint32))

(defun make-set-state-flags-indirect-command-nv
  (:data :uint32))

(defun make-generated-commands-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-bind-point VkPipelineBindPoint)
  (:pipeline vk-pipeline)
  (:indirect-commands-layout vk-indirect-commands-layout-nv)
  (:max-sequences-count :uint32))

(defun make-generated-commands-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-bind-point VkPipelineBindPoint)
  (:pipeline vk-pipeline)
  (:indirect-commands-layout vk-indirect-commands-layout-nv)
  (:stream-count :uint32)
  (:streams (:pointer (:struct vk-indirect-commands-stream-nv)))
  (:sequence-count :uint32)
  (:preprocess-buffer vk-buffer)
  (:preprocess-offset vk-device-size)
  (:preprocess-size vk-device-size)
  (:sequences-count-buffer vk-buffer)
  (:sequences-count-offset vk-device-size)
  (:sequences-index-buffer vk-buffer)
  (:sequences-index-offset vk-device-size))

(defun make-physical-device-sparse-properties
  (:residency-standard2-d-block-shape vk-bool-32)
  (:residency-standard2-d-multisample-block-shape vk-bool-32)
  (:residency-standard3-d-block-shape vk-bool-32)
  (:residency-aligned-mip-size vk-bool-32)
  (:residency-non-resident-strict vk-bool-32))

(defun make-sparse-image-format-properties
  (:aspect-mask vk-image-aspect-flags)
  (:image-granularity (:struct vk-extent-3d))
  (:flags vk-sparse-image-format-flags))

(defun make-physical-device-sparse-image-format-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format VkFormat)
  (:type VkImageType)
  (:samples VkSampleCountFlagBits)
  (:usage vk-image-usage-flags)
  (:tiling VkImageTiling))

(defun make-sparse-image-format-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:properties (:struct vk-sparse-image-format-properties)))

(defun make-sparse-image-memory-requirements
  (:format-properties (:struct vk-sparse-image-format-properties))
  (:image-mip-tail-first-lod :uint32)
  (:image-mip-tail-size vk-device-size)
  (:image-mip-tail-offset vk-device-size)
  (:image-mip-tail-stride vk-device-size))

(defun make-image-sparse-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defun make-sparse-image-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-sparse-image-memory-requirements)))

(defun make-sparse-memory-bind
  (:resource-offset vk-device-size)
  (:size vk-device-size)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:flags vk-sparse-memory-bind-flags))

(defun make-sparse-buffer-memory-bind-info
  (:buffer vk-buffer)
  (:bind-count :uint32)
  (:binds (:pointer (:struct vk-sparse-memory-bind))))

(defun make-sparse-image-opaque-memory-bind-info
  (:image vk-image)
  (:bind-count :uint32)
  (:binds (:pointer (:struct vk-sparse-memory-bind))))

(defun make-sparse-image-memory-bind
  (:subresource (:struct vk-image-subresource))
  (:offset (:struct vk-offset-3d))
  (:extent (:struct vk-extent-3d))
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:flags vk-sparse-memory-bind-flags))

(defun make-sparse-image-memory-bind-info
  (:image vk-image)
  (:bind-count :uint32)
  (:binds (:pointer (:struct vk-sparse-image-memory-bind))))

(defun make-bind-sparse-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphores (:pointer vk-semaphore))
  (:buffer-bind-count :uint32)
  (:buffer-binds (:pointer (:struct vk-sparse-buffer-memory-bind-info)))
  (:image-opaque-bind-count :uint32)
  (:image-opaque-binds (:pointer (:struct vk-sparse-image-opaque-memory-bind-info)))
  (:image-bind-count :uint32)
  (:image-binds (:pointer (:struct vk-sparse-image-memory-bind-info)))
  (:signal-semaphore-count :uint32)
  (:signal-semaphores (:pointer vk-semaphore)))

(defun make-device-group-bind-sparse-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:resource-device-index :uint32)
  (:memory-device-index :uint32))

#|
(defun make-wayland-surface-create-info-khr)
(defun make-win32-surface-create-info-khr)
(defun make-xcb-surface-create-info-khr)
(defun make-xlib-surface-create-info-khr)
(defun make-direct-f-b-surface-create-info-ext)
(defun make-image-pipe-surface-create-info-fuchsia)
(defun make-stream-descriptor-surface-create-info-ggp)
(defun make-ios-surface-create-info-mvk)
(defun make-macos-surface-create-info-mvk)
(defun make-vi-surface-create-info-nn)
(defun make-metal-surface-create-info-ext)
|#

(defun make-display-properties-khr
  (:display vk-display-khr)
  (:display-name (:pointer :char))
  (:physical-dimensions (:struct vk-extent-2d))
  (:physical-resolution (:struct vk-extent-2d))
  (:supported-transforms vk-surface-transform-flags-khr)
  (:plane-reorder-possible vk-bool-32)
  (:persistent-content vk-bool-32))

(defun make-display-properties2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-properties (:struct vk-display-properties-khr)))

(defun make-display-plane-properties-khr
  (:current-display vk-display-khr)
  (:current-stack-index :uint32))

(defun make-display-plane-properties2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-plane-properties (:struct vk-display-plane-properties-khr)))

(defun make-display-mode-parameters-khr
  (:visible-region (:struct vk-extent-2d))
  (:refresh-rate :uint32))

(defun make-display-mode-properties-khr
  (:display-mode vk-display-mode-khr)
  (:parameter (:struct vk-display-mode-parameters-khr)))

(defun make-display-mode-properties2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-mode-properties (:struct vk-display-mode-properties-khr)))

(defun make-display-mode-parameters-khr
  (:visible-region (:struct vk-extent-2d))
  (:refresh-rate :uint32))

(defun make-display-mode-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-display-mode-create-flags-khr)
  (:parameters (:struct vk-display-mode-parameters-khr)))

(defun make-display-plane-capabilities-khr
  (:supported-alpha vk-display-plane-alpha-flags-khr)
  (:min-src-position (:struct vk-offset-2d))
  (:max-src-position (:struct vk-offset-2d))
  (:min-src-extent (:struct vk-extent-2d))
  (:max-src-extent (:struct vk-extent-2d))
  (:min-dst-position (:struct vk-offset-2d))
  (:max-dst-position (:struct vk-offset-2d))
  (:min-dst-extent (:struct vk-extent-2d))
  (:max-dst-extent (:struct vk-extent-2d)))

(defun make-display-plane-info2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:mode vk-display-mode-khr)
  (:plane-index :uint32))

(defun make-display-plane-capabilities2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:capability (:struct vk-display-plane-capabilities-khr)))

(defun make-display-power-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:power-state VkDisplayPowerStateEXT))

(defun make-display-surface-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-display-surface-create-flags-khr)
  (:display-mode vk-display-mode-khr)
  (:plane-index :uint32)
  (:plane-stack-index :uint32)
  (:transform VkSurfaceTransformFlagBitsKHR)
  (:global-alpha :float)
  (:alpha-mode VkDisplayPlaneAlphaFlagBitsKHR)
  (:image-extent (:struct vk-extent-2d)))

(defun make-headless-surface-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-headless-surface-create-flags-ext))

(defun make-surface-capabilities-khr
  (:min-image-count :uint32)
  (:max-image-count :uint32)
  (:current-extent (:struct vk-extent-2d))
  (:min-image-extent (:struct vk-extent-2d))
  (:max-image-extent (:struct vk-extent-2d))
  (:max-image-array-layers :uint32)
  (:supported-transforms :uint32)
  (:current-transform :uint32)
  (:supported-composite-alpha :uint32)
  (:supported-usage-flags :uint32))

(defun make-physical-device-surface-info2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface vk-surface-khr))

(defun make-surface-full-screen-exclusive-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:full-screen-exclusive VkFullScreenExclusiveEXT))

(defun make-surface-full-screen-exclusive-win32-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:hmonitor (:pointer :void)))

(defun make-surface-capabilities2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface-capabilities (:struct vk-surface-capabilities-khr)))

(defun make-surface-protected-capabilities-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supports-protected vk-bool-32))

(defun make-shared-present-surface-capabilities-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shared-present-supported-usage-flags vk-image-usage-flags))

(defun make-display-native-hdr-surface-capabilities-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:local-dimming-support vk-bool-32))

(defun make-surface-capabilities-full-screen-exclusive-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:full-screen-exclusive-supported vk-bool-32))

(defun make-surface-capabilities2-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:min-image-count :uint32)
  (:max-image-count :uint32)
  (:current-extent (:struct vk-extent-2d))
  (:min-image-extent (:struct vk-extent-2d))
  (:max-image-extent (:struct vk-extent-2d))
  (:max-image-array-layers :uint32)
  (:supported-transforms vk-surface-transform-flags-khr)
  (:current-transform VkSurfaceTransformFlagBitsKHR)
  (:supported-composite-alpha vk-composite-alpha-flags-khr)
  (:supported-usage-flags vk-image-usage-flags)
  (:supported-surface-counters vk-surface-counter-flags-ext))

(defun make-surface-format-khr
  (:format VkFormat)
  (:color-space VkColorSpaceKHR))

(defun make-surface-format2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface-format (:struct vk-surface-format-khr)))

(defun make-device-group-present-capabilities-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:present-mask :uint32 :count 32)
  (:modes vk-device-group-present-mode-flags-khr))

(defun make-refresh-cycle-duration-google
  (:refresh-duration :uint64))

(defun make-past-presentation-timing-google
  (:present-id :uint32)
  (:desired-present-time :uint64)
  (:actual-present-time :uint64)
  (:earliest-present-time :uint64)
  (:present-margin :uint64))

(defun make-swapchain-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-swapchain-create-flags)
  (:surface vk-surface-khr)
  (:min-image-count :uint32)
  (:image-format VkFormat)
  (:image-color-space VkColorSpaceKHR)
  (:image-extent (:struct vk-extent-2d))
  (:image-array-layers :uint32)
  (:image-usage vkImageUsageFlagBits)
  (:image-sharing-mode VkSharingMode)
  (:queue-family-index-count :uint32)
  (:queue-family-indices (:pointer :uint32))
  (:pre-transform VkSurfaceTransformFlagBitsKHR)
  (:composite-alpha VkCompositeAlphaFlagBitsKHR)
  (:present-mode VkPresentModeKHR)
  (:clipped vk-bool-32)
  (:old-swapchain vk-swapchain-khr))

(defun make-device-group-swapchain-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:modes vk-device-group-present-mode-flags-khr))

(defun make-swapchain-display-native-hdr-create-info-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:local-dimming-enable vk-bool-32))

(defun make-swapchain-counter-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface-counters vk-surface-counter-flags-ext))

(defun make-acquire-next-image-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:timeout :uint64)
  (:semaphore vk-semaphore)
  (:fence vk-fence)
  (:device-mask :uint32))

(defun make-present-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphore (:pointer vk-semaphore))
  (:swapchain-count :uint32)
  (:swapchain (:pointer vk-swapchain-khr))
  (:image-indices (:pointer :uint32))
  (:result VkResult))

(defun make-present-regions-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain-count :uint32)
  (:regions (:pointer (:struct vk-present-regions-khr))))

(defun make-rect-layer-khr
  (:offset (:struct vk-offset-2d))
  (:extent (:struct vk-extent-2d))
  (:layer :uint32))

(defun make-display-present-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-rect (:struct vk-rect-2d))
  (:dst-rect (:struct vk-rect-2d))
  (:persistent vk-bool-32))

(defun make-device-group-present-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain-count :uint32)
  (:device-mask (:pointer :uint32))
  (:mode VkDeviceGroupPresentModeFlagBitsKHR))

(defun make-present-time-google
  (:present-id :uint32)
  (:desired-present-time :uint64))

(defun make-present-times-info-google
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain-count :uint32)
  (:times (:pointer (:struct vk-present-time-google))))

(defun make-present-frame-token-ggp
  (:type VkStructureType)
  (:next (:pointer :void))
  (:frame-token :uint32))   ;;maybe ??

(defun make-xy-color-ext
  (:x :float)
  (:y :float))

(defun make-hdr-metadata-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-primary-red (:struct vk-xy-color-ext))
  (:display-primary-green (:struct vk-xy-color-ext))
  (:display-primary-blue (:struct vk-xy-color-ext))
  (:white-point (:struct vk-xy-color-ext))
  (:max-luminance :float)
  (:min-luminance :float)
  (:max-content-light-level :float)
  (:max-frame-average-light-level :float))

(defun make-deferred-operation-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:operation-handle vk-deferred-operation-khr))

(defun make-private-data-slot-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-private-data-slot-create-flags-ext))

(defun make-strided-buffer-region-khr
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:stride vk-device-size)
  (:size vk-device-size))

(defun make-trace-rays-indirect-command-khr
  (:width :uint32)
  (:height :uint32)
  (:depth :uint32))

(defcfun vk-device-or-host-address-const-khr
  (:device-address vk-device-address)
  (:host-address (:pointer :void)))

(defun make-acceleration-structure-geometry-triangles-data-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-format VkFormat)
  (:vertex-data (:union vk-device-or-host-address-const-khr))
  (:vertex-stride vk-device-size)
  (:index-type VkIndexType)
  (:index-data (:union vk-device-or-host-address-const-khr))
  (:transform-data (:union vk-device-or-host-address-const-khr)))

(defun make-acceleration-structure-geometry-aabbs-data-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:data (:union vk-device-or-host-address-const-khr))
  (:stride vk-device-size))

(defun make-acceleration-structure-geometry-instances-data-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:array-of-pointers vk-bool-32)
  (:data (:union vk-device-or-host-address-const-khr)))

(defcfun vk-acceleration-structure-geometry-data-khr
  (:triangles (:struct vk-acceleration-structure-geometry-triangles-data-khr))
  (:aabbs (:struct vk-acceleration-structure-geometry-aabbs-data-khr))
  (:instances (:struct vk-acceleration-structure-geometry-instances-data-khr)))

(defun make-acceleration-structure-geometry-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry (:union vk-acceleration-structure-geometry-data-khr))
  (:flags vk-geometry-flags-khr))

(defcfun vk-device-or-host-address-khr
  (:device-address vk-device-address)
  (:host-address (:pointer :void)))

(defun make-acceleration-structure-build-geometry-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:update vk-bool-32)
  (:src-acceleration-structure vk-acceleration-structure-khr)
  (:dst-acceleration-structure vk-acceleration-structure-khr)
  (:geometry-array-of-pointers vk-bool-32)
  (:scratch-data (:union vk-device-or-host-address-khr)))

(defun make-transform-matrix-khr
  (:matrix :float :count 3 :count 4))

(defun make-aabb-positions-khr
  (:minx :float)
  (:miny :float)
  (:minz :float)
  (:maxx :float)
  (:maxy :float)
  (:maxz :float))

(defun make-acceleration-structure-instance-khr
  (:transform (:struct vk-transform-matrix-khr))
  (:instance-custom-index :uint32)                        ;;initialize as 24
  (:mask :uint32)                                         ;;initialize as 8
  (:instance-shader-binding-table-record-offset :uint32)  ;;initialize as 24
  (:flags vk-geometry-instance-flags-khr)                 ;;initialize as 8
  (:acceleration-structure-reference :uint64))

(defun make-acceleration-structure-build-offset-info-khr
  (:primitive-count :uint32)
  (:primitive-offset :uint32)
  (:first-vertex :uint32)
  (:transform-offset :uint32))

(defun make-copy-acceleration-structure-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src vk-acceleration-structure-khr)
  (:dst vk-acceleration-structure-khr)
  (:mode VkCopyAccelerationStructureModeKHR))

(defun make-copy-acceleration-structure-to-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src vk-acceleration-structure-khr)
  (:dst (:union vk-device-or-host-address-khr))
  (:mode VkCopyAccelerationStructureModeKHR))

(defun make-copy-memory-to-acceleration-structure-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src (:union vk-device-or-host-address-const-khr))
  (:dst vk-acceleration-structure-khr)
  (:mode VkCopyAccelerationStructureModeKHR))

(defun make-acceleration-structure-version-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:version-data (:pointer :uint8)))

(defun make-layer-properties
  (:layer-name :char :count 256)
  (:spec-version :uint32)
  (:implementation-version :uint32)
  (:description :char :count 256))

(defun make-extension-properties
  (:extension-name :char :count 256)
  (:spec-version :uint32))

(defun make-physical-device-features2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:feature (:struct vk-physical-device-features)))

(defun make-physical-device-vulkan11-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:storage-buffer16-bit-access vk-bool-32)
  (:uniform-and-storage-buffer-16-bit-access vk-bool-32)
  (:storage-push-constant-16 vk-bool-32)
  (:storage-input-output-16 vk-bool-32)
  (:multiview vk-bool-32)
  (:multiview-geometry-shader vk-bool-32)
  (:multiview-tessellation-shader vk-bool-32)
  (:variable-pointers-storage-buffer vk-bool-32)
  (:variable-pointers vk-bool-32)
  (:protected-memory vk-bool-32)
  (:sampler-ycbcr-conversion vk-bool-32)
  (:shader-draw-parameters vk-bool-32))

(defun make-physical-device-vulkan12-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sampler-mirror-clamp-to-edge vk-bool-32)
  (:draw-indirect-count vk-bool-32)
  (:storage-buffer8-bit-access vk-bool-32)
  (:uniform-and-storage-buffer8-bit-access vk-bool-32)
  (:storage-push-constant8 vk-bool-32)
  (:shader-buffer-int64-atomics vk-bool-32)
  (:shader-shared-int64-atomics vk-bool-32)
  (:shader-float16 vk-bool-32)
  (:shader-int8 vk-bool-32)
  (:descriptor-indexing vk-bool-32)
  (:shader-input-attachment-array-dynamic-indexing vk-bool-32)
  (:shader-uniform-texel-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-storage-texel-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-uniform-buffer-array-non-uniform-indexing vk-bool-32)
  (:shader-sampled-image-array-non-uniform-indexing vk-bool-32)
  (:shader-storage-buffer-array-non-uniform-indexing vk-bool-32)
  (:shader-storage-image-array-non-uniform-indexing vk-bool-32)
  (:shader-input-attachment-array-non-uniform-indexing vk-bool-32)
  (:shader-uniform-texel-buffer-array-non-uniform-indexing vk-bool-32)
  (:shader-storage-texel-buffer-array-non-uniform-indexing vk-bool-32)
  (:descriptor-binding-uniform-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-sampled-image-update-after-bind vk-bool-32)
  (:descriptor-binding-storage-image-update-after-bind vk-bool-32)
  (:descriptor-binding-storage-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-uniform-texel-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-storage-texel-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-update-unused-while-pending vk-bool-32)
  (:descriptor-binding-partially-bound vk-bool-32)
  (:descriptor-binding-variable-descriptor-count vk-bool-32)
  (:runtime-descriptor-array vk-bool-32)
  (:sampler-filter-minmax vk-bool-32)
  (:scalar-block-layout vk-bool-32)
  (:imageless-framebuffer vk-bool-32)
  (:uniform-buffer-standard-layout vk-bool-32)
  (:shader-subgroup-extended-types vk-bool-32)
  (:separate-depth-stencil-layouts vk-bool-32)
  (:host-query-reset vk-bool-32)
  (:timeline-semaphore vk-bool-32)
  (:buffer-device-address vk-bool-32)
  (:buffer-device-address-capture-replay vk-bool-32)
  (:buffer-device-address-multi-device vk-bool-32)
  (:vulkan-memory-model vk-bool-32)
  (:vulkan-memory-model-device-scope vk-bool-32)
  (:vulkan-memory-model-availability-visibility-chains vk-bool-32)
  (:shader-output-viewport-index vk-bool-32)
  (:shader-output-layer vk-bool-32)
  (:subgroup-broadcast-dynamic-id vk-bool-32))

(defun make-physical-device-variable-pointers-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:variable-pointers-storage-buffer vk-bool-32)
  (:variable-pointers vk-bool-32))

(defun make-physical-device-multiview-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:multiview vk-bool-32)
  (:multiview-geometry-shader vk-bool-32)
  (:multiview-tessellation-shader vk-bool-32))

(defun make-physical-device-shader-atomic-float-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-buffer-float-32-atomics vk-bool-32)
  (:shader-buffer-float-32-atomic-add vk-bool-32)
  (:shader-buffer-float-64-atomics vk-bool-32)
  (:shader-buffer-float-64-atomic-add vk-bool-32)
  (:shader-shared-float-32-atomics vk-bool-32)
  (:shader-shared-float-32-atomic-add vk-bool-32)
  (:shader-shared-float-64-atomics vk-bool-32)
  (:shader-shared-float-64-atomic-add vk-bool-32)
  (:shader-image-float-32-atomics vk-bool-32)
  (:shader-image-float-32-atomic-add vk-bool-32)
  (:sparse-image-float-32-atomics vk-bool-32)
  (:sparse-image-float-32-atomic-add vk-bool-32))

(defun make-physical-device-shader-atomic-int-64-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-buffer-int-64-atomics vk-bool-32)
  (:shader-shared-int-64-atomics vk-bool-32))

(defun make-physical-device-8-bit-storage-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:storage-buffer-8-bit-access vk-bool-32)
  (:uniform-and-storage-buffer-8-bit-access vk-bool-32)
  (:storage-push-constant-8 vk-bool-32))

(defun make-physical-device-16-bit-storage-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:storage-buffer-16-bit-access vk-bool-32)
  (:uniform-and-storage-buffer-16-bit-access vk-bool-32)
  (:storage-push-constant-16 vk-bool-32))

(defun make-physical-device-shader-float-16-int-8-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-float-16 vk-bool-32)
  (:shader-int8 vk-bool-32))

(defun make-physical-device-shader-clock-features-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-subgroup-clock vk-bool-32)
  (:shader-device-clock vk-bool-32))

(defun make-physical-device-sampler-ycbcr-conversion-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sampler-ycbcr-conversion vk-bool-32))

(defun make-physical-device-protected-memory-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:protected-memory vk-bool-32))

(defun make-physical-device-blend-operation-advanced-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:advanced-blend-coherent-operations vk-bool-32))

(defun make-physical-device-conditional-rendering-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conditional-rendering vk-bool-32)
  (:inherited-conditional-rendering vk-bool-32))

(defun make-physical-device-shader-draw-parameters-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-draw-parameters vk-bool-32))

(defun make-physical-device-mesh-shader-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:task-shader vk-bool-32)
  (:mesh-shader vk-bool-32))

(defun make-physical-device-descriptor-indexing-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-input-attachment-array-dynamic-indexing vk-bool-32)
  (:shader-uniform-texel-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-storage-texel-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-uniform-buffer-array-non-uniform-indexing vk-bool-32)
  (:shader-sampled-image-array-non-uniform-indexing vk-bool-32)
  (:shader-storage-buffer-array-non-uniform-indexing vk-bool-32)
  (:shader-storage-image-array-non-uniform-indexing vk-bool-32)
  (:shader-input-attachment-array-non-uniform-indexing vk-bool-32)
  (:shader-uniform-texel-buffer-array-non-uniform-indexing vk-bool-32)
  (:shader-storage-texel-buffer-array-non-uniform-indexing vk-bool-32)
  (:descriptor-binding-uniform-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-sampled-image-update-after-bind vk-bool-32)
  (:descriptor-binding-storage-image-update-after-bind vk-bool-32)
  (:descriptor-binding-storage-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-uniform-texel-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-storage-texel-buffer-update-after-bind vk-bool-32)
  (:descriptor-binding-update-unused-while-pending vk-bool-32)
  (:descriptor-binding-partially-bound vk-bool-32)
  (:descriptor-binding-variable-descriptor-count vk-bool-32)
  (:runtime-descriptor-array vk-bool-32))

(defun make-physical-device-vertex-attribute-divisor-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-attribute-instance-rate-divisor vk-bool-32)
  (:vertex-attribute-instance-rate-zero-divisor vk-bool-32))

(defun make-physical-device-a-s-t-c-decode-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:decode-mode-shared-exponent vk-bool-32))

(defun make-physical-device-transform-feedback-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:transform-feedback vk-bool-32)
  (:geometry-streams vk-bool-32))

(defun make-physical-device-vulkan-memory-model-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vulkan-memory-model vk-bool-32)
  (:vulkan-memory-model-device-scope vk-bool-32)
  (:vulkan-memory-model-availability-visibility-chains vk-bool-32))

(defun make-physical-device-inline-uniform-block-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:inline-uniform-block vk-bool-32)
  (:descriptor-binding-inline-uniform-block-update-after-bind vk-bool-32))

(defun make-physical-device-representative-fragment-test-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:representative-fragment-test vk-bool-32))

(defun make-physical-device-exclusive-scissor-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:exclusive-scissor vk-bool-32))

(defun make-physical-device-corner-sampled-image-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:corner-sampled-image vk-bool-32))

(defun make-physical-device-compute-shader-derivatives-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compute-derivative-group-quads vk-bool-32)
  (:compute-derivative-group-linear vk-bool-32))

(defun make-physical-device-fragment-shader-barycentric-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-shader-barycentric vk-bool-32))

(defun make-physical-device-shader-image-footprint-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg-footprint vk-bool-32))

(defun make-physical-device-shading-rate-image-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shading-rate-image vk-bool-32)
  (:shading-rate-coarse-sample-order vk-bool-32))

(defun make-physical-device-fragment-density-map-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-density-map vk-bool-32)
  (:fragment-density-map-dynamic vk-bool-32)
  (:fragment-density-map-non-subsampled-images vk-bool-32))

(defun make-physical-device-fragment-density-map2-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-density-map-deferred vk-bool-32))

(defun make-physical-device-scalar-block-layout-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:scalar-block-layout vk-bool-32))

(defun make-physical-device-uniform-buffer-standard-layout-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:uniform-buffer-standard-layout vk-bool-32))

(defun make-physical-device-depth-clip-enable-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:depth-clip-enable vk-bool-32))

(defun make-physical-device-memory-priority-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-prioryity vk-bool-32))

(defun make-physical-device-buffer-device-address-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer-device-address vk-bool-32)
  (:buffer-device-address-capture-replay vk-bool-32)
  (:buffer-device-address-multi-device vk-bool-32))

(defun make-physical-device-buffer-device-address-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer-device-address vk-bool-32)
  (:buffer-device-address-capture-replay vk-bool-32)
  (:buffer-device-address-multi-device vk-bool-32))

(defun make-physical-device-dedicated-allocation-image-aliasing-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:dedicated-allocation-image-aliasing vk-bool-32))

(defun make-physical-device-imageless-framebuffer-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imageless-framebuffer vk-bool-32))

(defun make-physical-device-fragment-shader-interlock-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-shader-sample-interlock vk-bool-32)
  (:fragment-shader-pixel-interlock vk-bool-32)
  (:fragment-shader-shading-rate-interlock vk-bool-32))

(defun make-physical-device-cooperative-matrix-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:cooperative-matrix vk-bool-32)
  (:cooperative-matrix-robust-buffer-access vk-bool-32))

(defun make-physical-device-ycbcr-image-arrays-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:ycbcr-image-arrays vk-bool-32))

(defun make-physical-device-shader-subgroup-extended-types-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-subgroup-extended-types vk-bool-32))

(defun make-physical-device-host-query-reset-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:host-query-reset vk-bool-32))

(defun make-physical-device-shader-integer-functions2-features-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-integer-functions2 vk-bool-32))

(defun make-physical-device-coverage-reduction-mode-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:coverage-reduction-mode vk-bool-32))

(defun make-physical-device-timeline-semaphore-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:timeline-semaphore vk-bool-32))

(defun make-physical-device-index-type-uint8-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:index-type-uint8 vk-bool-32))

(defun make-physical-device-shader-sm-builtins-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-sm-builtins vk-bool-32))

(defun make-physical-device-separate-depth-stencil-layouts-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:separate-depth-stencil-layouts vk-bool-32))

(defun make-physical-device-pipeline-executable-properties-features-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-executable-info vk-bool-32))

(defun make-physical-device-shader-demote-to-helper-invocation-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-demote-to-helper-invocation vk-bool-32))

(defun make-physical-device-texel-buffer-alignment-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:texel-buffer-alignment vk-bool-32))

(defun make-physical-device-texture-compression-astchdr-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:texture-compression-astc-hdr vk-bool-32))

(defun make-physical-device-line-rasterization-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:rectangular-lines vk-bool-32)
  (:bresenham-lines vk-bool-32)
  (:smooth-lines vk-bool-32)
  (:stippled-rectangular-lines vk-bool-32)
  (:stippled-bresenham-lines vk-bool-32)
  (:stippled-smooth-lines vk-bool-32))

(defun make-physical-device-subgroup-size-control-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subgroup-size-control vk-bool-32)
  (:compute-full-subgroups vk-bool-32))

(defun make-physical-device-coherent-memory-features-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-coherent-memory vk-bool-32))

(defun make-physical-device-ray-tracing-features-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:ray-tracing vk-bool-32)
  (:ray-tracing-shader-group-handle-capture-replay vk-bool-32)
  (:ray-tracing-shader-group-handle-capture-replay-mixed vk-bool-32)
  (:ray-tracing-acceleration-structure-capture-replay vk-bool-32)
  (:ray-tracing-indirect-trace-rays vk-bool-32)
  (:ray-tracing-indirect-acceleration-structure-build vk-bool-32)
  (:ray-tracing-host-acceleration-structure-commands vk-bool-32)
  (:ray-query vk-bool-32)
  (:ray-tracing-primitive-culling vk-bool-32))

(defun make-physical-device-extended-dynamic-state-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:extended-dynamic-state vk-bool-32))

(defun make-physical-device-device-generated-commands-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-generated-commands vk-bool-32))

(defun make-physical-device-diagnostics-config-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:diagnostics-config vk-bool-32))

(defun make-physical-device-pipeline-creation-cache-control-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-creation-cache-control vk-bool-32))

(defun make-physical-device-private-data-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:private-data vk-bool-32))

(defun make-physical-device-robustness2-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:robust-buffer-access2 vk-bool-32)
  (:robust-image-access2 vk-bool-32)
  (:null-descriptor vk-bool-32))

(defun make-physical-device-image-robustness-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:robust-image-access vk-bool-32))

(defun make-physical-device-custom-border-color-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-colors vk-bool-32)
  (:custom-border-color-without-format vk-bool-32))

(defun make-physical-device-performance-query-features-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:performance-counter-query-pools vk-bool-32)
  (:performance-counter-multiple-query-pools vk-bool-32))

(defun make-physical-device-4444-formats-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format-a4-r4-g4-b4 vk-bool-32)
  (:format-a4-b4-g4-r4 vk-bool-32))

(defun make-physical-device-push-descriptor-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-push-descriptors :uint32))

(defun make-physical-device-multiview-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-multiview-view-count :uint32)
  (:max-multiview-instance-index :uint32))

(defun make-physical-device-float-controls-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:denorm-behavior-independence VkShaderFloatControlsIndependence)
  (:rounding-mode-independence VkShaderFloatControlsIndependence)
  (:shader-signed-zero-inf-nan-preserve-float16 vk-bool-32)
  (:shader-signed-zero-inf-nan-preserve-float32 vk-bool-32)
  (:shader-signed-zero-inf-nan-preserve-float64 vk-bool-32)
  (:shader-denorm-preserve-float16 vk-bool-32)
  (:shader-denorm-preserve-float32 vk-bool-32)
  (:shader-denorm-preserve-float64 vk-bool-32)
  (:shader-denorm-flush-to-zero-float16 vk-bool-32)
  (:shader-denorm-flush-to-zero-float32 vk-bool-32)
  (:shader-denorm-flush-to-zero-float64 vk-bool-32)
  (:shader-rounding-mode-r-t-e-float16 vk-bool-32)
  (:shader-rounding-mode-r-t-e-float32 vk-bool-32)
  (:shader-rounding-mode-r-t-e-float64 vk-bool-32)
  (:shader-rounding-mode-r-t-z-float16 vk-bool-32)
  (:shader-rounding-mode-r-t-z-float32 vk-bool-32)
  (:shader-rounding-mode-r-t-z-float64 vk-bool-32))

(defun make-physical-device-discard-rectangle-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-discard-rectangles :uint32))

(defun make-physical-device-sample-locations-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sample-location-sample-counts vk-sample-count-flags)
  (:max-sample-location-grid-size (:struct vk-extent-2d))
  (:sample-location-coordinate-range :float :count 2)
  (:sample-location-sub-pixel-bits :uint32)
  (:variable-sample-locations vk-bool-32))

(defun make-physical-device-external-memory-host-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:min-imported-host-pointer-alignment vk-device-size))

(defun make-physical-device-multiview-per-view-attributes-properties-nvx
  (:type VkStructureType)
  (:next (:pointer :void))
  (:per-view-position-all-components vk-bool-32))

(defun make-physical-device-point-clipping-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:point-clipping-behavior VkPointClippingBehavior))

(defun make-physical-device-subgroup-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subgroup-size :uint32)
  (:supported-stages vk-shader-stage-flags)
  (:supported-operations vk-subgroup-feature-flags)
  (:quad-operations-in-all-stages vk-bool-32))

(defun make-physical-device-subgroup-size-control-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:min-subgroup-size :uint32)
  (:max-subgroup-size :uint32)
  (:max-compute-workgroup-subgroups :uint32)
  (:required-subgroup-size-stages vk-shader-stage-flags))

(defun make-physical-device-blend-operation-advanced-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:advanced-blend-max-color-attachments :uint32)
  (:advanced-blend-independent-blend vk-bool-32)
  (:advanced-blend-non-premultiplied-src-color vk-bool-32)
  (:advanced-blend-non-premultiplied-dst-color vk-bool-32)
  (:advanced-blend-correlated-overlap vk-bool-32)
  (:advanced-blend-all-operations vk-bool-32))

(defun make-physical-device-vertex-attribute-divisor-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-vertex-attrib-divisor :uint32))

(defun make-physical-device-sampler-filter-minmax-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:filter-minmax-single-component-formats vk-bool-32)
  (:filter-minmax-image-component-mapping vk-bool-32))

(defun make-physical-device-protected-memory-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:protected-no-fault vk-bool-32))

(defun make-physical-device-maintenance3-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-per-set-descriptors :uint32)
  (:max-memory-allocation-size vk-device-size))

(defun make-physical-device-mesh-shader-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-draw-mesh-tasks-count :uint32)
  (:max-task-work-group-invocations :uint32)
  (:max-task-work-group-size :uint32 :count 3)
  (:max-task-total-memory-size :uint32)
  (:max-task-output-count :uint32)
  (:max-mesh-work-group-invocations :uint32)
  (:max-mesh-work-group-size :uint32 :count 3)
  (:max-mesh-total-memory-size :uint32)
  (:max-mesh-output-vertices :uint32)
  (:max-mesh-output-primitives :uint32)
  (:max-mesh-multiview-view-count :uint32)
  (:mesh-output-per-vertex-granularity :uint32)
  (:mesh-output-per-primitive-granularity :uint32))

(defun make-physical-device-descriptor-indexing-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-update-after-bind-descriptors-in-all-pools :uint32)
  (:shader-uniform-buffer-array-non-uniform-indexing-native vk-bool-32)
  (:shader-sampled-image-array-non-uniform-indexing-native vk-bool-32)
  (:shader-storage-buffer-array-non-uniform-indexing-native vk-bool-32)
  (:shader-storage-image-array-non-uniform-indexing-native vk-bool-32)
  (:shader-input-attachment-array-non-uniform-indexing-native vk-bool-32)
  (:robust-buffer-access-update-after-bind vk-bool-32)
  (:quad-divergent-implicit-lod vk-bool-32)
  (:max-per-stage-descriptor-update-after-bind-samplers :uint32)
  (:max-per-stage-descriptor-update-after-bind-uniform-buffers :uint32)
  (:max-per-stage-descriptor-update-after-bind-storage-buffers :uint32)
  (:max-per-stage-descriptor-update-after-bind-sampled-images :uint32)
  (:max-per-stage-descriptor-update-after-bind-storage-images :uint32)
  (:max-per-stage-descriptor-update-after-bind-input-attachments :uint32)
  (:max-per-stage-update-after-bind-resources :uint32)
  (:max-descriptor-set-update-after-bind-samplers :uint32)
  (:max-descriptor-set-update-after-bind-uniform-buffers :uint32)
  (:max-descriptor-set-update-after-bind-uniform-buffers-dynamic :uint32)
  (:max-descriptor-set-update-after-bind-storage-buffers :uint32)
  (:max-descriptor-set-update-after-bind-storage-buffers-dynamic :uint32)
  (:max-descriptor-set-update-after-bind-sampled-images :uint32)
  (:max-descriptor-set-update-after-bind-storage-images :uint32)
  (:max-descriptor-set-update-after-bind-input-attachments :uint32))

(defun make-physical-device-inline-uniform-block-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-size :uint32)
  (:max-per-stage-descriptor-inline-uniform-blocks :uint32)
  (:max-per-stage-descriptor-update-after-bind-inline-uniform-blocks :uint32)
  (:max-descriptor-set-inline-uniform-blocks :uint32)
  (:max-descriptor-set-update-after-bind-inline-uniformq-blocks :uint32))

(defun make-physical-device-conservative-rasterization-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:primitive-overestimation-size :float)
  (:max-extra-primitive-overestimation-size :float)
  (:extra-primitive-overestimation-size-granularity :float)
  (:primitive-underestimation vk-bool-32)
  (:conservative-point-and-line-rasterization vk-bool-32)
  (:degenerate-triangles-rasterized vk-bool-32)
  (:degenerate-lines-rasterized vk-bool-32)
  (:fully-covered-fragment-shader-input-variable vk-bool-32)
  (:conservative-rasterization-post-depth-coverage vk-bool-32))

(defun make-physical-device-fragment-density-map-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:min-fragment-density-texel-size (:struct vk-extent-2d))
  (:max-fragment-density-texel-size (:struct vk-extent-2d))
  (:fragment-density-invocations vk-bool-32))

(defun make-physical-device-fragment-density-map2-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subsampled-loads vk-bool-32)
  (:subsampled-coarse-reconstruction-early-access vk-bool-32)
  (:max-subsampled-array-layers :uint32)
  (:max-descriptor-set-subsampled-samplers :uint32))

(defun make-physical-device-shader-core-properties-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-engine-count :uint32)
  (:shader-arrays-per-engine-count :uint32)
  (:compute-units-per-shader-array :uint32)
  (:simd-per-compute-unit :uint32)
  (:wavefronts-per-simd :uint32)
  (:wavefront-size :uint32)
  (:sgprs-per-simd :uint32)
  (:min-sgpr-allocation :uint32)
  (:max-sgpr-allocation :uint32)
  (:sgpr-allocation-granularity :uint32)
  (:vgprs-per-simd :uint32)
  (:min-vgpr-allocation :uint32)
  (:max-vgpr-allocation :uint32)
  (:vgpr-allocation-granularity :uint32))

(defun make-physical-device-shader-core-properties2-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-core-features vk-shader-core-properties-flags-amd)
  (:active-compute-unit-count :uint32))

(defun make-physical-device-depth-stencil-resolve-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported-depth-resolve-modes vk-reslove-mode-flags)
  (:supported-stencil-resolve-modes vk-reslove-mode-flags)
  (:independent-resolve-none vk-bool-32)
  (:independent-resolve vk-bool-32))

(defun make-physical-device-performance-query-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:allow-command-buffer-query-copies vk-bool-32))

(defun make-physical-device-shading-rate-image-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shading-rate-texel-size (:struct vk-extent-2d))
  (:shading-rate-palette-size :uint32)
  (:shading-rate-max-coarse-samples :uint32))

(defun make-physical-device-transform-feedback-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-transform-feedback-streams :uint32)
  (:max-transform-feedback-buffers :uint32)
  (:max-transform-feedback-buffer-size vk-device-size)
  (:max-transform-feedback-stream-data-size :uint32)
  (:max-transform-feedback-buffer-data-size :uint32)
  (:max-transform-feedback-buffer-data-stride :uint32)
  (:transform-feedback-queries vk-bool-32)
  (:transform-feedback-streams-lines-triangles vk-bool-32)
  (:transform-feedback-rasterization-stream-select vk-bool-32)
  (:transform-feedback-draw vk-bool-32))

(defun make-physical-device-ray-tracing-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-group-handle-size :uint32)
  (:max-recursion-depth :uint32)
  (:max-shader-group-stride :uint32)
  (:shader-group-base-alignment :uint32)
  (:max-geometry-count :uint64)
  (:max-instance-count :uint64)
  (:max-triangle-count :uint64)
  (:max-descriptor-set-acceleration-structures :uint32))

(defun make-physical-device-ray-tracing-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-group-handle-size :uint32)
  (:max-recursion-depth :uint32)
  (:max-shader-group-stride :uint32)
  (:shader-group-base-alignment :uint32)
  (:max-geometry-count :uint64)
  (:max-instance-count :uint64)
  (:max-primitive-count :uint64)
  (:max-descriptor-set-acceleration-structures :uint32)
  (:shader-group-handle-capture-replay-size :uint32))

(defun make-physical-device-cooperative-matrix-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:cooperative-matrix-supported-stages vk-shader-stage-flags))

(defun make-physical-device-shader-sm-builtins-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-sm-count :uint32)
  (:shader-warps-persm :uint32))

(defun make-physical-device-texel-buffer-alignment-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:storage-texel-buffer-offset-alignment-bytes vk-device-size)
  (:storage-texel-buffer-offset-single-texel-alignment vk-bool-32)
  (:uniform-texel-buffer-offset-alignment-bytes vk-device-size)
  (:uniform-texel-buffer-offset-single-texel-alignment vk-bool-32))

(defun make-physical-device-timeline-semaphore-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-timeline-semaphore-value-difference :uint64))

(defun make-physical-device-line-rasterization-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:line-sub-pixel-precision-bits :uint32))

(defun make-physical-device-robustness2-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:robust-storage-buffer-access-size-alignment vk-device-size)
  (:robust-uniform-buffer-access-size-alignment vk-device-size))

(defun make-physical-device-device-generated-commands-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-graphics-shader-group-count :uint32)
  (:max-indirect-sequence-count :uint32)
  (:max-indirect-commands-token-count :uint32)
  (:max-indirect-commands-stream-count :uint32)
  (:max-indirect-commands-token-offset :uint32)
  (:max-indirect-commands-stream-stride :uint32)
  (:min-sequences-count-buffer-offset-alignment :uint32)
  (:min-sequences-index-buffer-offset-alignment :uint32)
  (:min-indirect-commands-buffer-offset-alignment :uint32))

(defun make-multisample-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-sample-location-grid-size (:struct vk-extent-2d)))

(defun make-physical-device-custom-border-color-properties-ext 
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-custom-border-color-samplers :uint32))

(defun make-format-properties
  (:linear-tiling-features vk-format-feature-flags)
  (:optimal-tiling-features vk-format-feature-flags)
  (:buffer-features vk-format-feature-flags))

(defun make-format-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format-properties (:struct vk-format-properties)))

(defun make-drm-format-modifier-properties-ext
  (:drm-format-modifier :uint64)
  (:drm-format-modifier-plane-count :uint32)
  (:drm-format-modifier-tiling-features vk-format-feature-flags))

(defun make-drm-format-modifier-properties-list-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier-count :uint32)
  (:drm-format-modifier-properties (:pointer (:struct vk-drm-format-modifier-properties-ext))))

(defun make-image-format-properties
  (:max-extent (:struct vk-extent-3d))
  (:max-mip-levels :uint32)
  (:max-array-layers :uint32)
  (:sample-count vk-sample-count-flags)
  (:max-resource-size vk-device-size))

(defun make-external-image-format-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-format-properties (:struct vk-image-format-properties))
  (:external-memory-features vk-external-memory-feature-flags-nv)
  (:export-from-imported-handle-types vk-external-memory-handle-type-flags)
  (:compatible-handle-types vk-external-memory-handle-type-flags))

(defun make-physical-device-image-format-info2 
  (:type VkStructureType)
  (:next (:pointer :void))
  (:foramt VkFormat)
  (:type VkImageType)
  (:tiling VkImageTiling)
  (:usage vk-image-usage-flags)
  (:flags vk-image-create-flags))

(defun make-image-format-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-format-properties (:struct vk-image-format-properties)))

(defun make-texture-lod-gather-format-properties-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supports-texture-gather-lod-bias-amd vk-bool-32))

(defun make-physical-device-external-image-format-info 
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defun make-external-memory-properties
  (:external-memory-features vk-external-memory-feature-flags)
  (:export-from-imported-handle-types vk-external-memory-handle-type-flags)
  (:compatible-handle-types vk-external-memory-handle-type-flags))

(defun make-external-image-format-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:external-memory-properties (:struct vk-external-memory-properties)))

(defun make-physical-device-image-drm-format-modifier-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier :uint64)
  (:sharing-mode VkSharingMode)
  (:queue-family-index-count :uint32)
  (:queue-family-indices (:pointer :uint32)))

(defun make-sampler-ycbcr-conversion-image-format-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:combined-image-sampler-descriptor-count :uint32))

(defun make-android-hardware-buffer-usage-android
  (:type VkStructureType)
  (:next (:pointer :void))
  (:android-hardware-buffer-usage :uint64))

(defun make-physical-device-image-view-image-format-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-view-type VkImageViewType))

(defun make-filter-cubic-image-view-image-format-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:filter-cubic vk-bool-32)
  (:filter-cubic-minmax vk-bool-32))

(defun make-physical-device-external-buffer-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-buffer-create-flags)
  (:usage vk-buffer-usage-flags)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defun make-external-buffer-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:external-memory-properties (:struct vk-external-memory-properties)))

(defun make-physical-device-external-semaphore-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits))

(defun make-external-semaphore-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:export-from-imported-handle-types vk-external-semaphore-handle-type-flags)
  (:compatible-handle-types vk-external-semaphore-handle-type-flags)
  (:external-semaphore-features vk-external-semaphore-feature-flags))

(defun make-physical-device-external-fence-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalFenceHandleTypeFlagBits))

(defun make-external-fence-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:export-from-imported-handle-types vk-external-fence-handle-type-flags)
  (:compatible-handle-types vk-external-fence-handle-type-flags)
  (:external-fence-features vk-external-fence-feature-flags))

(defun make-debug-utils-object-name-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkObjectType)
  (:object-handle :uint64)
  (:object-name (:pointer :char)))

(defun make-debug-utils-object-tag-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkObjectType)
  (:object-handle :uint64)
  (:tag-name :uint64)
  (:tag-size size-t)
  (:tag (:pointer :void)))

(defun make-debug-utils-label-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:label-name (:pointer :char))
  (:color :float :count 4))

(defun make-debug-utils-messenger-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-debug-utils-messenger-create-flags-ext)
  (:message-severity vk-debug-utils-message-severity-flags-ext)
  (:message-type vk-debug-utils-message-type-flags-ext)
  (:pfn-user-callback pfn-vk-debug-utils-messenger-callback-ext)
  (:user-data (:pointer :void)))

(defun make-debug-utils-messenger-callback-data-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-debug-utils-messenger-callback-data-flags-ext)
  (:message-id-name (:pointer :char))
  (:message-id-number :int32)
  (:message (:pointer :char))
  (:queue-label-count :uint32)
  (:queue-labels (:pointer (:struct vk-debug-utils-label-ext)))
  (:cmd-buf-label-count :uint32)
  (:cmd-buf-labels (:pointer (:struct vk-debug-utils-label-ext)))
  (:object-count :uint32)
  (:objects (:pointer (:struct vk-debug-utils-object-name-info-ext))))

(defun make-debug-marker-object-name-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkDebugReportObjectTypeEXT)
  (:object :uint64)
  (:object-name (:pointer :char)))

(defun make-debug-marker-object-tag-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkDebugReportObjectTypeEXT)
  (:object :uint64)
  (:tag-name :uint64)
  (:tag-size size-t)
  (:tag (:pointer :void)))

(defun make-debug-marker-marker-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:mark-name (:pointer :char))
  (:color :float :count 4))

(defun make-debug-report-callback-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-debug-report-flags-ext)
  (:pfn-callback pfn-vk-debug-report-callback-ext)
  (:user-data (:pointer :void)))

(defun make-checkpoint-data-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stage VkPipelineStageFlagBits)
  (:checkpoint-marker (:pointer :void)))

(defun make-physical-device-tool-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:name :char :count 256)
  (:version :char :count 256)
  (:purpose vk-tool-purpose-flags-ext)
  (:description :char :count 256)
  (:layers :char :count 256))
|#
