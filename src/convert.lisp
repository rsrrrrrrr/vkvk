(in-package :vkvk)

;;struct type
(def-struct-translator vk-allocation-callback
    (s-allocation-callback allocation-callback)
  (:user-data (:pointer :void))
  (:fn-allocation vk-allocation-function)
  (:fn-reallocation vk-reallocation-function)
  (:fn-free vk-free-function)
  (:fn-internal-allocation vk-internal-allocation-notification)
  (:fn-internal-free vk-internal-free-notification))

(defctype vk-p-allocator (:pointer (:struct vk-allocation-callback)))

(def-struct-translator vk-debug-report-callback-create-info-ext
    (s-debug-report-callback-create-info debug-report-callback-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:pfn-callback pfn-vk-debug-report-callback-ext)
  (:user-data (:pointer :void)))

(def-struct-translator vk-offset-2d
    (s-offset-2d offset-2d)
  (:x :uint32)
  (:y :uint32))

(def-struct-translator vk-offset-3d
    (s-offset-3d offset-3d)
  (:x :uint32)
  (:y :uint32)
  (:z :uint32))

(def-struct-translator vk-extent-2d
    (s-extent-2d extent-2d)
  (:width :uint32)
  (:height :uint32))

(def-struct-translator vk-extent-3d
    (s-extent-3d extent-3d)
  (:width :uint32)
  (:height :uint32)
  (:depth :uint32))

