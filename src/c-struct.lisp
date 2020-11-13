(in-package :vkvk)

;;basic type
(defctype vk-bool-32 :uint32)
(defctype vk-flags :uint32)


(defctype vk-handle :pointer)
#.(if (= 8 (foreign-type-size :pointer))
      `(defctype vk-non-dispatch-handle :pointer)
      `(defctype vk-non-dispatch-handle :uint64))

#.(if (= 8 (foreign-type-size :pointer))
      `(defctype size-t :uint64)
      `(defctype size-t :uint32))


(defctype vk-instance vk-handle)
(defctype vk-physical-device vk-handle)
(defctype vk-device vk-handle)
(defctype vk-queue vk-handle)
(defctype vk-command-buffer vk-handle)

(defctype vk-command-pool vk-non-dispatch-handle)
(defctype vk-fence vk-non-dispatch-handle)
(defctype vk-semaphore vk-non-dispatch-handle)
(defctype vk-event vk-non-dispatch-handle)
(defctype vk-render-pass vk-non-dispatch-handle)
(defctype vk-framebuffer vk-non-dispatch-handle)
(defctype vk-shader-module vk-non-dispatch-handle)
(defctype vk-validation-cache-ext vk-non-dispatch-handle)
(defctype vk-pipeline vk-non-dispatch-handle)
(defctype vk-pipeline-cache vk-non-dispatch-handle)
(defctype vk-device-memory vk-non-dispatch-handle)
(defctype vk-buffer vk-non-dispatch-handle)
(defctype vk-buffer-view vk-non-dispatch-handle)
(defctype vk-image vk-non-dispatch-handle)
(defctype vk-image-view vk-non-dispatch-handle)
(defctype vk-acceleration-structure-khr vk-non-dispatch-handle)
(defctype vk-sampler vk-non-dispatch-handle)
(defctype vk-sampler-ycbcr-conversion vk-non-dispatch-handle)
(defctype vk-descriptor-set-layout vk-non-dispatch-handle)
(defctype vk-pipeline-layout vk-non-dispatch-handle)
(defctype vk-descriptor-pool vk-non-dispatch-handle)
(defctype vk-descriptor-set vk-non-dispatch-handle)
(defctype vk-descriptor-update-template vk-non-dispatch-handle)
(defctype vk-query-pool vk-non-dispatch-handle)
(defctype vk-performance-configuration-intel vk-non-dispatch-handle)
(defctype vk-indirect-commands-layout-nv vk-non-dispatch-handle)
(defctype vk-surface-khr vk-non-dispatch-handle)
(defctype vk-display-khr vk-non-dispatch-handle)
(defctype vk-display-mode-khr vk-non-dispatch-handle)
(defctype vk-swapchain-khr vk-non-dispatch-handle)
(defctype vk-deferred-operation-khr vk-non-dispatch-handle)
(defctype vk-private-date-slot-ext vk-non-dispatch-handle)
(defctype vk-debug-utils-messenger-ext vk-non-dispatch-handle)
(defctype vk-debug-report-callback-ext vk-non-dispatch-handle)

(defctype vk-device-size :uint64)
(defctype vk-device-address :uint64)
(defctype vk-sample-mask :uint32)

(defctype vk-void-function :pointer)
(defctype vk-allocation-function :pointer)
(defctype vk-reallocation-function :pointer)
(defctype vk-free-function :pointer)
(defctype vk-internal-allocation-notification :pointer)
(defctype vk-internal-free-notification :pointer)
(defctype pfn-vk-debug-utils-messenger-callback-ext :pointer)
(defctype pfn-vk-debug-report-callback-ext :pointer)

(defctype android-window :void)
(defcstruct wl-display) ;;unknow ~.~
(defcstruct wl-surface) ;;unknow ~.~
(defctype hinstance (:pointer :void))
(defctype hwnd (:pointer :void))
(defctype xcb-connection :void)
(defctype xcb-window :uint32)
(defctype xlib-display :void)
(defctype xlib-window :ulong)
(defctype idirect-fb :void) ;;unknow
(defctype idirect-fb-surface :void) ;;unknow
(defctype zx-handle :uint32) ;;unknow
(defctype gpp-stream-descriptor :uint32)
(defctype ca-metal-layer :void) ;;unknow
;;struct type
(defcstruct vk-allocation-callback
  (:user-data (:pointer :void))
  (:fn-allocation vk-allocation-function)
  (:fn-reallocation vk-reallocation-function)
  (:fn-free vk-free-function)
  (:fn-internal-allocation vk-internal-allocation-notification)
  (:fn-internal-free vk-internal-free-notification))

