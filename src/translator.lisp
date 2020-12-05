(in-package :vkvk)

(defvkstruct vk-offset-2d
    (s-offset-2d offset-2d)
  (:x :uint32)
  (:y :uint32))

(defvkstruct vk-offset-3d
    (s-offset-3d offset-3d)
  (:x :uint32)
  (:y :uint32)
  (:z :uint32))

(defvkstruct vk-extent-2d
    (s-extent-2d extent-2d)
  (:width :uint32)
  (:height :uint32))

(defvkstruct vk-extent-3d
    (s-extent-3d extent-3d)
  (:width :uint32)
  (:height :uint32)
  (:depth :uint32))

(defvkstruct vk-rect-2d
    (s-rect-2d rect-2d)
  (:offset (:struct vk-offset-2d) :parser offset-2d)
  (:extent (:struct vk-extent-2d) :parser extent-2d))

(defvkstruct vk-viewport
    (s-viewport viewport)
  (:x :float)
  (:y :float)
  (:width :float)
  (:height :float)
  (:min-depth :float)
  (:max-depth :float))

(defvkstruct vk-buffer-copy
    (s-buffer-copy buffer-copy)
  (:src-offset vk-device-size)
  (:dst-offset vk-device-size)
  (:size vk-device-size))

(defvkstruct vk-image-subresource-layers
    (s-image-subresource-layers image-subresource-layers)
  (:aspect-mask vk-image-aspect-flags)
  (:mip-level :uint32)
  (:base-array-layer :uint32)
  (:layers-count :uint32))

(defvkstruct vk-image-copy
    (s-image-copy image-copy)
  (:src-subresource (:struct vk-image-subresource-layers) :parser image-subresource-layers)
  (:src-offset (:struct vk-offset-3d) :parser offset-3d)
  (:dst-subresource (:struct vk-image-subresource-layers) :parser image-subresource-layers)
  (:dst-offset (:struct vk-offset-3d) :parser offset-3d)
  (:extent (:struct vk-extent-3d) :parser offset-3d))

(defvkstruct vk-image-blit
    (s-image-blit image-blit)
  (:src-subresource (:struct vk-image-subresource-layers) :parser image-subresource-layers)
  (:src-offset (:struct vk-offset-3d) :count 2 :parser offset-3d)
  (:dst-subresource (:struct vk-image-subresource-layers) :parser image-subresource-layers)
  (:dst-offset (:struct vk-offset-3d) :count 2 :parser offset-3d))

(defvkstruct vk-buffer-image-copy
    (s-buffer-image-copy buffer-image-copy)
  (:buffer-offset vk-device-size)
  (:buffer-row-length :uint32)
  (:buffer-image-height :uint32)
  (:image-subresource (:struct vk-image-subresource-layers) :parser image-subresource-layers)
  (:image-offset (:struct vk-offset-3d) :parser offset-3d)
  (:image-extent (:struct vk-extent-3d) :parser extent-3d))

(defvkstruct vk-clear-depth-stencil-value
    (s-clear-depth-stencil-value clear-depth-stencil-value)
  (:depth :float)
  (:stencil :uint32))

(defvkunion vk-clear-color-value
    (u-clear-color-value clear-color-value)
  (:f32 (:pointer :float))
  (:i32 (:pointer :int32))
  (:ui32 (:pointer :uint32)))

(defvkstruct vk-clear-depth-stencil-value
    (s-clear-depth-stencil-value clear-depth-stencil-value)
  (:depth :float)
  (:stencil :uint32))

(defvkunion vk-clear-value
    (u-clear-value clear-value)
  (:color (:union vk-clear-color-value) :parser clear-color-value)
  (:depth-stencil (:struct vk-clear-depth-stencil-value) :parser clear-depth-stencil-value))

(defvkstruct vk-clear-attachment
    (s-clear-attachment clear-attachment)
  (:aspect-mask vk-image-aspect-flags)
  (:color-attachment :uint32)
  (:clear-values (:union vk-clear-value)))