(def-struct-translator vk-rect-2d
    (s-rect-2d rect-2d)
  (:offset (:struct vk-offset-2d) :parse 'offset-2d)
  (:extent (:struct vk-extent-2d) :parse 'extent-2d))

(def-struct-translator vk-component-mapping
    (s-component-mapping component-mapping)
  (:r VkComponentSwizzle)
  (:g VkComponentSwizzle)
  (:b VkComponentSwizzle)
  (:a VkComponentSwizzle))

(def-struct-translator vk-viewport
    (s-viewport viewport)
  (:x :float)
  (:y :float)
  (:width :float)
  (:height :float)
  (:min-depth :float)
  (:max-depth :float))

(def-struct-translator vk-extension-properties
    (s-extension-properties extension-properties)
  (:extension-name :char :count 255)
  (:spec-version :uint32))

(def-struct-translator vk-layer-properties
    (s-layer-properties layer-properties)
  (:layer-name :char :count 255)
  (:spec-version :uint32)
  (:implementation-version :uint32)
  (:description :char :count 255))

(def-struct-translator vk-application-info
    (s-application-info application-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:application-name (:pointer :char))
  (:application-version :uint32)
  (:engine-name (:pointer :char))
  (:engine-version :uint32)
  (:api-version :uint32))

(def-struct-translator vk-instance-create-info
    (s-instance-create-info instance-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:application-info (:pointer (:struct vk-application-info)))
  (:enable-layer-count :uint32)
  (:enable-layer-names (:pointer (:pointer :char)))
  (:enable-extension-count :uint32)
  (:enable-extension-names (:pointer (:pointer :char))))

(def-struct-translator vk-device-queue-create-info
    (s-device-queue-create-info device-queue-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:queue-family-index :uint32)
  (:queue-count :uint32)
  (:queue-properties (:pointer :float)))

(def-struct-translator vk-device-create-info
    (s-device-create-info device-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:queue-create-info-count :uint32)
  (:queue-create-infos (:pointer (:struct vk-device-queue-create-info)))
  (:layer-count :uint32)
  (:layers (:pointer (:pointer :char)))
  (:extension-count :uint32)
  (:extensions (:pointer (:pointer :char)))
  (:enable-features (:pointer (:struct vk-physical-device-features))))

;;get struct
(def-struct-translator vk-physical-device-limits
    (s-physical-device-limits physical-device-limits)
  (:max-image-dimension1-d :uint32)
  (:max-image-dimension2-d :uint32)
  (:max-image-dimension3-d :uint32)
  (:max-image-dimension-cube :uint32)
  (:max-image-array-layers :uint32)
  (:max-texel-buffer-elements :uint32)
  (:max-uniform-buffer-range :uint32)
  (:max-storage-buffer-range :uint32)
  (:max-push-constants-size :uint32)
  (:max-memory-allocation-count :uint32)
  (:max-sampler-allocation-count :uint32)
  (:buffer-image-granularity vk-device-size)
  (:sparse-address-space-size vk-device-size)
  (:max-bound-descriptor-sets :uint32)
  (:max-per-stage-descriptor-samplers :uint32)
  (:max-per-stage-descriptor-uniform-buffers :uint32)
  (:max-per-stage-descriptor-storage-buffers :uint32)
  (:max-per-stage-descriptor-sampled-images :uint32)
  (:max-per-stage-descriptor-storage-images :uint32)
  (:max-per-stage-descriptor-input-attachments :uint32)
  (:max-per-stage-resources :uint32)
  (:max-descriptor-set-samplers :uint32)
  (:max-descriptor-set-uniform-buffers :uint32)
  (:max-descriptor-set-uniform-buffers-dynamic :uint32)
  (:max-descriptor-set-storage-buffers :uint32)
  (:max-descriptor-set-storage-buffers-dynamic :uint32)
  (:max-descriptor-set-sampled-images :uint32)
  (:max-descriptor-set-storage-images :uint32)
  (:max-descriptor-set-input-attachments :uint32)
  (:max-vertex-input-attributes :uint32)
  (:max-vertex-input-bindings :uint32)
  (:max-vertex-input-attribute-offset :uint32)
  (:max-vertex-input-binding-stride :uint32)
  (:max-vertex-output-components :uint32)
  (:max-tessellation-generation-level :uint32)
  (:max-tessellation-patch-size :uint32)
  (:max-tessellation-control-per-vertex-input-components :uint32)
  (:max-tessellation-control-per-vertex-output-components :uint32)
  (:max-tessellation-control-per-patch-output-components :uint32)
  (:max-tessellation-control-total-output-components :uint32)
  (:max-tessellation-evaluation-input-components :uint32)
  (:max-tessellation-evaluation-output-components :uint32)
  (:max-geometry-shader-invocations :uint32)
  (:max-geometry-input-components :uint32)
  (:max-geometry-output-components :uint32)
  (:max-geometry-output-vertices :uint32)
  (:max-geometry-total-output-components :uint32)
  (:max-fragment-input-components :uint32)
  (:max-fragment-output-attachments :uint32)
  (:max-fragment-dual-src-attachments :uint32)
  (:max-fragment-combined-output-resources :uint32)
  (:max-compute-shared-memory-size :uint32)
  (:max-compute-work-group-count (:pointer :uint32))
  (:max-compute-work-group-invocations :uint32)
  (:max-compute-work-group-size (:pointer :uint32))
  (:sub-pixel-precision-bits :uint32)
  (:sub-texel-precision-bits :uint32)
  (:mipmap-precision-bits :uint32)
  (:max-draw-indexed-index-value :uint32)
  (:max-draw-indirect-count :uint32)
  (:max-sampler-lod-bias :float)
  (:max-sampler-anisotropy :float)
  (:max-viewports :uint32)
  (:max-viewport-dimensions (:pointer :uint32))
  (:viewport-bounds-range (:pointer :float))
  (:viewport-sub-pixel-bits :uint32)
  (:min-memory-map-alignment :unsigned-int)
  (:min-texel-buffer-offset-alignment vk-device-size)
  (:min-uniform-buffer-offset-alignment vk-device-size)
  (:min-storage-buffer-offset-alignment vk-device-size)
  (:min-texel-offset :int32)
  (:max-texel-offset :uint32)
  (:min-texel-gather-offset :int32)
  (:max-texel-gather-offset :uint32)
  (:min-interpolation-offset :float)
  (:max-interpolation-offset :float)
  (:sub-pixel-interpolation-offset-bits :uint32)
  (:max-framebuffer-width :uint32)
  (:max-framebuffer-height :uint32)
  (:max-framebuffer-layers :uint32)
  (:framebuffer-color-sample-counts vk-flags)
  (:framebuffer-depth-sample-counts vk-flags)
  (:framebuffer-stencil-sample-counts vk-flags)
  (:framebuffer-no-attachments-sample-counts vk-flags)
  (:max-color-attachments :uint32)
  (:sampled-image-color-sample-counts vk-flags)
  (:sampled-image-integer-sample-counts vk-flags)
  (:sampled-image-depth-sample-counts vk-flags)
  (:sampled-image-stencil-sample-counts vk-flags)
  (:storage-image-sample-counts vk-flags)
  (:max-sample-mask-words :uint32)
  (:timestamp-compute-and-graphics vk-bool-32)
  (:timestamp-period :float)
  (:max-clip-distances :uint32)
  (:max-cull-distances :uint32)
  (:max-combined-clip-and-cull-distances :uint32)
  (:discrete-queue-priorities :uint32)
  (:point-size-range (:pointer :float))
  (:line-width-range (:pointer :float))
  (:point-size-granularity :float)
  (:line-width-granularity :float)
  (:strict-lines vk-bool-32)
  (:standard-sample-locations vk-bool-32)
  (:optimal-buffer-copy-offset-alignment vk-device-size)
  (:optimal-buffer-copy-row-pitch-alignment vk-device-size)
  (:non-coherent-atom-size vk-device-size))

(def-struct-translator vk-physical-device-sparse-properties
    (s-physical-device-sparse-properties physical-device-sparse-properties)
  (:residency-standard2-d-block-shape vk-bool-32)
  (:residency-standard2-d-multisample-block-shape vk-bool-32)
  (:residency-standard3-d-block-shape vk-bool-32)
  (:residency-aligned-mip-size vk-bool-32)
  (:residency-non-resident-strict vk-bool-32))

(def-struct-translator vk-physical-device-properties
    (s-physical-device-properties physical-device-properties)
  (:api-version :uint32)
  (:driver-version :uint32)
  (:vendor-id :uint32)
  (:device-id :uint32)
  (:device-type VkPhysicalDeviceType)
  (:device-name :char :count 256)
  (:pipeline-cache-uuid :uint8 :count 16)
  (:limits (:struct vk-physical-device-limits))
  (:spare-properties (:struct vk-physical-device-sparse-properties)))

(def-struct-translator vk-queue-family-properties
    (s-queue-family-properties queue-family-properties)
  (:queue-flags vk-flags)
  (:queue-count :uint32)
  (:timestamp-valid-bits  :uint32)
  (:min-image-transfer-granularity (:struct vk-extent-3d)))

(def-struct-translator vk-memory-type
    (s-memory-type memory-type)
  (:property-flags vk-flags)
  (:hape-index :uint32))

(def-struct-translator vk-memory-heap
    (s-memory-heap memory-heap)
  (:size vk-device-size)
  (:flags vk-flags))

(def-struct-translator vk-physical-device-memory-properties
    (s-physical-device-memory-properties physical-device-memory-properties)
  (:memory-type-count :uint32)
  (:memory-types (:struct vk-memory-type) :count 32 :bind :memory-type-count)
  (:memory-heap-count :uint32)
  (:memory-heaps (:struct vk-memory-heap) :count 16 :bind :memory-heap-count))

(def-struct-translator vk-physical-device-features
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

(def-struct-translator vk-format-properties
    (s-format-properties format-properties)
  (:linear-tiling-features vk-flags)
  (:optimal-tiling-features vk-flags)
  (:buffer-features vk-flags))

(def-struct-translator vk-image-format-properties
    (s-image-format-properties image-format-properties)
  (:max-extent (:struct vk-extent-3d))
  (:max-mip-levels :uint32)
  (:max-array-layers :uint32)
  (:sample-count vk-flags)
  (:max-resource-size vk-device-size))

(def-struct-translator vk-andorid-surface-create-info
    (s-andorid-surface-create-info andorid-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:windows (:pointer android-window)))

(def-struct-translator vk-wayland-surface-create-info
    (s-wayland-surface-create-info wayland-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:display (:pointer (:struct wl-display)))
  (:surface (:pointer (:struct wl-surface))))

(def-struct-translator vk-win32-surface-create-info
    (s-win32-surface-create-info win32-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:hinstance hinstance)
  (:hwnd hwnd))

(def-struct-translator vk-xcb-surface-create-info
    (s-xcb-surface-create-info xcb-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:connection (:pointer xcb-connection))
  (:window xcb-window))

(def-struct-translator vk-xlib-surface-create-info
    (s-xlib-surface-create-info xlib-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:dpy (:pointer xlib-display))
  (:window xlib-window))

(def-struct-translator vk-direct-fb-surface-create-info
    (s-direct-fb-surface-create-info direct-fb-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:dfb (:pointer idirect-fb))
  (:surface (:pointer idirect-fb-surface)))

(def-struct-translator vk-image-pipe-surface-fuchsia-create-info
    (s-image-pipe-surface-fuchsia-create-info image-pipe-surface-fuchsia-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:image-pipe-handle zx-handle))

(def-struct-translator vk-stream-descriptor-surface-create-info
    (s-stream-descriptor-surface-create-info stream-descriptor-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:stream-descriptor gpp-stream-descriptor))

(def-struct-translator vk-ios-surface-create-info
    (s-ios-surface-create-info ios-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:view (:pointer :void)))

(def-struct-translator vk-mac-os-surface-create-info
    (s-mac-os-surface-create-info mac-os-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:view (:pointer :void)))

(def-struct-translator vk-vi-surface-create-info
    (s-vi-surface-create-info vi-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:window (:pointer :void)))

(def-struct-translator vk-metal-surfaec-create-info
    (s-metal-surfaec-create-info metal-surfaec-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:layer (:pointer ca-metal-layer)))

(def-struct-translator vk-display-plane-surface-create-info
    (s-display-plane-surface-create-info display-plane-surface-create-info)
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:display-mode vk-display-mode-khr)
  (:plane-index :uint32)
  (:plane-stack-index :uint32)
  (:transform VkSurfaceTransformFlagBitsKHR)
  (:global-alpha :float)
  (:alpha-mode VkDisplayPlaneAlphaFlagBitsKHR)
  (:image-extent (:struct vk-extent-2d) :parse 'extent-2d))

(def-struct-translator vk-swapchain-create-info-khr
    (s-swapchain-create-info-khr swapchain-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:surface vk-surface-khr)
  (:min-image-count :uint32)
  (:image-format VkFormat)
  (:image-color-space VkColorSpaceKHR)
  (:image-extent (:struct vk-extent-2d) :parse extent-2d)
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

(def-struct-translator vk-surface-capabilities-khr
    (s-surface-capabilities surface-capabilities)
  (:min-image-count :uint32)
  (:max-image-count :uint32)
  (:current-extent (:struct vk-extent-2d) :parse extent-2d)
  (:min-image-extent (:struct vk-extent-2d) :parse extent-2d)
  (:max-image-extent (:struct vk-extent-2d) :parse extent-2d)
  (:max-image-array-layers :uint32)
  (:supported-transforms :uint32)
  (:current-transform :uint32)
  (:supported-composite-alpha :uint32)
  (:supported-usage-flags :uint32))

(def-struct-translator vk-surface-format-khr
    (s-surface-format surface-formt)
  (:format VkFormat)
  (:color-space VkColorSpaceKHR))

(def-struct-translator vk-image-subresource-range
    (s-image-subresource-range image-subresource-range)
  (:aspect-mask VkImageAspectFlagBits)
  (:base-mip-level :uint32)
  (:level-count :uint32)
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(def-struct-translator vk-image-view-create-info
    (s-image-view-create-info image-view-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:image vk-image)
  (:view-type VkImageViewtype)
  (:format VkFormat)
  (:components (:struct vk-component-mapping) :parse component-mapping)
  (:subresource-range (:struct vk-image-subresource-range) :parse image-subresource-range))

(def-struct-translator vk-shader-module-create-info
    (s-shader-module-create-info shader-module-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:code-size size-t)
  (:code (:pointer :uint32)))

(def-struct-translator vk-push-constant-range
    (s-push-constant-range push-constant-range)
  (:stage-flags vk-flags)
  (:offset :uint32)
  (:size :uint32))

;;pipeline
(def-struct-translator vk-pipeline-layout-create-info
    (s-pipeline-layout-create-info pipeline-layout-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout) :bind :set-layout-count)
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range)) :bind :push-constant-range-count))

(def-struct-translator vk-specialization-map-entry
    (s-specialization-map-entry specialization-map-entry)
  (:constant-id :uint32)
  (:offset :uint32)
  (:size size-t))

(def-struct-translator vk-specialization-info
    (s-specialization-info specialization-info)
  (:map-entry-count :uint32)
  (:map-entrys (:pointer (:struct vk-specialization-map-entry)))
  (:data-size size-t)
  (:data (:pointer :void)))

(def-struct-translator vk-pipeline-shader-stage-create-info
    (s-pipeline-shader-stage-create-info pipeline-shader-stage-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:stage VkShaderStageflagbits)
  (:module vk-shader-module)
  (:name (:pointer :char))
  (:specialization-info (:pointer (:struct vk-specialization-info))))

(def-struct-translator vk-vertex-input-binding-description
    (s-vertex-input-binding-description vertex-input-binding-description)
  (:binding :uint32)
  (:stride :uint32)
  (:input-rate VkVertexInputRate))

(def-struct-translator vk-vertex-input-attribute-description
    (s-vertex-input-attribute-description vertex-input-attribute-description)
  (:location :uint32)
  (:binding :uint32)
  (:format VkFormat)
  (:offset :uint32))

(def-struct-translator vk-pipeline-vertex-input-state-create-info
    (s-pipeline-vertex-input-state-create-info pipeline-vertex-input-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:vertex-binding-description-count :uint32)
  (:vertex-binding-description (:pointer (:struct vk-vertex-input-binding-description)) :bind :vertex-binding-description-count)
  (:vertex-attribute-description-count :uint32)
  (:vertex-attribute-description (:pointer (:struct vk-vertex-input-attribute-description)) :bind :vertex-attribute-description-count))

(def-struct-translator vk-pipeline-input-assembly-state-create-info
    (s-pipeline-input-assembly-state-create-info pipeline-input-assembly-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-input-assembly-state-create-flags)
  (:topology VkPrimitiveTopology)
  (:primitive-restart-enable vk-bool-32))

(def-struct-translator vk-pipeline-tessellation-state-create-info
    (s-pipeline-tessellation-state-create-info pipeline-tessellation-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:patch-control-points :uint32))

(def-struct-translator vk-pipeline-viewport-state-create-info
    (s-pipeline-viewport-state-create-info pipeline-viewport-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-viewport-state-create-flags)
  (:viewport-count :uint32)
  (:viewports (:pointer (:struct vk-viewport)) :bind :viewport-count)
  (:scissor-count :uint32)
  (:scissprs (:pointer (:struct vk-rect-2d)) :bind :scissor-count))

(def-struct-translator vk-pipeline-rasterization-state-create-info
    (s-pipeline-rasterization-state-create-info pipeline-rasterization-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:depth-clamp-enable vk-bool-32)
  (:rasterizer-discard-enable vk-bool-32)
  (:polygon-mode VkPolygonMode)
  (:cull-mode vk-flags)
  (:front-face VkFrontface)
  (:depth-bias-enable vk-bool-32)
  (:depth-bias-constant-factor :float)
  (:depth-bias-clamp :float)
  (:depth-bias-slope-factor :float)
  (:line-width :float))

(def-struct-translator vk-pipeline-multisample-state-create-info
    (s-pipeline-multisample-state-create-info pipeline-multisample-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:rasterization-sample VkSampleCountFlagbits)
  (:sample-shading-enable vk-bool-32)
  (:min-sample-shading :float)
  (:sample-mask (:pointer vk-sample-mask))
  (:alpha-to-coverage-enable vk-bool-32)
  (:alpha-to-one-enable vk-bool-32))

(def-struct-translator vk-stencil-op-state
    (s-stencil-op-state stencil-op-state)
  (:fail-op VkStencilop)
  (:pass-op VkStencilop)
  (:depth-fail-op VkStencilop)
  (:compare-op VkCompareop)
  (:compare-mask :uint32)
  (:write-mask :uint32)
  (:references :uint32)) 

(def-struct-translator vk-pipeline-depth-stencil-state-create-info
    (s-pipeline-depth-stencil-state-create-info pipeline-depth-stencil-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:depth-test-enable vk-bool-32)
  (:depth-write-enable vk-bool-32)
  (:depth-compare-op VkCompareop)
  (:depth-bounds-test-enable vk-bool-32)
  (:stencil-test-enable vk-bool-32)
  (:front (:struct vk-stencil-op-state) :parse 'stencil-op-state)
  (:back (:struct vk-stencil-op-state) :parse 'stencil-op-state)
  (:min-depth-bounds :float)
  (:max-depth-bounds :float))

(def-struct-translator vk-pipeline-color-blend-attachment-state
    (s-pipeline-color-blend-attachment-state pipeline-color-blend-attachment-state)
  (:blend-enable vk-bool-32)
  (:src-color-blend-factor VkBlendFactor)
  (:dst-color-blend-factor VkBlendFactor)
  (:color-blend-op VkBlendop)
  (:src-alpha-blend-factor VkBlendFactor)
  (:dst-alpha-blend-factor VkBlendFactor)
  (:alpha-blend-op VkBlendop)
  (:color-write-mask vk-flags))

(def-struct-translator vk-pipeline-color-blend-state-create-info
    (s-pipeline-color-blend-state-create-info pipeline-color-blend-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:logic-op-enable vk-bool-32)
  (:logic-op VkLogicop)
  (:attachment-count :uint32)
  (:attachments (:pointer (:struct vk-pipeline-color-blend-attachment-state)) :bind :attachment-count)
  (:blend-constants :float :count 4))

(def-struct-translator vk-pipeline-dynamic-state-create-info
    (s-pipeline-dynamic-state-create-info pipeline-dynamic-state-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:dynamic-state-count :uint32)
  (:dynamic-states (:pointer VkDynamicState)))

(def-struct-translator vk-graphics-pipeline-create-info
    (s-graphics-pipeline-create-info graphics-pipeline-create-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:vertex-input-state (:pointer (:struct vk-pipeline-vertex-input-state-create-info)))
  (:input-assembly-state (:pointer (:struct vk-pipeline-input-assembly-state-create-info)))
  (:tessellation-state (:pointer (:struct vk-pipeline-tessellation-state-create-info)))
  (:viewport-state (:pointer (:struct vk-pipeline-viewport-state-create-info)))
  (:rasterization-state (:pointer (:struct vk-pipeline-rasterization-state-create-info)))
  (:multisample-state (:pointer (:struct vk-pipeline-multisample-state-create-info)))
  (:depth-stencil-state (:pointer (:struct vk-pipeline-depth-stencil-state-create-info)))
  (:color-blend-state (:pointer (:struct vk-pipeline-color-blend-state-create-info)))
  (:dynamic-state (:pointer (:struct vk-pipeline-dynamic-state-create-info)))
  (:layout vk-pipeline-layout)
  (:render-pass vk-render-pass)
  (:subpass :uint32)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))