(defctype vk-p-allocator (:pointer (:struct vk-allocation-callback)))

(defcstruct vk-debug-report-callback-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:pfn-callback pfn-vk-debug-report-callback-ext)
  (:user-data (:pointer :void)))

(defcstruct vk-offset-2d
  (:x :uint32)
  (:y :uint32))

(defcstruct vk-offset-3d
  (:x :uint32)
  (:y :uint32)
  (:z :uint32))

(defcstruct vk-extent-2d
  (:width :uint32)
  (:height :uint32))

(defcstruct vk-extent-3d
  (:width :uint32)
  (:height :uint32)
  (:depth :uint32))

(defcstruct vk-rect-2d
  (:offset (:struct vk-offset-2d))
  (:extent (:struct vk-extent-2d)))

(defcstruct vk-component-mapping
  (:r VkComponentSwizzle)
  (:g VkComponentSwizzle)
  (:b VkComponentSwizzle)
  (:a VkComponentSwizzle))

(defcstruct vk-viewport
  (:x :float)
  (:y :float)
  (:width :float)
  (:height :float)
  (:min-depth :float)
  (:max-depth :float))

(defcstruct vk-extension-properties
  (:extension-name :char :count 255)
  (:spec-version :uint32))

(defcstruct vk-layer-properties
  (:layer-name :char :count 255)
  (:spec-version :uint32)
  (:implementation-version :uint32)
  (:description :char :count 255))

(defcstruct vk-application-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:application-name (:pointer :char))
  (:application-version :uint32)
  (:engine-name (:pointer :char))
  (:engine-version :uint32)
  (:api-version :uint32))

(defcstruct vk-instance-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:application-info (:pointer (:struct vk-application-info)))
  (:enable-layer-count :uint32)
  (:enable-layer-names (:pointer (:pointer :char)))
  (:enable-extension-count :uint32)
  (:enable-extension-names (:pointer (:pointer :char))))

(defcstruct vk-device-queue-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:queue-family-index :uint32)
  (:queue-count :uint32)
  (:queue-properties (:pointer :float)))

(defcstruct vk-physical-device-features
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

(defcstruct vk-device-create-info
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
(defcstruct vk-physical-device-limits
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

(defcstruct vk-physical-device-sparse-properties
  (:residency-standard2-d-block-shape vk-bool-32)
  (:residency-standard2-d-multisample-block-shape vk-bool-32)
  (:residency-standard3-d-block-shape vk-bool-32)
  (:residency-aligned-mip-size vk-bool-32)
  (:residency-non-resident-strict vk-bool-32))

(defcstruct vk-physical-device-properties
  (:api-version :uint32)
  (:driver-version :uint32)
  (:vendor-id :uint32)
  (:device-id :uint32)
  (:device-type VkPhysicalDeviceType)
  (:device-name :char :count 256)
  (:pipeline-cache-uuid :uint8 :count 16)
  (:limits (:struct vk-physical-device-limits))
  (:spare-properties (:struct vk-physical-device-sparse-properties)))

(defcstruct vk-queue-family-properties
  (:queue-flags vk-flags)
  (:queue-count :uint32)
  (:timestamp-valid-bits  :uint32)
  (:min-image-transfer-granularity (:struct vk-extent-3d)))

(defcstruct vk-memory-type
  (:property-flags vk-flags)
  (:hape-index :uint32))

(defcstruct vk-memory-heap
  (:size vk-device-size)
  (:flags vk-flags))

(defcstruct vk-physical-device-memory-properties
  (:memory-type-count :uint32)
  (:memory-types (:struct vk-memory-type) :count 32) 
  (:memory-heap-count :uint32)
  (:memory-heaps (:struct vk-memory-heap) :count 16))

(defcstruct vk-format-properties
  (:linear-tiling-features vk-flags)
  (:optimal-tiling-features vk-flags)
  (:buffer-features vk-flags))

(defcstruct vk-image-format-properties
  (:max-extent (:struct vk-extent-3d))
  (:max-mip-levels :uint32)
  (:max-array-layers :uint32)
  (:sample-count vk-flags)
  (:max-resource-size vk-device-size))


;;surface struct
(defcstruct vk-andorid-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:windows (:pointer android-window)))

(defcstruct vk-wayland-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:display (:pointer (:struct wl-display)))
  (:surface (:pointer (:struct wl-surface))))

(defcstruct vk-win32-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:hinstance hinstance)
  (:hwnd hwnd))