(defvkstruct vk-clear-rect
    (s-clear-rect clear-rect)
  (:rect (:struct vk-rect-2d) :parser rect-2d)
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(defvkstruct vk-image-subresource-range
    (s-image-subresource-range image-subresource-range)
  (:aspect-mask VkImageAspectFlagBits)
  (:base-mip-level :uint32)
  (:level-count :uint32)
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(defvkstruct vk-conditional-rendering-begin-info-ext
    (s-conditional-rendering-begin-info-ext conditional-rendering-begin-info-ext)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:flags vk-conditional-rendering-flags-ext))

(defvkstruct vk-render-pass-begin-info
    (s-render-pass-begin-info render-pass-begin-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:render-pass vk-render-pass)
  (:framebuffer vk-framebuffer)
  (:render-area (:struct vk-rect-2d) :parser rect-2d)
  (:clear-value-count :uint32)
  (:clear-values (:pointer (:union vk-clear-value)) :parser clear-value :bind :clear-value-count))

(defvkstruct vk-image-resloved
    (s-image-resloved image-resloved)
  (:src-subresource (:struct vk-image-subresource-layers) :parser image-subresource-layers)
  (:src-offset (:struct vk-offset-3d) :parser offset-3d)
  (:dst-subresource (:struct vk-image-subresource-layers) :parser image-subresource-layers)
  (:dst-offset (:struct vk-offset-3d) :parser offset-3d)
  (:extent (:struct vk-extent-3d) :parser extent-3d))

(defvkstruct vk-memory-barrier
    (s-memory-barrier memory-barrier)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags))

(defvkstruct vk-buffer-memory-barrier
    (s-buffer-memory-barrier buffer-memory-barrier)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:src-queue-family-index :uint32)
  (:dst-queue-family-index :uint32)
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:size vk-device-size))

(defvkstruct vk-image-memory-barrier
    (s-image-memory-barrier image-memory-barrier)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:old-layout VkImageLayout)
  (:new-layout VkImageLayout)
  (:src-queue-family-index :uint32)
  (:dst-queue-family-index :uint32)
  (:image vk-image)
  (:sub-resource-range (:struct vk-image-subresource-range) :parser image-subresource-range))

(defvkstruct vk-indirect-commands-stream-nv
    (s-indirect-commands-stream-nv indirect-commands-stream-nv)
  (:buffer vk-buffer)
  (:offset vk-device-size))

(defvkstruct vk-generated-commands-info-nv
    (s-generated-commands-info-nv generated-commands-info-nv)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-bind-point VkPipelineBindPoint)
  (:pipeline vk-pipeline)
  (:indirect-commands-layout vk-indirect-commands-layout-nv)
  (:stream-count :uint32)
  (:streams (:pointer (:struct vk-indirect-commands-stream-nv)) :parser generated-commands-info-nv :bind :stream-count)
  (:sequence-count :uint32)
  (:preprocess-buffer vk-buffer)
  (:preprocess-offset vk-device-size)
  (:preprocess-size vk-device-size)
  (:sequences-count-buffer vk-buffer)
  (:sequences-count-offset vk-device-size)
  (:sequences-index-buffer vk-buffer)
  (:sequences-index-offset vk-device-size))

(defvkstruct vk-application-info
    (s-application-info application-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:app-name (:pointer :char))
  (:app-version :uint32)
  (:engine-name (:pointer :char))
  (:engine-version :uint32)
  (:api-version :uint32))

(defvkstruct vk-instance-create-info
    (s-instance-create-info instance-create-info )
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags (vk-instance-create-flags))
  (:info (:pointer (:struct vk-application-info)) :parser application-info)
  (:layer-count :uint32)
  (:layers (:pointer (:pointer :char)) :bind :layer-count)
  (:extension-count :uint32)
  (:extensions (:pointer (:pointer :char)) :bind :extension-count))

(defvkstruct vk-physical-device-features
    (s-physical-device-features physical-device-features)
  (:robust-buffer-access vk-bool-32)
  (:full-draw-index-uint32 vk-bool-32)
  (:image-cube-array vk-bool-32)
  (:independent-blend vk-bool-32)
  (:geometry-shader vk-bool-32)
  (:tessellation-shader vk-bool-32)
  (:sample-rate-shading vk-bool-32)
  (:dual-src-blend vk-bool-32)
  (:logic-op vk-bool-32)
  (:multi-draw-indirect vk-bool-32)
  (:draw-indirect-first-instance vk-bool-32)
  (:depth-clamp vk-bool-32)
  (:depth-bias-clamp vk-bool-32)
  (:fill-mode-non-solid vk-bool-32)
  (:depth-bounds vk-bool-32)
  (:wide-lines vk-bool-32)
  (:large-points vk-bool-32)
  (:alpha-to-one vk-bool-32)
  (:multi-viewport vk-bool-32)
  (:sampler-anisotropy vk-bool-32)
  (:texture-compression-e-t-c2 vk-bool-32)
  (:texture-compression-a-s-t-c_-l-d-r vk-bool-32)
  (:texture-compression-b-c vk-bool-32)
  (:occlusion-query-precise vk-bool-32)
  (:pipeline-statistics-query vk-bool-32)
  (:vertex-pipeline-stores-and-atomics vk-bool-32)
  (:fragment-stores-and-atomics vk-bool-32)
  (:shader-tessellation-and-geometry-point-size vk-bool-32)
  (:shader-image-gather-extended vk-bool-32)
  (:shader-storage-image-extended-formats vk-bool-32)
  (:shader-storage-image-multisample vk-bool-32)
  (:shader-storage-image-read-without-format vk-bool-32)
  (:shader-storage-image-write-without-format vk-bool-32)
  (:shader-uniform-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-sampled-image-array-dynamic-indexing vk-bool-32)
  (:shader-storage-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-storage-image-array-dynamic-indexing vk-bool-32)
  (:shader-clip-distance vk-bool-32)
  (:shader-cull-distance vk-bool-32)
  (:shader-float64 vk-bool-32)
  (:shader-int64 vk-bool-32)
  (:shader-int16 vk-bool-32)
  (:shader-resource-residency vk-bool-32)
  (:shader-resource-min-lod vk-bool-32)
  (:sparse-binding vk-bool-32)
  (:sparse-residency-buffer vk-bool-32)
  (:sparse-residency-image2-d vk-bool-32)
  (:sparse-residency-image3-d vk-bool-32)
  (:sparse-residency2-samples vk-bool-32)
  (:sparse-residency4-samples vk-bool-32)
  (:sparse-residency8-samples vk-bool-32)
  (:sparse-residency16-samples vk-bool-32)
  (:sparse-residency-aliased vk-bool-32)
  (:variable-multisample-rate vk-bool-32)
  (:inherited-queries vk-bool-32))