(defcstruct vk-xcb-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:connection (:pointer xcb-connection))
  (:window xcb-window))

(defcstruct vk-xlib-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:dpy (:pointer xlib-display))
  (:window xlib-window))

(defcstruct vk-direct-fb-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:dfb (:pointer idirect-fb))
  (:surface (:pointer idirect-fb-surface)))

(defcstruct vk-image-pipe-surface-fuchsia-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:image-pipe-handle zx-handle))

(defcstruct vk-stream-descriptor-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:stream-descriptor gpp-stream-descriptor))

(defcstruct vk-ios-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:view (:pointer :void)))

(defcstruct vk-mac-os-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:view (:pointer :void)))

(defcstruct vk-vi-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:window (:pointer :void)))

(defcstruct vk-metal-surfaec-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:layer (:pointer ca-metal-layer)))

(defcstruct vk-display-plane-surface-create-info
  (:type vkstructuretype)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:display-mode vk-display-mode-khr)
  (:plane-index :uint32)
  (:plane-stack-index :uint32)
  (:transform VkSurfaceTransformFlagBitsKHR)
  (:global-alpha :float)
  (:alpha-mode VkDisplayPlaneAlphaFlagBitsKHR)
  (:image-extent (:struct vk-extent-2d)))

(defcstruct vk-swapchain-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
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

(defcstruct vk-surface-capabilities-khr
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

(defcstruct vk-surface-format-khr
  (:format VkFormat)
  (:color-space VkColorSpaceKHR))

(defcstruct vk-image-subresource-range
  (:aspect-mask VkImageAspectFlagBits)
  (:base-mip-level :uint32)
  (:level-count :uint32)
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(defcstruct vk-image-view-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:image vk-image)
  (:view-type VkImageViewtype)
  (:format VkFormat)
  (:components (:struct vk-component-mapping))
  (:subresource-range (:struct vk-image-subresource-range)))

(defcstruct vk-shader-module-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:code-size size-t)
  (:code (:pointer :uint32)))

(defcstruct vk-push-constant-range
  (:stage-flags vk-flags)
  (:offset :uint32)
  (:size :uint32))

(defcstruct vk-pipeline-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout))
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range))))

(defcstruct vk-specialization-map-entry
  (:constant-id :uint32)
  (:offset :uint32)
  (:size size-t))

(defcstruct vk-specialization-info
  (:map-entry-count :uint32)
  (:map-entrys (:pointer (:struct vk-specialization-map-entry)))
  (:data-size size-t)
  (:data (:pointer :void)))

(defcstruct vk-pipeline-shader-stage-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:stage VkShaderStageflagbits)
  (:module vk-shader-module)
  (:name (:pointer :char))
  (:specialization-info (:pointer (:struct vk-specialization-info))))

(defcstruct vk-vertex-input-binding-description
  (:binding :uint32)
  (:stride :uint32)
  (:input-rate VkVertexInputRate))

(defcstruct vk-vertex-input-attribute-description
  (:location :uint32)
  (:binding :uint32)
  (:format VkFormat)
  (:offset :uint32))

(defcstruct vk-pipeline-vertex-input-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:vertex-binding-description-count :uint32)
  (:vertex-binding-description (:pointer (:struct vk-vertex-input-binding-description)))
  (:vertex-attribute-description-count :uint32)
  (:vertex-attribute-description (:pointer (:struct vk-vertex-input-attribute-description))))

(defcstruct vk-pipeline-input-assembly-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:topology VkPrimitiveTopology)
  (:primitive-restart-enable vk-bool-32))

(defcstruct vk-pipeline-tessellation-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-flags)
  (:patch-control-points :uint32))