(defvkstruct vk-device-queue-create-info
    (s-device-queue-create-info device-queue-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-device-queue-create-flags)
  (:queue-family-index :uint32)
  (:queue-count :uint32)
  (:queue-properties (:pointer :float)))

(defvkstruct vk-device-create-info
    (s-device-create-info device-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-device-create-flags)
  (:queue-create-info-count :uint32)
  (:queue-create-infos (:pointer (:struct vk-device-queue-create-info)) :parser device-queue-create-info :bind :queue-create-info-count)
  (:layer-count :uint32)
  (:layers (:pointer (:pointer :char)) :bind :layer-count)
  (:extension-count :uint32)
  (:extensions (:pointer (:pointer :char)) :bind :extension-count)
  (:enable-features (:pointer (:struct vk-physical-device-features)) :parser physical-device-features))

(defvkstruct vk-fence-create-info
    (s-fence-create-info fence-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-fence-create-flags))

(defvkstruct vk-semaphore-create-info
    (s-semaphore-create-info semaphore-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-semaphore-create-flags))

(defvkstruct vk-event-create-info
    (s-event-create-info event-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-event-create-flags))

(defvkstruct vk-query-pool-create-info
    (s-query-pool-create-info query-pool-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-query-pool-create-flags)
  (:query-type VkQueryType)
  (:query-count :uint32)
  (:pipeline-statistics vk-query-pipeline-statistic-flags))

(defvkstruct vk-buffer-create-info
    (s-buffer-create-info buffer-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-buffer-create-flags)
  (:size vk-device-size)
  (:usage vk-buffer-usage-flags)
  (:sharing-mode VkSharingMode)
  (:queue-family-count :uint32)
  (:queue-family-indices (:pointer :uint32) :bind :queue-family-count))

(defvkstruct vk-buffer-view-create-info
    (s-buffer-view-create-info buffer-view-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-buffer-view-create-flags)
  (:buffer vk-buffer)
  (:format VkFormat)
  (:offset vk-device-size)
  (:range vk-device-size))

(defvkstruct vk-image-create-info
    (s-image-create-info image-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-image-create-flags)
  (:image-type VkImageType)
  (:format VkFormat)
  (:extent (:struct vk-extent-3d) :parser extent-3d)
  (:mip-levels :uint32)
  (:array-layers :uint32)
  (:samples VkSampleCountFlagBits)
  (:tiling VkImageTiling)
  (:usage vk-image-usage-flags)
  (:sharing-mode VkSharingMode)
  (:queue-family-index-count :uint32)
  (:queue-family-indices (:pointer :uint32) :bind :queue-family-index-count)
  (:initial-layout VkImageLayout))

(defvkstruct vk-component-mapping
    (s-component-mapping component-mapping)
  (:r VkComponentSwizzle)
  (:g VkComponentSwizzle)
  (:b VkComponentSwizzle)
  (:a VkComponentSwizzle))

(defvkstruct vk-image-view-create-info
    (s-image-view-create-info image-view-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-image-view-create-flags)
  (:image vk-image)
  (:view-type VkImageViewtype)
  (:format VkFormat)
  (:components (:struct vk-component-mapping) :parser component-mapping)
  (:subresource-range (:struct vk-image-subresource-range) :parser image-subresource-range))

(defvkstruct vk-shader-module-create-info
    (s-shader-module-create-info shader-module-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-module-create-flags)
  (:code-size size-t)
  (:code (:pointer :uint32)))
