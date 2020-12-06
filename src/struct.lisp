(in-package :vkvk)

(defcstruct vk-basic-structure
  (:type VkStructureType)
  (:next (:pointer (:struct vk-basic-structure))))

(defcstruct vk-basic-out-structure
  (:type VkStructureType)
  (:next (:pointer (:struct vk-basic-structure))))

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

(defcstruct vk-application-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:app-name (:pointer :char))
  (:app-version :uint32)
  (:engine-name (:pointer :char))
  (:engine-version :uint32)
  (:api-version :uint32))

(defcstruct vk-instance-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags (vk-instance-create-flags))
  (:info (:pointer (:struct vk-application-info)))
  (:layer-count :uint32)
  (:layers (:pointer (:pointer :char)))
  (:extension-count :uint32)
  (:extensions (:pointer (:pointer :char))))

(defcstruct vk-validation-flag-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:p-disable-validation-checks (:pointer VkValidationcheckext)))

(defcstruct vk-validation-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:enable-validation-feature-count :uint32)
  (:enable-validation-features (:pointer VkValidationFeatureEnableEXT))
  (:disable-validation-feature-count :uint32)
  (:disable-validation-features (:pointer VkValidationFeatureDisableEXT)))

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
  (:min-memory-map-alignment size-t)
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
  (:framebuffer-color-sample-counts vk-sample-count-flags)
  (:framebuffer-depth-sample-counts vk-sample-count-flags)
  (:framebuffer-stencil-sample-counts vk-sample-count-flags)
  (:framebuffer-no-attachments-sample-counts vk-sample-count-flags)
  (:max-color-attachments :uint32)
  (:sampled-image-color-sample-counts vk-sample-count-flags)
  (:sampled-image-integer-sample-counts vk-sample-count-flags)
  (:sampled-image-depth-sample-counts vk-sample-count-flags)
  (:sampled-image-stencil-sample-counts vk-sample-count-flags)
  (:storage-image-sample-counts vk-sample-count-flags)
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
  (:limits  (:struct vk-physical-device-limits))
  (:spare-properties (:struct vk-physical-device-sparse-properties)))

(defcstruct vk-physical-device-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:properties (:struct vk-physical-device-properties)))

(defcstruct vk-physical-device-vulkan-11-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-uuid :uint8 :count 16)
  (:driver-uuid :uint8 :count 16)
  (:driver-luid :uint8 :count 16)
  (:device-node-mask :uint32)
  (:device-luid-vaild vk-bool-32)
  (:sub-group-size :uint32)
  (:sub-group-supported-stages VkShaderStageflagbits)
  (:sub-group-supported-operations VkSubgroupfeatureflagbits)
  (:sub-group-quad-operations-in-all-stage vk-bool-32)
  (:point-clipping-behavior VkPointclippingbehavior)
  (:max-multiview-view-count :uint32)
  (:max-multiview-instance-index :uint32)
  (:protected-no-fault vk-bool-32)
  (:max-per-set-descriptors :uint32)
  (:max-memory-allocation-size vk-device-size))

(defcstruct vk-conformance-version
  (:major :uint8)
  (:minor :uint8)
  (:subminor :uint8)
  (:patch :uint8))

(defcstruct vk-physical-device-vulkan-12-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:driver-id VkDriverId)
  (:driver-name :char :count 256)
  (:driver-info :char :count 256)
  (:conformance-version (:struct vk-conformance-version))
  (:denorm-behavior-independence vkshaderfloatcontrolsindependence)
  (:rounding-mode-independence vkshaderfloatcontrolsindependence)
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
  (:shader-rounding-mode-r-t-z-float64 vk-bool-32)
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
  (:max-descriptor-set-update-after-bind-input-attachments :uint32)
  (:supported-depth-resolve-modes vk-reslove-mode-flags)
  (:supported-stencil-resolve-modes vk-reslove-mode-flags)
  (:independent-resolve-none vk-bool-32)
  (:independent-resolve vk-bool-32)
  (:filter-minmax-single-component-formats vk-bool-32)
  (:filter-minmax-image-component-mapping vk-bool-32)
  (:max-timeline-semaphore-value-difference :uint64)
  (:framebuffer-integer-color-sample-counts vk-sample-count-flags))

(defcstruct vk-physical-device-id-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-uuid :uint8 :count 16)
  (:driver-uuid :uint8 :count 16)
  (:device-luid :uint8 :count 16)
  (:device-node-mask :uint32)
  (:device-luid-vaild vk-bool-32))

(defcstruct vk-physical-device-driver-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:driver-id VkDriverid)
  (:driver-name :char :count 256)
  (:driver-info :char :count 256)
  (:conformance-version (:struct vk-conformance-version)))

(defcstruct vk-physical-device-pci-bus-info-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pci-domain :uint32)
  (:pci-bus :uint32)
  (:pci-device :uint32)
  (:pci-function :uint32))

(defcstruct vk-queue-family-properties
  (:queue-flags vk-queue-flags)
  (:queue-count :uint32)
  (:timestamp-valid-bits :uint32)
  (:min-image-transfer-granularity (:struct vk-extent-3d)))

(defcstruct vk-queue-family-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:queue-family-properties (:struct vk-queue-family-properties)))

(defcstruct vk-queue-family-checkpoint-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:checkpoint-execution-stage-mask vk-pipeline-stage-flags))

(defcstruct vk-performance-counter-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:unit VkPerformanceCounterunitkhr)
  (:scope VkPerformanceCounterscopekhr)
  (:storage VkPerformanceCounterStoragekhr)
  (:uuid :uint8 :count 16))

(defcstruct vk-performance-counter-description-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-performance-counter-description-flags-khr)
  (:name :char :count 256)
  (:category :char :count 256)
  (:description :char :count 256))

(defcstruct vk-physical-device-group-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:physical-device-count :uint32)
  (:physical-devices vk-physical-device :count 32)
  (:subset-allocation vk-bool-32))

(defcstruct vk-device-queue-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-device-queue-create-flags)
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
  (:flags vk-device-create-flags)
  (:queue-create-info-count :uint32)
  (:queue-create-infos (:pointer (:struct vk-device-queue-create-info)))
  (:layer-count :uint32)
  (:layers (:pointer (:pointer :char)))
  (:extension-count :uint32)
  (:extensions (:pointer (:pointer :char)))
  (:enable-features (:pointer (:struct vk-physical-device-features))))

(defcstruct vk-device-group-device-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:physical-device-count :uint32)
  (:physical-device (:pointer vk-physical-device)))

(defcstruct vk-device-memory-overallocation-create-info-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:overallocation-behavior VkMemoryOverallocationbehavioramd))

(defcstruct vk-device-diagnostics-config-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-device-diagnostics-config-flags-nv))

(defcstruct vk-device-private-data-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:private-data-slot-request-count :uint32))

(defcstruct vk-device-queue-global-priority-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:global-priority VkQueueGlobalPriorityExt))

(defcstruct vk-device-queue-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-device-queue-create-flags)
  (:queue-family-index :uint32)
  (:queue-index :uint32))

(defcstruct vk-command-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-command-pool-create-flags)
  (:queue-family-index :uint32))

(defcstruct vk-command-buffer-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:command-pool vk-command-pool)
  (:level VKCommandbufferlevel)
  (:command-buffer-count :uint32))

(defcstruct vk-command-buffer-inheritance-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:render-pass vk-render-pass)
  (:sub-pass :uint32)
  (:framebuffer vk-framebuffer)
  (:occlusion-query-enable vk-bool-32)
  (:flags vk-query-control-flags)
  (:pipeline-statistics vk-query-pipeline-statistic-flags))

(defcstruct vk-command-buffer-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-command-buffer-usage-flags)
  (:inheritance-info (:pointer (:struct vk-command-buffer-inheritance-info))))

(defcstruct vk-command-buffer-inheritance-conditional-rendering-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conditional-rendering-enable vk-bool-32))

(defcstruct vk-command-buffer-inheritance-render-pass-transform-info-qcom
  (:type VkStructureType)
  (:next (:pointer :void))
  (:transform VkSurfaceTransformflagbitskhr)
  (:render-area (:struct vk-rect-2d)))

(defcstruct vk-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphores (:pointer vk-semaphore))
  (:wait-dst-stage-masks (:pointer vk-pipeline-stage-flags))
  (:command-buffer-count :uint32)
  (:command-buffers (:pointer vk-command-buffer))
  (:signal-semaphore-count :uint32)
  (:signal-semaphores (:pointer vk-semaphore)))

(defcstruct vk-timeline-semaphore-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-value-count :uint32)
  (:wait-semaphore-values (:pointer :uint64))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-values (:pointer :uint64)))

(defcstruct vk-d3d12-fence-submit-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-value-count :uint32)
  (:wait-semaphore-values (:pointer :uint64))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-values (:pointer :uint64)))

(defcstruct vk-win32-keyed-mutex-acquire-release-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acquire-count :uint32)
  (:acquire-syncs vk-device-memory)
  (:acquire-keys (:pointer :uint64))
  (:acquire-timeout (:pointer :uint32))
  (:release-count :uint32)
  (:release-syncs (:pointer vk-device-memory))
  (:release-keys (:pointer :uint64)))

(defcstruct vk-win32-keyed-mutex-acquire-release-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acquire-count :uint32)
  (:acquire-syncs vk-device-memory)
  (:acquire-keys (:pointer :uint64))
  (:acquire-timeout (:pointer :uint32))
  (:release-count :uint32)
  (:release-syncs (:pointer vk-device-memory))
  (:release-keys (:pointer :uint64)))

(defcstruct vk-protected-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:protected-submit vk-bool-32))

(defcstruct vk-device-group-submit-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphore-device-indices (:pointer :uint32))
  (:command-buffer-count :uint32)
  (:command-buffer-device-masks (:pointer :uint32))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-device-indices (:pointer :uint32)))

(defcstruct vk-performance-query-submit-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:count-pass-index :uint32))

(defcstruct vk-device-group-command-buffer-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-mask :uint32))

(defcstruct vk-fence-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-fence-create-flags))

(defcstruct vk-export-fence-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-external-fence-handle-type-flags))

;;in windows 
(defcstruct security-attributes
  (:length :uint32)
  (:lp-void (:pointer :void))
  (:bool :int32))

(defcstruct vk-export-fence-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defcstruct vk-fence-get-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:handle-type VkExternalFenceHandleTypeFlagBits))
;;end windows

(defcstruct vk-fence-get-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:handle-type VkExternalFenceHandleTypeFlagBits))

(defcstruct vk-device-event-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-event VkDeviceEventTypeExt))

(defcstruct vk-display-event-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-event VkDisplayEventTypeExt))

(defcstruct vk-import-fence-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:flags vk-fence-import-flags)
  (:handle-type VkExternalFenceFeatureFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defcstruct vk-import-fence-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fence vk-fence)
  (:flags vk-fence-import-flags)
  (:handle-type VkExternalFenceFeatureFlagBits)
  (:fd :int))

(defcstruct vk-semaphore-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-semaphore-create-flags))

(defcstruct vk-semaphore-type-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore-type VkSemaphoreType)
  (:initial-value :uint64))

(defcstruct vk-export-semaphore-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-semaphore-handle-type-flags))

(defcstruct vk-export-semaphore-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defcstruct vk-semaphore-get-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:handle-type VkExternalSemaphoreHandleTypeFlagbits))

(defcstruct vk-semaphore-get-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:handle-type VkExternalSemaphoreHandleTypeFlagbits))

(defcstruct vk-semaphore-wait-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-semaphore-wait-flags)
  (:semaphore-count :uint32)
  (:semaphores (:pointer vk-semaphore))
  (:value (:pointer :uint64)))

(defcstruct vk-semaphore-signal-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:value :uint64))

(defcstruct vk-import-semaphore-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:flags vk-semaphore-import-flags)
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defcstruct vk-import-semaphore-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:semaphore vk-semaphore)
  (:flags vk-semaphore-import-flags)
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits)
  (:fd :int))

(defcstruct vk-event-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-event-create-flags))

(defcstruct vk-memory-barrier
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags))

(defcstruct vk-buffer-memory-barrier
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:src-queue-family-index :uint32)
  (:dst-queue-family-index :uint32)
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:size vk-device-size))

(defcstruct vk-image-subresource-range
  (:aspect-mask VkImageAspectFlagBits)
  (:base-mip-level :uint32)
  (:level-count :uint32)
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(defcstruct vk-image-memory-barrier
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

(defcstruct vk-calibrated-timestamp-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:time-domain VkTimedomainext))

(defcstruct vk-attachment-description
  (:flags vk-attachment-description-flags)
  (:format VkFormat)
  (:samples VkSampleCountFlagbits)
  (:load-op VkAttachmentLoadop)
  (:store-op VkAttachmentStoreop)
  (:stencil-load-op VkAttachmentLoadop)
  (:stencil-store-op VkAttachmentStoreop)
  (:initial-layout VkImageLayout)
  (:final-layout VkImageLayout))

(defcstruct vk-attachment-reference
  (:attachment :uint32)
  (:layout VkImageLayout))

(defcstruct vk-subpass-description
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

(defcstruct vk-subpass-dependency
  (:src-subpass :uint32)
  (:dst-subpass :uint32)
  (:src-stage-mask vk-pipeline-stage-flags)
  (:dst-stage-mask vk-pipeline-stage-flags)
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:dependency-flags vk-dependency-flags))

(defcstruct vk-render-pass-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-render-pass-create-flags)
  (:attachment-count :uint32)
  (:attachments (:pointer (:struct vk-attachment-description)))
  (:subpass-count :uint32)
  (:subpasses (:pointer (:struct vk-subpass-description)))
  (:dependency-count :uint32)
  (:dependencies (:pointer (:struct vk-subpass-dependency))))

(defcstruct vk-render-pass-multiview-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subpass-count :uint32)
  (:view-mask (:pointer :uint32))
  (:dependency-count :uint32)
  (:view-offsets (:pointer :uint32))
  (:correlation-mask-count :uint32)
  (:correlation-mask (:pointer :uint32)))

(defcstruct vk-render-pass-fragment-density-map-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-density-map-attachment (:struct vk-attachment-reference)))

(defcstruct vk-input-attachment-aspect-reference
  (:subpass :uint32)
  (:input-attachment-index :uint32)
  (:aspect-mask vk-image-aspect-flags))

(defcstruct vk-render-pass-input-attachment-aspect-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aspect-reference-count :uint32)
  (:aspect-reference (:pointer (:struct vk-input-attachment-aspect-reference))))

(defcstruct vk-attachment-description2
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

(defcstruct vk-attachment-reference2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment :uint32)
  (:layout VkImageLayout)
  (:aspect-mask vk-image-aspect-flags))

(defcstruct vk-subpass-description2
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

(defcstruct vk-subpass-dependency2
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

(defcstruct vk-render-pass-create-info2
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

(defcstruct vk-attachment-description-stenci-layout
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stencil-initial-layout VkImageLayout)
  (:stencil-final-layout VkImageLayout))

(defcstruct vk-subpass-description-depth-stencil-reslove
  (:type VkStructureType)
  (:next (:pointer :void))
  (:depth-reslove-mode VkResolveModeFlagbits)
  (:stencil-reslove-mode VkResolveModeFlagbits)
  (:depth-stencil-resolve-attachment (:struct vk-attachment-reference2)))

(defcstruct vk-attachment-reference-stencil-layout
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stencil-layout VkImageLayout))

(defcstruct vk-framebuffer-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-framebuffer-create-flags)
  (:render-pass vk-render-pass)
  (:attachment-count :uint32)
  (:attachments (:pointer vk-image-view))
  (:width :uint32)
  (:height :uint32)
  (:layers :uint32))

(defcstruct vk-framebuffer-attachment-image-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-image-create-flags)
  (:usage vk-image-usage-flags)
  (:width :uint32)
  (:height :uint32)
  (:layer-count :uint32)
  (:voew-format-count :uint32)
  (:view-formats (:pointer VkFormat)))

(defcstruct vk-framebuffer-attachments-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment-image-info-count :uint32)
  (:attachment-image-infos (:pointer (:struct vk-framebuffer-attachment-image-info))))

(defcunion vk-clear-color-value
  (:f32 (:pointer :float))
  (:i32 (:pointer :int32))
  (:ui32 (:pointer :uint32)))

(defcstruct vk-clear-depth-stencil-value
  (:depth :float)
  (:stencil :uint32))

(defcunion vk-clear-value
  (:color (:union vk-clear-color-value))
  (:depth-stencil (:struct vk-clear-depth-stencil-value)))

(defcstruct vk-render-pass-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:render-pass vk-render-pass)
  (:framebuffer vk-framebuffer)
  (:render-area (:struct vk-rect-2d))
  (:clear-value-count :uint32)
  (:clear-values (:pointer (:union vk-clear-value))))

(defcstruct vk-sample-location-ext
  (:x :float)
  (:y :float))

(defcstruct vk-sample-locations-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sample-locations-per-pixel VkSampleCountFlagbits)
  (:sample-location-grid-size (:struct vk-extent-2d))
  (:sample-locations-count :uint32)
  (:sample-locations (:pointer (:struct vk-sample-location-ext))))

(defcstruct vk-attachment-sample-locations-ext
  (:attachment-index :uint32)
  (:sample-locations-info (:struct vk-sample-locations-info-ext)))

(defcstruct vk-subpass-sample-locations-ext
  (:subpass-index :uint32)
  (:sample-location-info (:struct vk-sample-locations-info-ext)))

(defcstruct vk-render-pass-sample-locations-begin-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment-initial-sample-locations-count :uint32)
  (:attachment-initial-sample-locations (:pointer (:struct vk-attachment-sample-locations-ext)))
  (:post-subpass-sample-locations-count :uint32)
  (:post-subpass-sample-locations (:struct vk-subpass-sample-locations-ext)))

(defcstruct vk-render-pass-transform-begin-info-qcom
  (:type VkStructureType)
  (:next (:pointer :void))
  (:transform VkSurfaceTransformFlagbitsKHR))

(defcstruct vk-subpass-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:contents VkSubpassContents))

(defcstruct vk-device-group-render-pass-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-mask :uint32)
  (:device-render-area-count :uint32)
  (:device-render-areas (:pointer (:struct vk-rect-2d))))

(defcstruct vk-render-pass-attachment-begin-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attachment-count :uint32)
  (:attachment (:pointer vk-image-view)))

(defcstruct vk-subpass-end-info
  (:type VkStructureType)
  (:next (:pointer :void)))

(defcstruct vk-shader-module-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-module-create-flags)
  (:code-size size-t)
  (:code (:pointer :uint32)))

(defcstruct vk-shader-module-validation-cache-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:validation-cache vk-validation-cache-ext))

(defcstruct vk-cooperative-matrix-properties-nv
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

(defcstruct vk-validation-cache-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-validation-cache-create-flags-ext)
  (:initial-data-size size-t)
  (:initial-data (:pointer :void)))

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
  (:flags vk-pipeline-stage-flags)
  (:stage VkShaderStageflagbits)
  (:module vk-shader-module)
  (:name (:pointer :char))
  (:specialization-info (:pointer (:struct vk-specialization-info))))

(defcstruct vk-compute-pipeline-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-create-flags)
  (:stage (:struct vk-pipeline-shader-stage-create-info))
  (:layout vk-pipeline-layout)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))

(defcstruct vk-pipeline-shader-stage-required-subground-size-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:required-subground-size :uint32))

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
  (:flags vk-pipeline-vertex-input-state-create-flags)
  (:vertex-binding-description-count :uint32)
  (:vertex-binding-description (:pointer (:struct vk-vertex-input-binding-description)))
  (:vertex-attribute-description-count :uint32)
  (:vertex-attribute-description (:pointer (:struct vk-vertex-input-attribute-description))))

(defcstruct vk-pipeline-input-assembly-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-input-assembly-state-create-flags)
  (:topology VkPrimitiveTopology)
  (:primitive-restart-enable vk-bool-32))

(defcstruct vk-pipeline-tessellation-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-tessellation-state-create-flags)
  (:patch-control-points :uint32))

(defcstruct vk-viewport
  (:x :float)
  (:y :float)
  (:width :float)
  (:height :float)
  (:min-depth :float)
  (:max-depth :float))

(defcstruct vk-pipeline-viewport-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-viewport-state-create-flags)
  (:viewport-count :uint32)
  (:viewports (:pointer (:struct vk-viewport)))
  (:scissor-count :uint32)
  (:scissors (:pointer (:struct vk-rect-2d))))

(defcstruct vk-pipeline-rasterization-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-rasterization-state-create-flags)
  (:depth-clamp-enable vk-bool-32)
  (:rasterizer-discard-enable vk-bool-32)
  (:polygon-mode VkPolygonMode)
  (:cull-mode vk-cull-mode-flags)
  (:front-face VkFrontface)
  (:depth-bias-enable vk-bool-32)
  (:depth-bias-constant-factor :float)
  (:depth-bias-clamp :float)
  (:depth-bias-slope-factor :float)
  (:line-width :float))

(defcstruct vk-pipeline-multisample-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-multisample-state-create-flags)
  (:rasterization-sample VkSampleCountFlagbits)
  (:sample-shading-enable vk-bool-32)
  (:min-sample-shading :float)
  (:sample-mask (:pointer vk-sample-mask))
  (:alpha-to-coverage-enable vk-bool-32)
  (:alpha-to-one-enable vk-bool-32))

(defcstruct vk-stencil-op-state
  (:fail-op VkStencilop)
  (:pass-op VkStencilop)
  (:depth-fail-op VkStencilop)
  (:compare-op VkCompareop)
  (:compare-mask :uint32)
  (:write-mask :uint32)
  (:references :uint32))

(defcstruct vk-pipeline-depth-stencil-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-depth-stencil-state-create-flags)
  (:depth-test-enable vk-bool-32)
  (:depth-write-enable vk-bool-32)
  (:depth-compare-op VkCompareop)
  (:depth-bounds-test-enable vk-bool-32)
  (:stencil-test-enable vk-bool-32)
  (:front (:struct vk-stencil-op-state))
  (:back (:struct vk-stencil-op-state))
  (:min-depth-bounds :float)
  (:max-depth-bounds :float))

(defcstruct vk-pipeline-color-blend-attachment-state
  (:blend-enable vk-bool-32)
  (:src-color-blend-factor VkBlendFactor)
  (:dst-color-blend-factor VkBlendFactor)
  (:color-blend-op VkBlendop)
  (:src-alpha-blend-factor VkBlendFactor)
  (:dst-alpha-blend-factor VkBlendFactor)
  (:alpha-blend-op VkBlendop)
  (:color-write-mask vk-color-component-flags))

(defcstruct vk-pipeline-color-blend-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-color-blend-state-create-flags)
  (:logic-op-enable vk-bool-32)
  (:logic-op VkLogicop)
  (:attachment-count :uint32)
  (:attachments (:pointer (:struct vk-pipeline-color-blend-attachment-state)))
  (:blend-constants :float :count 4))

(defcstruct vk-pipeline-dynamic-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-dynamic-state-create-flags)
  (:dynamic-state-count :uint32)
  (:dynamic-states (:pointer VkDynamicState)))

(defcstruct vk-graphics-pipeline-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-create-flags)
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

(defcstruct vk-graphics-shader-group-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:vetex-input-state (:pointer (:struct vk-pipeline-vertex-input-state-create-info)))
  (:tessellation-stage (:pointer (:struct vk-pipeline-tessellation-state-create-info))))

(defcstruct vk-graphics-pipeline-shader-groups-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:group-count :uint32)
  (:groups (:pointer (:struct vk-graphics-shader-group-create-info-nv)))
  (:pipeline-count :uint32)
  (:pipelines (:pointer vk-pipeline)))

(defcstruct vk-pipeline-cache-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-cache-create-flags)
  (:initial-date-size size-t)
  (:init-data (:pointer :void)))

(defcstruct vk-pipeline-library-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:library-count :uint32)
  (:libraries (:pointer vk-pipeline)))

(defcstruct vk-pipeline-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline vk-pipeline))

(defcstruct vk-pipeline-executable-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stage vk-shader-stage-flags)
  (:name :char :count 256)
  (:description :char :count 256)
  (:subgroup-size :uint32))

(defcstruct vk-pipeline-executable-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline vk-pipeline)
  (:executable-index :uint32))

(defcunion vk-pipeline-executable-statistic-value-khr
  (:b32 vk-bool-32)
  (:i64 :int64)
  (:u64 :uint64)
  (:f64 :double))

(defcstruct vk-pipeline-executable-statistic-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:name :char :count 256)
  (:description :char :count 256)
  (:format VkPipelineExecutableStatisticFormatKHR)
  (:value (:union vk-pipeline-executable-statistic-value-khr)))

(defcstruct vk-pipeline-executable-internal-representation-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:name :char :count 256)
  (:description :char :count 256)
  (:is-text vk-bool-32)
  (:data-size size-t)
  (:data (:pointer :void)))

(defcstruct vk-shader-resource-usage-amd
  (:num-used-vgprs :uint32)
  (:num-used-sgprs :uint32)
  (:lds-size-per-local-work-group :uint32)
  (:lds-usage-size-in-bytes size-t)
  (:scratch-mem-usage-in-bytes size-t))

(defcstruct vk-shader-statistics-info-amd
  (:shader-stage-mask vk-shader-stage-flags)
  (:resource-usage (:struct vk-shader-resource-usage-amd))
  (:num-physical-vgprs :uint32)
  (:num-physical-sgprs :uint32)
  (:num-available-vgprs :uint32)
  (:num-available-sgprs :uint32)
  (:computeWorkGroupSize :uint32 :count 3))

(defcstruct vk-pipeline-compiler-control-create-info-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compiler-control-flags vk-pipeline-compiler-control-flags-amd))

(defcstruct vk-ray-tracing-shader-group-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkRayTracingShaderGroupTypeKHR)
  (:general-shader :uint32)
  (:closes-hit-shader :uint32)
  (:any-hit-shader :uint32)
  (:intersection-shader :uint32))

(defcstruct vk-ray-tracing-pipeline-create-info-nv
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

(defcstruct vk-ray-tracing-shader-group-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkRayTracingShaderGroupTypeKHR)
  (:general-shader :uint32)
  (:closes-hit-shader :uint32)
  (:any-hit-shader :uint32)
  (:intersection-shader :uint32)
  (:shader-group-capture-replay-handle (:pointer :void)))

(defcstruct vk-pipeline-library-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:library-count :uint32)
  (:library (:pointer vk-pipeline)))

(defcstruct vk-ray-tracing-pipeline-interface-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-payload-size :uint32)
  (:max-attribute-size :uint32)
  (:max-callable-size :uint32))

(defcstruct vk-ray-tracing-pipeline-create-info-khr
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

(defcstruct vk-pipeline-creation-feedback-ext
  (:flags vk-pipeline-creation-feedback-flags-ext)
  (:duration :uint64))

(defcstruct vk-pipeline-creation-feedback-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-creation-feedback (:pointer (:struct vk-pipeline-creation-feedback-ext)))
  (:pipeline-stage-creation-feedback-count :uint32)
  (:pipeline-stage-creation-feedbacks (:pointer (:struct vk-pipeline-creation-feedback-ext))))

(defcstruct vk-allocation-callback
  (:user-data (:pointer :void))
  (:fn-allocation vk-allocation-function)
  (:fn-reallocation vk-reallocation-function)
  (:fn-free vk-free-function)
  (:fn-internal-allocation vk-internal-allocation-notification)
  (:fn-internal-free vk-internal-free-notification))

(defcstruct vk-memory-type
  (:property-flags vk-memory-property-flags)
  (:hape-index :uint32))

(defcstruct vk-memory-heap
  (:size vk-device-size)
  (:flags vk-memory-heap-flags))

(defcstruct vk-physical-device-memory-properties
  (:memory-type-count :uint32)
  (:memory-types (:struct vk-memory-type) :count 32) 
  (:memory-heap-count :uint32)
  (:memory-heaps (:struct vk-memory-heap) :count 16))

(defcstruct vk-physical-device-memory-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-properties (:struct vk-physical-device-properties)))

(defcstruct vk-physical-device-memory-budget-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:heap-budget vk-device-size :count 32)
  (:heap-usage vk-device-size :count 32))

(defcstruct vk-memory-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:allocation-size vk-device-size)
  (:memory-type-index :uint32))

(defcstruct vk-memory-dedicated-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image)
  (:buffer vk-buffer))

(defcstruct vk-dedicated-allocation-memory-allocate-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image)
  (:buffer vk-buffer))

(defcstruct vk-memory-priority-allocate-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:priority :float))

(defcstruct vk-export-memory-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags))

(defcstruct vk-export-memory-win32-handle-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defcstruct vk-import-memory-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defcstruct vk-memory-get-win32-handle-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defcstruct vk-memory-win32-handle-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-type-bits :uint32))

(defcstruct vk-import-memory-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:fd :int))

(defcstruct vk-memory-get-fd-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defcstruct vk-memory-fd-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-type-bits :uint32))

(defcstruct vk-import-memory-host-pointer-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:host-pointer (:pointer :void)))

(defcstruct vk-memory-host-pointer-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-type-bits :uint32))

#|
i don't know how to set up android in lisp
(defcstruct vk-import-android-hardware-buffer-info-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defcstuct vk-memory-get-android-hardware-buffer-info-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defcstruct vk-android-hardware-buffer-properties-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defcstruct vk-android-hardware-buffer-format-properties-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defcstruct vk-external-format-android
  (:type VkStructureType)
  (:next (:pointer :void)))

(defcstruct vk-android-surface-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void)))

|#

(defcstruct vk-export-memory-allocate-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv))

(defcstruct vk-export-memory-win32-handle-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32))

(defcstruct vk-import-memory-win32-handle-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv)
  (:handle (:pointer :void)))

(defcstruct vk-memory-allocate-flags-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-memory-allocate-flags)
  (:device-mask :uint32))

(defcstruct vk-memory-opaque-capture-address-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:opaque-capture-address :uint64))

(defcstruct vk-memory-opaque-capture-address-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:opaque-capture-address :uint64))

(defcstruct vk-mapped-memory-range
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory)
  (:offset vk-device-size)
  (:size vk-device-size))

(defcstruct vk-device-memory-opaque-capture-address-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory vk-device-memory))

(defcstruct vk-buffer-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-buffer-create-flags)
  (:size vk-device-size)
  (:usage vk-buffer-usage-flags)
  (:sharing-mode VkSharingMode)
  (:queue-family-count :uint32)
  (:queue-family-indices (:pointer :uint32)))

(defcstruct vk-dedicated-allocation-buffer-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:dedicated-allocation vk-bool-32))

(defcstruct vk-external-memory-buffer-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-types vk-external-memory-handle-type-flags))

(defcstruct vk-buffer-opaque-capture-address-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:opaque-capture-address :uint64))

(defcstruct vk-buffer-device-address-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-address vk-device-address))

(defcstruct vk-buffer-view-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-buffer-view-create-flags)
  (:buffer vk-buffer)
  (:format VkFormat)
  (:offset vk-device-size)
  (:range vk-device-size))

(defcstruct vk-image-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-image-create-flags)
  (:image-type VkImageType)
  (:format VkFormat)
  (:extent (:struct vk-extent-3d))
  (:mip-levels :uint32)
  (:array-layers :uint32)
  (:samples VkSampleCountFlagBits)
  (:tiling VkImageTiling)
  (:usage vk-image-usage-flags)
  (:sharing-mode VkSharingMode)
  (:queue-family-index-count :uint32)
  (:queue-family-indices (:pointer :uint32))
  (:initial-layout VkImageLayout))

(defcstruct vk-image-stencil-usage-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stencil-usage vk-image-usage-flags))

(defcstruct vk-dedicated-allocation-image-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:dedicated-allocation vk-bool-32))

(defcstruct vk-external-memory-image-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-types vk-external-memory-handle-type-flags))

(defcstruct vk-external-memory-image-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv))

(defcstruct vk-image-swapchain-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr))

(defcstruct vk-image-format-list-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:view-format-count :uint32)
  (:view-format (:pointer VkFormat)))

(defcstruct vk-image-drm-format-modifier-list-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier-count :uint32)
  (:drm-format-modifiers (:pointer :uint64)))

(defcstruct vk-subresource-layout
  (:offset vk-device-size)
  (:size vk-device-size)
  (:row-pitch vk-device-size)
  (:array-pitch vk-device-size)
  (:depth-pitch vk-device-size))

(defcstruct vk-image-drm-format-modifier-explicit-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier :uint64)
  (:drm-format-modifier-plane-count :uint32)
  (:plane-layouts (:pointer (:struct vk-subresource-layout))))

(defcstruct vk-image-subresource
  (:aspect-mask vk-image-aspect-flags)
  (:mip-level :Uint32)
  (:array-layer :uint32))

(defcstruct vk-image-drm-format-modifier-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier :uint64))

(defcstruct vk-component-mapping
  (:r VkComponentSwizzle)
  (:g VkComponentSwizzle)
  (:b VkComponentSwizzle)
  (:a VkComponentSwizzle))

(defcstruct vk-image-view-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-image-view-create-flags)
  (:image vk-image)
  (:view-type VkImageViewtype)
  (:format VkFormat)
  (:components (:struct vk-component-mapping))
  (:subresource-range (:struct vk-image-subresource-range)))

(defcstruct vk-image-view-usage-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:usage vk-image-usage-flags))

(defcstruct vk-image-view-a-s-t-c-decode-mode-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:decode-mode VkFormat))

(defcstruct vk-image-view-handle-info-nvx
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-view vk-image-view)
  (:descriptor-type VkDescriptorType)
  (:sampler vk-sampler))

(defcstruct vk-image-view-address-properties-nvx
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-address vk-device-address)
  (:size vk-device-size))

(defcstruct vk-memory-requirements
  (:size vk-device-size)
  (:alignment vk-device-size)
  (:memory-type-bits :uint32))

(defcstruct vk-buffer-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))

(defcstruct vk-image-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defcstruct vk-image-plane-memory-requirements-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-memory-requirements)))

(defcstruct vk-memory-dedicated-requirements
  (:type VkStructureType)
  (:next (:pointer :void))
  (:prefers-dedicated-allocation vk-bool-32)
  (:requires-dedicated-allocation vk-bool-32))

(defcstruct vk-bind-buffer-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-buffer-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defcstruct vk-bind-image-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg vk-image)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-image-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32))
  (:split-instance-bind-region-count :uint32)
  (:split-instance-bind-regions (:pointer (:struct vk-rect-2d))))

(defcstruct vk-bind-image-memory-swapchain-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:image-index :uint32))

(defcstruct vk-bind-image-plane-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-geometry-triangles-nv
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

(defcstruct vk-geometry-aabb-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aabb-data vk-buffer)
  (:num-aabbs :uint32)
  (:stride :uint32)
  (:offset vk-device-size))

(defcstruct vk-geometry-data-nv
  (:triangles (:struct vk-geometry-triangles-nv))
  (:aabbs (:struct vk-geometry-aabb-nv)))

(defcstruct vk-geometry-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry-data (:struct vk-geometry-data-nv))
  (:flags vk-geometry-flags-khr))

(defcstruct vk-acceleration-structure-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-nv)
  (:instance-count :uint32)
  (:geometry-count :uint32)
  (:geometries (:pointer (:struct vk-geometry-nv))))

(defcstruct vk-acceleration-structure-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:info (:struct vk-acceleration-structure-info-nv)))

(defcstruct vk-acceleration-structure-create-geometry-type-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:max-primitive-count :uint32)
  (:index-type VkIndexType)
  (:max-vertex-count :uint32)
  (:vertex-format VkFormat)
  (:allows-transforms vk-bool-32))

(defcstruct vk-acceleration-structure-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:max-geometry-count :uint32)
  (:geometry-infos (:pointer (:struct vk-acceleration-structure-create-geometry-type-info-khr)))
  (:device-address vk-device-address))

(defcstruct vk-acceleration-structure-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-acceleration-structure-memory-requirements-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:build-type VkAccelerationStructureBuildTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-bind-acceleration-structure-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defcstruct vk-acceleration-structure-device-address-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-sampler-create-info
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

(defcstruct vk-sampler-reduction-mode-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:reduction-mode VkSamplerReductionMode))

(defcstruct vk-sampler-ycbcr-conversion-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conversion vk-sampler-ycbcr-conversion))

(defcstruct vk-sampler-ycbcr-conversion-create-info
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

(defcstruct vk-sampler-custom-border-color-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-color (:union vk-clear-value))
  (:format VkFormat))

(defcstruct vk-descriptor-set-layout-binding
  (:binding :uint32)
  (:descriptor-type VkDescriptorType)
  (:descriptor-count :uint32)
  (:stage-flags vk-shader-stage-flags)
  (:immutable-samplers (:pointer vk-sampler)))

(defcstruct vk-descriptor-set-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-set-layout-create-flags)
  (:binding-count :uint32)
  (:bindings (:pointer (:struct vk-descriptor-set-layout-binding))))

(defcstruct vk-descriptor-set-layout-binding-flags-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:binding-count :uint32)
  (:binding-flags (:pointer vk-descriptor-binding-flags)))

(defcstruct vk-descriptor-set-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported vk-bool-32))

(defcstruct vk-descriptor-set-variable-descriptor-count-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-variable-descriptor-count :uint32))

(defcstruct vk-push-constant-range
  (:stage-flags vk-shader-stage-flags)
  (:offset :uint32)
  (:size :uint32))

(defcstruct vk-pipeline-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-layout-create-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout))
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range))))

(defcstruct vk-descriptor-pool-size
  (:type VkDescriptorType)
  (:descriptor-count :uint32))

(defcstruct vk-descriptor-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-pool-create-flags)
  (:max-sets :uint32)
  (:pool-size-count :uint32)
  (:pool-sizes (:pointer (:struct vk-descriptor-pool-size))))

(defcstruct vk-descriptor-pool-inline-uniform-block-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-bindings :uint32))

(defcstruct vk-descriptor-set-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descript-pool vk-descriptor-pool)
  (:descript-set-count :uint32)
  (:set-layouts vk-descriptor-set-layout))

(defcstruct vk-descriptor-set-variable-descriptor-count-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descriptor-set-count :uint32)
  (:descriptor-counts (:pointer :uint32)))

(defcstruct vk-memory-requirements
  (:size vk-device-size)
  (:alignment vk-device-size)
  (:memory-type-bits :uint32))

(defcstruct vk-buffer-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))

(defcstruct vk-image-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defcstruct vk-image-plane-memory-requirements-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-memory-requirements)))

(defcstruct vk-memory-dedicated-requirements
  (:type VkStructureType)
  (:next (:pointer :void))
  (:prefers-dedicated-allocation vk-bool-32)
  (:requires-dedicated-allocation vk-bool-32))

(defcstruct vk-bind-buffer-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-buffer-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defcstruct vk-bind-image-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg vk-image)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-image-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32))
  (:split-instance-bind-region-count :uint32)
  (:split-instance-bind-regions (:pointer (:struct vk-rect-2d))))

(defcstruct vk-bind-image-memory-swapchain-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:image-index :uint32))

(defcstruct vk-bind-image-plane-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-geometry-triangles-nv
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

(defcstruct vk-geometry-aabb-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aabb-data vk-buffer)
  (:num-aabbs :uint32)
  (:stride :uint32)
  (:offset vk-device-size))

(defcstruct vk-geometry-data-nv
  (:triangles (:struct vk-geometry-triangles-nv))
  (:aabbs (:struct vk-geometry-aabb-nv)))

(defcstruct vk-geometry-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry-data (:struct vk-geometry-data-nv))
  (:flags vk-geometry-flags-khr))

(defcstruct vk-acceleration-structure-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-nv)
  (:instance-count :uint32)
  (:geometry-count :uint32)
  (:geometries (:pointer (:struct vk-geometry-nv))))

(defcstruct vk-acceleration-structure-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:info (:struct vk-acceleration-structure-info-nv)))

(defcstruct vk-acceleration-structure-create-geometry-type-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:max-primitive-count :uint32)
  (:index-type VkIndexType)
  (:max-vertex-count :uint32)
  (:vertex-format VkFormat)
  (:allows-transforms vk-bool-32))

(defcstruct vk-acceleration-structure-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:max-geometry-count :uint32)
  (:geometry-infos (:pointer (:struct vk-acceleration-structure-create-geometry-type-info-khr)))
  (:device-address vk-device-address))

(defcstruct vk-acceleration-structure-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-acceleration-structure-memory-requirements-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:build-type VkAccelerationStructureBuildTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-bind-acceleration-structure-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defcstruct vk-acceleration-structure-device-address-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-sampler-create-info
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

(defcstruct vk-sampler-reduction-mode-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:reduction-mode VkSamplerReductionMode))

(defcstruct vk-sampler-ycbcr-conversion-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conversion vk-sampler-ycbcr-conversion))

(defcstruct vk-sampler-ycbcr-conversion-create-info
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

(defcstruct vk-sampler-custom-border-color-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-color (:union vk-clear-value))
  (:format VkFormat))

(defcstruct vk-descriptor-set-layout-binding
  (:binding :uint32)
  (:descriptor-type VkDescriptorType)
  (:descriptor-count :uint32)
  (:stage-flags vk-shader-stage-flags)
  (:immutable-samplers (:pointer vk-sampler)))

(defcstruct vk-descriptor-set-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-set-layout-create-flags)
  (:binding-count :uint32)
  (:bindings (:pointer (:struct vk-descriptor-set-layout-binding))))

(defcstruct vk-descriptor-set-layout-binding-flags-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:binding-count :uint32)
  (:binding-flags (:pointer vk-descriptor-binding-flags)))

(defcstruct vk-descriptor-set-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported vk-bool-32))

(defcstruct vk-descriptor-set-variable-descriptor-count-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-variable-descriptor-count :uint32))

(defcstruct vk-push-constant-range
  (:stage-flags vk-shader-stage-flags)
  (:offset :uint32)
  (:size :uint32))

(defcstruct vk-pipeline-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-layout-create-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout))
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range))))

(defcstruct vk-descriptor-pool-size
  (:type VkDescriptorType)
  (:descriptor-count :uint32))

(defcstruct vk-descriptor-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-pool-create-flags)
  (:max-sets :uint32)
  (:pool-size-count :uint32)
  (:pool-sizes (:pointer (:struct vk-descriptor-pool-size))))

(defcstruct vk-descriptor-pool-inline-uniform-block-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-bindings :uint32))

(defcstruct vk-descriptor-set-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descript-pool vk-descriptor-pool)
  (:descript-set-count :uint32)
  (:set-layouts vk-descriptor-set-layout))

(defcstruct vk-descriptor-set-variable-descriptor-count-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descriptor-set-count :uint32)
  (:descriptor-counts (:pointer :uint32)))

(defcstruct vk-memory-requirements
  (:size vk-device-size)
  (:alignment vk-device-size)
  (:memory-type-bits :uint32))

(defcstruct vk-buffer-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))

(defcstruct vk-image-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defcstruct vk-image-plane-memory-requirements-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-memory-requirements)))

(defcstruct vk-memory-dedicated-requirements
  (:type VkStructureType)
  (:next (:pointer :void))
  (:prefers-dedicated-allocation vk-bool-32)
  (:requires-dedicated-allocation vk-bool-32))

(defcstruct vk-bind-buffer-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-buffer-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defcstruct vk-bind-image-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg vk-image)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-image-memory-device-group-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32))
  (:split-instance-bind-region-count :uint32)
  (:split-instance-bind-regions (:pointer (:struct vk-rect-2d))))

(defcstruct vk-bind-image-memory-swapchain-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:image-index :uint32))

(defcstruct vk-bind-image-plane-memory-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-geometry-triangles-nv
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

(defcstruct vk-geometry-aabb-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:aabb-data vk-buffer)
  (:num-aabbs :uint32)
  (:stride :uint32)
  (:offset vk-device-size))

(defcstruct vk-geometry-data-nv
  (:triangles (:struct vk-geometry-triangles-nv))
  (:aabbs (:struct vk-geometry-aabb-nv)))

(defcstruct vk-geometry-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry-data (:struct vk-geometry-data-nv))
  (:flags vk-geometry-flags-khr))

(defcstruct vk-acceleration-structure-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-nv)
  (:instance-count :uint32)
  (:geometry-count :uint32)
  (:geometries (:pointer (:struct vk-geometry-nv))))

(defcstruct vk-acceleration-structure-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:info (:struct vk-acceleration-structure-info-nv)))

(defcstruct vk-acceleration-structure-create-geometry-type-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:max-primitive-count :uint32)
  (:index-type VkIndexType)
  (:max-vertex-count :uint32)
  (:vertex-format VkFormat)
  (:allows-transforms vk-bool-32))

(defcstruct vk-acceleration-structure-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compacted-size vk-device-size)
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:max-geometry-count :uint32)
  (:geometry-infos (:pointer (:struct vk-acceleration-structure-create-geometry-type-info-khr)))
  (:device-address vk-device-address))

(defcstruct vk-acceleration-structure-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-acceleration-structure-memory-requirements-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:build-type VkAccelerationStructureBuildTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-bind-acceleration-structure-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defcstruct vk-acceleration-structure-device-address-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-sampler-create-info
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

(defcstruct vk-sampler-reduction-mode-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:reduction-mode VkSamplerReductionMode))

(defcstruct vk-sampler-ycbcr-conversion-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conversion vk-sampler-ycbcr-conversion))

(defcstruct vk-sampler-ycbcr-conversion-create-info
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

(defcstruct vk-sampler-custom-border-color-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-color (:union vk-clear-value))
  (:format VkFormat))

(defcstruct vk-descriptor-set-layout-binding
  (:binding :uint32)
  (:descriptor-type VkDescriptorType)
  (:descriptor-count :uint32)
  (:stage-flags vk-shader-stage-flags)
  (:immutable-samplers (:pointer vk-sampler)))

(defcstruct vk-descriptor-set-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-set-layout-create-flags)
  (:binding-count :uint32)
  (:bindings (:pointer (:struct vk-descriptor-set-layout-binding))))

(defcstruct vk-descriptor-set-layout-binding-flags-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:binding-count :uint32)
  (:binding-flags (:pointer vk-descriptor-binding-flags)))

(defcstruct vk-descriptor-set-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported vk-bool-32))

(defcstruct vk-descriptor-set-variable-descriptor-count-layout-support
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-variable-descriptor-count :uint32))

(defcstruct vk-push-constant-range
  (:stage-flags vk-shader-stage-flags)
  (:offset :uint32)
  (:size :uint32))

(defcstruct vk-pipeline-layout-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-layout-create-flags)
  (:set-layout-count :uint32)
  (:set-layouts (:pointer vk-descriptor-set-layout))
  (:push-constant-range-count :uint32)
  (:push-constant-ranges (:pointer (:struct vk-push-constant-range))))

(defcstruct vk-descriptor-pool-size
  (:type VkDescriptorType)
  (:descriptor-count :uint32))

(defcstruct vk-descriptor-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-descriptor-pool-create-flags)
  (:max-sets :uint32)
  (:pool-size-count :uint32)
  (:pool-sizes (:pointer (:struct vk-descriptor-pool-size))))

(defcstruct vk-descriptor-pool-inline-uniform-block-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-bindings :uint32))

(defcstruct vk-descriptor-set-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descript-pool vk-descriptor-pool)
  (:descript-set-count :uint32)
  (:set-layouts vk-descriptor-set-layout))

(defcstruct vk-descriptor-set-variable-descriptor-count-allocate-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:descriptor-set-count :uint32)
  (:descriptor-counts (:pointer :uint32)))

(defcstruct vk-descriptor-image-info
  (:sampler vk-sampler)
  (:image-view vk-image-view)
  (:image-layout VkImageLayout))

(defcstruct vk-descriptor-buffer-info
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:range vk-device-size))

(defcstruct vk-write-descriptor-set
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

(defcstruct vk-write-descriptor-set-inline-uniform-block-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:data-size :uint32)
  (:data (:pointer :void)))

(defcstruct vk-write-descriptor-set-acceleration-structure-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:acceleration-structure-count :uint32)
  (:acceleration-structures vk-acceleration-structure-khr))

(defcstruct vk-copy-descriptor-set
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-set vk-descriptor-set)
  (:src-binding :uint32)
  (:src-array-element :uint32)
  (:dst-set vk-descriptor-set)
  (:dst-binding :uint32)
  (:dst-array-element :uint32)
  (:descriptor-count :uint32))

(defcstruct vk-descriptor-update-template-entry
  (:dst-binding :uint32)
  (:dst-array-element :uint32)
  (:descript-count :uint32)
  (:descriptor-type VkDescriptorType)
  (:offset size-t)
  (:stride size-t))

(defcstruct vk-descriptor-update-template-create-info
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

(defcstruct vk-buffer-device-address-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer))

(defcstruct vk-query-pool-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-query-pool-create-flags)
  (:query-type VkQueryType)
  (:query-count :uint32)
  (:pipeline-statistics vk-query-pipeline-statistic-flags))

(defcstruct vk-query-pool-performance-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:queue-family-index :uint32)
  (:counter-index-count :uint32)
  (:counter-indices (:pointer :uint32)))

(defcunion vk-performance-counter-result-khr
  (:i32 :uint32)
  (:i64 :uint64)
  (:u32 :uint32)
  (:u64 :uint64)
  (:f :float)
  (:d :double))

(defcstruct vk-acquire-profiling-lock-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-acquire-profiling-lock-flags-khr)
  (:timeout :uint64))

(defcstruct vk-initialize-performance-api-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:user-data (:pointer :void)))

(defcunion vk-performance-value-data-intel
  (:value32 :uint32)
  (:value64 :uint64)
  (:value-float :float)
  (:value-bool vk-bool-32)
  (:value-string (:pointer :char)))

(defcstruct vk-performance-value-intel
  (:type VkPerformanceValueTypeINTEL)
  (:data (:union vk-performance-value-data-intel)))

(defcstruct vk-query-pool-performance-query-create-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:performance-counters-sampling VkQueryPoolSamplingModeINTEL))

(defcstruct vk-performance-marker-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:marker :uint64))

(defcstruct vk-performance-stream-marker-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:marker :uint32))

(defcstruct vk-performance-override-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkPerformanceOverrideTypeINTEL)
  (:enable vk-bool-32)
  (:parameter :uint64))

(defcstruct vk-performance-configuration-acquire-info-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkPerformanceConfigurationTypeINTEL))

(defcstruct vk-clear-rect
  (:rect (:struct vk-rect-2d))
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(defcstruct vk-clear-attachment
  (:aspect-mask vk-image-aspect-flags)
  (:color-attachment :uint32)
  (:clear-values (:union vk-clear-value)))

(defcstruct vk-buffer-copy
  (:src-offset vk-device-size)
  (:dst-offset vk-device-size)
  (:size vk-device-size))

(defcstruct vk-image-subresource-layers
  (:aspect-mask vk-image-aspect-flags)
  (:mip-level :uint32)
  (:base-array-layer :uint32)
  (:layers-count :uint32))

(defcstruct vk-image-copy
  (:src-subresource (:struct vk-image-subresource-layers))
  (:src-offset (:struct vk-offset-3d))
  (:dst-subresource (:struct vk-image-subresource-layers))
  (:dst-offset (:struct vk-offset-3d))
  (:extent (:struct vk-extent-3d)))

(defcstruct vk-buffer-image-copy
  (:buffer-offset vk-device-size)
  (:buffer-row-length :uint32)
  (:buffer-image-height :uint32)
  (:image-subresource (:struct vk-image-subresource-layers))
  (:image-offset (:struct vk-offset-3d))
  (:image-extent (:struct vk-extent-3d)))

(defcstruct vk-image-blit
  (:src-subresource (:struct vk-image-subresource-layers))
  (:src-offset (:struct vk-offset-3d) :count 2)
  (:dst-subresource (:struct vk-image-subresource-layers))
  (:dst-offset (:struct vk-offset-3d) :count 2))

(defcstruct vk-image-resloved
  (:src-subresource (:struct vk-image-subresource-layers))
  (:src-offset (:struct vk-offset-3d))
  (:dst-subresource (:struct vk-image-subresource-layers))
  (:dst-offset (:struct vk-offset-3d))
  (:extent (:struct vk-extent-3d)))

(defcstruct vk-draw-indirect-command
  (:vertex-count :uint32)
  (:instance-count :uint32)
  (:firset-vertex :uint32)
  (:firset-instance :uint32))

(defcstruct vk-draw-indexed-indirect-command
  (:index-count :uint32)
  (:instance-count :uint32)
  (:firset-index :uint32)
  (:vertex-offset :int32)
  (:firset-instance :uint32))

(defcstruct vk-conditional-rendering-begin-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:flags vk-conditional-rendering-flags-ext))

(defcstruct vk-draw-mesh-tasks-indirect-command-nv
  (:task-count :uint32)
  (:first-task :uint32))

(defcstruct vk-pipeline-vertex-input-divisor-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-binding-divisor-count :uint32)
  (:vertex-binding-divisors (:pointer vk-conditional-rendering-flags-ext)))

(defcstruct vk-vertex-input-binding-divisor-description-ext
  (:binding :uint32)
  (:divisor :uint32))

(defcstruct vk-pipeline-tessellation-domain-origin-state-create-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:domain-origin VkTessellationDomainOrigin))

(defcstruct vk-viewport-swizzle-nv
  (:x VkViewportCoordinateSwizzleNV)
  (:y VkViewportCoordinateSwizzleNV)
  (:z VkViewportCoordinateSwizzleNV)
  (:w VkViewportCoordinateSwizzleNV))

(defcstruct vk-pipeline-viewport-swizzle-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-viewport-swizzle-state-create-flags-nv)
  (:view-port-count :uint32)
  (:view-port-swizzles (:pointer (:struct vk-viewport-swizzle-nv))))

(defcstruct vk-viewport-w-scaling-nv
  (:xcoeff :float)
  (:ycoeff :float))

(defcstruct vk-pipeline-viewport-w-scaling-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:view-port-w-scaling-enable vk-bool-32)
  (:view-port-count :uint32)
  (:view-port-w-scalings (:pointer (:struct vk-viewport-w-scaling-nv))))

(defcstruct vk-pipeline-rasterization-depth-clip-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-rasterization-depth-clip-state-create-flags-ext)
  (:depth-clip-enable vk-bool-32))

(defcstruct vk-pipeline-rasterization-state-stream-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-rasterization-state-stream-create-flags-ext)
  (:rasterization-stream :uint32))

(defcstruct vk-pipeline-rasterization-state-rasterization-order-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:rasterization-order VkRasterizationOrderAMD))

(defcstruct vk-pipeline-sample-locations-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sampler-locations-enable vk-bool-32)
  (:sampler-locations-info (:struct vk-sample-locations-info-ext)))

(defcstruct vk-shading-rate-palette-nv
  (:shading-rate-palette-entry-count :uint32)
  (:shading-rate-palette-entries (:pointer VkShadingRatePaletteEntryNV)))

(defcstruct vk-pipeline-viewport-shading-rate-image-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shading-rate-image-enable vk-bool-32)
  (:view-port-count :uint32)
  (:shading-rate-palettes (:pointer (:struct vk-shading-rate-palette-nv))))

(defcstruct vk-coarse-sample-location-nv
  (:pixel-x :uint32)
  (:pixel-y :uint32)
  (:sample :uint32))

(defcstruct vk-coarse-sample-order-custom-nv
  (:shading-rate VkShadingRatePaletteEntryNV)
  (:sample-count :uint32)
  (:sample-location-count :uint32)
  (:sample-locations (:pointer (:struct vk-coarse-sample-location-nv))))

(defcstruct vk-pipeline-viewport-coarse-sample-order-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sample-order-type VkCoarseSampleOrderTypeNV)
  (:custom-sample-order-count :uint32)
  (:custom-sample-orders (:pointer (:struct vk-coarse-sample-order-custom-nv))))

(defcstruct vk-pipeline-rasterization-line-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:line-rasterization-mode VkLineRasterizationModeEXT)
  (:stippled-line-enable vk-bool-32)
  (:line-stipple-factor :uint32)
  (:line-stipple-pattern :uint16))

(defcstruct vk-pipeline-rasterization-conservative-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-rasterization-conservative-state-create-flags-ext)
  (:conservative-rasterization-mode VkConservativeRasterizationModeEXT)
  (:extra-primitive-overestimation-size :float))

(defcstruct vk-pipeline-discard-rectangle-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-discard-rectangle-state-create-flags-ext)
  (:discard-rectangle-mode VkDiscardRectangleModeEXT)
  (:discard-rectangle-count :uint32)
  (:discard-rectangles (:pointer (:struct vk-rect-2d))))

(defcstruct vk-pipeline-viewport-exclusive-scissor-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:exclusive-scissor-count :uint32)
  (:discard-rectangle-count (:pointer (:struct vk-rect-2d))))

(defcstruct vk-pipeline-representative-fragment-test-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:representative-fragment-test-enable vk-bool-32))

(defcstruct vk-pipeline-coverage-to-color-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-coverage-to-color-state-create-flags-nv)
  (:coverage-to-color-enable vk-bool-32)
  (:coverage-to-color-location :uint32))

(defcstruct vk-pipeline-coverage-reduction-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-coverage-reduction-state-create-flags-nv)
  (:coverage-reduction-mode VkCoverageReductionModeNV))

(defcstruct vk-framebuffer-mixed-samples-combination-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:coverage-reduction-mode VkCoverageReductionModeNV)
  (:rasterization-samples VkSampleCountFlagBits)
  (:depth-stencil-samples vk-sample-count-flags)
  (:color-samples vk-sample-count-flags))

(defcstruct vk-pipeline-coverage-modulation-state-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-pipeline-coverage-modulation-state-create-flags-nv)
  (:coverage-modulation-mod VkCoverageModulationModeNV)
  (:coverage-modulation-table-enable vk-bool-32)
  (:coverage-modulation-table-count :uint32)
  (:coverage-modulation-table (:pointer :float)))

(defcstruct vk-pipeline-color-blend-advanced-state-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-premultiplied vk-bool-32)
  (:dst-premultiplied vk-bool-32)
  (:blend-overlap VkBlendOverlapEXT))

(defcstruct vk-dispatch-indirect-command
  (:x :uint32)
  (:y :uint32)
  (:z :uint32))

(defcstruct vk-indirect-commands-layout-token-nv
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

(defcstruct vk-indirect-commands-layout-create-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-indirect-commands-layout-usage-flags-nv)
  (:pipeline-bind-point VkPipelineBindPoint)
  (:token-count :uint32)
  (:tokens (:pointer (:struct vk-indirect-commands-layout-token-nv)))
  (:stream-count :uint32)
  (:stream-strides (:pointer :uint32)))

(defcstruct vk-indirect-commands-stream-nv
  (:buffer vk-buffer)
  (:offset vk-device-size))

(defcstruct vk-bind-shader-group-indirect-command-nv
  (:group-index :uint32))

(defcstruct vk-bind-index-buffer-indirect-command-nv
  (:buffer-address vk-device-address)
  (:size :uint32)
  (:index-type VkIndexType))

(defcstruct vk-bind-vertex-buffer-indirect-command-nv
  (:buffer-address vk-device-address)
  (:size :uint32)
  (:stride :uint32))

(defcstruct vk-set-state-flags-indirect-command-nv
  (:data :uint32))

(defcstruct vk-generated-commands-memory-requirements-info-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-bind-point VkPipelineBindPoint)
  (:pipeline vk-pipeline)
  (:indirect-commands-layout vk-indirect-commands-layout-nv)
  (:max-sequences-count :uint32))

(defcstruct vk-generated-commands-info-nv
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

(defcstruct vk-physical-device-sparse-properties
  (:residency-standard2-d-block-shape vk-bool-32)
  (:residency-standard2-d-multisample-block-shape vk-bool-32)
  (:residency-standard3-d-block-shape vk-bool-32)
  (:residency-aligned-mip-size vk-bool-32)
  (:residency-non-resident-strict vk-bool-32))

(defcstruct vk-sparse-image-format-properties
  (:aspect-mask vk-image-aspect-flags)
  (:image-granularity (:struct vk-extent-3d))
  (:flags vk-sparse-image-format-flags))

(defcstruct vk-physical-device-sparse-image-format-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format VkFormat)
  (:type VkImageType)
  (:samples VkSampleCountFlagBits)
  (:usage vk-image-usage-flags)
  (:tiling VkImageTiling))

(defcstruct vk-sparse-image-format-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:properties (:struct vk-sparse-image-format-properties)))

(defcstruct vk-sparse-image-memory-requirements
  (:format-properties (:struct vk-sparse-image-format-properties))
  (:image-mip-tail-first-lod :uint32)
  (:image-mip-tail-size vk-device-size)
  (:image-mip-tail-offset vk-device-size)
  (:image-mip-tail-stride vk-device-size))

(defcstruct vk-image-sparse-memory-requirements-info2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image vk-image))

(defcstruct vk-sparse-image-memory-requirements2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-requirements (:struct vk-sparse-image-memory-requirements)))

(defcstruct vk-sparse-memory-bind
  (:resource-offset vk-device-size)
  (:size vk-device-size)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:flags vk-sparse-memory-bind-flags))

(defcstruct vk-sparse-buffer-memory-bind-info
  (:buffer vk-buffer)
  (:bind-count :uint32)
  (:binds (:pointer (:struct vk-sparse-memory-bind))))

(defcstruct vk-sparse-image-opaque-memory-bind-info
  (:image vk-image)
  (:bind-count :uint32)
  (:binds (:pointer (:struct vk-sparse-memory-bind))))

(defcstruct vk-sparse-image-memory-bind
  (:subresource (:struct vk-image-subresource))
  (:offset (:struct vk-offset-3d))
  (:extent (:struct vk-extent-3d))
  (:memory vk-device-memory)
  (:memory-offset vk-device-size)
  (:flags vk-sparse-memory-bind-flags))

(defcstruct vk-sparse-image-memory-bind-info
  (:image vk-image)
  (:bind-count :uint32)
  (:binds (:pointer (:struct vk-sparse-image-memory-bind))))

(defcstruct vk-bind-sparse-info
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

(defcstruct vk-device-group-bind-sparse-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:resource-device-index :uint32)
  (:memory-device-index :uint32))

#|
(defcstruct vk-wayland-surface-create-info-khr)
(defcstruct vk-win32-surface-create-info-khr)
(defcstruct vk-xcb-surface-create-info-khr)
(defcstruct vk-xlib-surface-create-info-khr)
(defcstruct vk-direct-f-b-surface-create-info-ext)
(defcstruct vk-image-pipe-surface-create-info-fuchsia)
(defcstruct vk-stream-descriptor-surface-create-info-ggp)
(defcstruct vk-ios-surface-create-info-mvk)
(defcstruct vk-macos-surface-create-info-mvk)
(defcstruct vk-vi-surface-create-info-nn)
(defcstruct vk-metal-surface-create-info-ext)
|#

(defcstruct vk-display-properties-khr
  (:display vk-display-khr)
  (:display-name (:pointer :char))
  (:physical-dimensions (:struct vk-extent-2d))
  (:physical-resolution (:struct vk-extent-2d))
  (:supported-transforms vk-surface-transform-flags-khr)
  (:plane-reorder-possible vk-bool-32)
  (:persistent-content vk-bool-32))

(defcstruct vk-display-properties2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-properties (:struct vk-display-properties-khr)))

(defcstruct vk-display-plane-properties-khr
  (:current-display vk-display-khr)
  (:current-stack-index :uint32))

(defcstruct vk-display-plane-properties2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-plane-properties (:struct vk-display-plane-properties-khr)))

(defcstruct vk-display-mode-parameters-khr
  (:visible-region (:struct vk-extent-2d))
  (:refresh-rate :uint32))

(defcstruct vk-display-mode-properties-khr
  (:display-mode vk-display-mode-khr)
  (:parameter (:struct vk-display-mode-parameters-khr)))

(defcstruct vk-display-mode-properties2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:display-mode-properties (:struct vk-display-mode-properties-khr)))

(defcstruct vk-display-mode-parameters-khr
  (:visible-region (:struct vk-extent-2d))
  (:refresh-rate :uint32))

(defcstruct vk-display-mode-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-display-mode-create-flags-khr)
  (:parameters (:struct vk-display-mode-parameters-khr)))

(defcstruct vk-display-plane-capabilities-khr
  (:supported-alpha vk-display-plane-alpha-flags-khr)
  (:min-src-position (:struct vk-offset-2d))
  (:max-src-position (:struct vk-offset-2d))
  (:min-src-extent (:struct vk-extent-2d))
  (:max-src-extent (:struct vk-extent-2d))
  (:min-dst-position (:struct vk-offset-2d))
  (:max-dst-position (:struct vk-offset-2d))
  (:min-dst-extent (:struct vk-extent-2d))
  (:max-dst-extent (:struct vk-extent-2d)))

(defcstruct vk-display-plane-info2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:mode vk-display-mode-khr)
  (:plane-index :uint32))

(defcstruct vk-display-plane-capabilities2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:capability (:struct vk-display-plane-capabilities-khr)))

(defcstruct vk-display-power-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:power-state VkDisplayPowerStateEXT))

(defcstruct vk-display-surface-create-info-khr
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

(defcstruct vk-headless-surface-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-headless-surface-create-flags-ext))

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

(defcstruct vk-physical-device-surface-info2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface vk-surface-khr))

(defcstruct vk-surface-full-screen-exclusive-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:full-screen-exclusive VkFullScreenExclusiveEXT))

(defcstruct vk-surface-full-screen-exclusive-win32-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:hmonitor (:pointer :void)))

(defcstruct vk-surface-capabilities2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface-capabilities (:struct vk-surface-capabilities-khr)))

(defcstruct vk-surface-protected-capabilities-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supports-protected vk-bool-32))

(defcstruct vk-shared-present-surface-capabilities-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shared-present-supported-usage-flags vk-image-usage-flags))

(defcstruct vk-display-native-hdr-surface-capabilities-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:local-dimming-support vk-bool-32))

(defcstruct vk-surface-capabilities-full-screen-exclusive-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:full-screen-exclusive-supported vk-bool-32))

(defcstruct vk-surface-capabilities2-ext
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

(defcstruct vk-surface-format-khr
  (:format VkFormat)
  (:color-space VkColorSpaceKHR))

(defcstruct vk-surface-format2-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface-format (:struct vk-surface-format-khr)))

(defcstruct vk-device-group-present-capabilities-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:present-mask :uint32 :count 32)
  (:modes vk-device-group-present-mode-flags-khr))

(defcstruct vk-refresh-cycle-duration-google
  (:refresh-duration :uint64))

(defcstruct vk-past-presentation-timing-google
  (:present-id :uint32)
  (:desired-present-time :uint64)
  (:actual-present-time :uint64)
  (:earliest-present-time :uint64)
  (:present-margin :uint64))

(defcstruct vk-swapchain-create-info-khr
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

(defcstruct vk-device-group-swapchain-create-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:modes vk-device-group-present-mode-flags-khr))

(defcstruct vk-swapchain-display-native-hdr-create-info-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:local-dimming-enable vk-bool-32))

(defcstruct vk-swapchain-counter-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:surface-counters vk-surface-counter-flags-ext))

(defcstruct vk-acquire-next-image-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:timeout :uint64)
  (:semaphore vk-semaphore)
  (:fence vk-fence)
  (:device-mask :uint32))

(defcstruct vk-present-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphore (:pointer vk-semaphore))
  (:swapchain-count :uint32)
  (:swapchain (:pointer vk-swapchain-khr))
  (:image-indices (:pointer :uint32))
  (:result VkResult))

(defcstruct vk-present-regions-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain-count :uint32)
  (:regions (:pointer (:struct vk-present-regions-khr))))

(defcstruct vk-rect-layer-khr
  (:offset (:struct vk-offset-2d))
  (:extent (:struct vk-extent-2d))
  (:layer :uint32))

(defcstruct vk-display-present-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src-rect (:struct vk-rect-2d))
  (:dst-rect (:struct vk-rect-2d))
  (:persistent vk-bool-32))

(defcstruct vk-device-group-present-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain-count :uint32)
  (:device-mask (:pointer :uint32))
  (:mode VkDeviceGroupPresentModeFlagBitsKHR))

(defcstruct vk-present-time-google
  (:present-id :uint32)
  (:desired-present-time :uint64))

(defcstruct vk-present-times-info-google
  (:type VkStructureType)
  (:next (:pointer :void))
  (:swapchain-count :uint32)
  (:times (:pointer (:struct vk-present-time-google))))

(defcstruct vk-present-frame-token-ggp
  (:type VkStructureType)
  (:next (:pointer :void))
  (:frame-token :uint32))   ;;maybe ??

(defcstruct vk-xy-color-ext
  (:x :float)
  (:y :float))

(defcstruct vk-hdr-metadata-ext
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

(defcstruct vk-deferred-operation-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:operation-handle vk-deferred-operation-khr))

(defcstruct vk-private-data-slot-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-private-data-slot-create-flags-ext))

(defcstruct vk-strided-buffer-region-khr
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:stride vk-device-size)
  (:size vk-device-size))

(defcstruct vk-trace-rays-indirect-command-khr
  (:width :uint32)
  (:height :uint32)
  (:depth :uint32))

(defcunion vk-device-or-host-address-const-khr
  (:device-address vk-device-address)
  (:host-address (:pointer :void)))

(defcstruct vk-acceleration-structure-geometry-triangles-data-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-format VkFormat)
  (:vertex-data (:union vk-device-or-host-address-const-khr))
  (:vertex-stride vk-device-size)
  (:index-type VkIndexType)
  (:index-data (:union vk-device-or-host-address-const-khr))
  (:transform-data (:union vk-device-or-host-address-const-khr)))

(defcstruct vk-acceleration-structure-geometry-aabbs-data-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:data (:union vk-device-or-host-address-const-khr))
  (:stride vk-device-size))

(defcstruct vk-acceleration-structure-geometry-instances-data-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:array-of-pointers vk-bool-32)
  (:data (:union vk-device-or-host-address-const-khr)))

(defcunion vk-acceleration-structure-geometry-data-khr
  (:triangles (:struct vk-acceleration-structure-geometry-triangles-data-khr))
  (:aabbs (:struct vk-acceleration-structure-geometry-aabbs-data-khr))
  (:instances (:struct vk-acceleration-structure-geometry-instances-data-khr)))

(defcstruct vk-acceleration-structure-geometry-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry (:union vk-acceleration-structure-geometry-data-khr))
  (:flags vk-geometry-flags-khr))

(defcunion vk-device-or-host-address-khr
  (:device-address vk-device-address)
  (:host-address (:pointer :void)))

(defcstruct vk-acceleration-structure-build-geometry-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:update vk-bool-32)
  (:src-acceleration-structure vk-acceleration-structure-khr)
  (:dst-acceleration-structure vk-acceleration-structure-khr)
  (:geometry-array-of-pointers vk-bool-32)
  (:scratch-data (:union vk-device-or-host-address-khr)))

(defcstruct vk-transform-matrix-khr
  (:matrix :float :count 3 :count 4))

(defcstruct vk-aabb-positions-khr
  (:minx :float)
  (:miny :float)
  (:minz :float)
  (:maxx :float)
  (:maxy :float)
  (:maxz :float))

(defcstruct vk-acceleration-structure-instance-khr
  (:transform (:struct vk-transform-matrix-khr))
  (:instance-custom-index :uint32)                        ;;initialize as 24
  (:mask :uint32)                                         ;;initialize as 8
  (:instance-shader-binding-table-record-offset :uint32)  ;;initialize as 24
  (:flags vk-geometry-instance-flags-khr)                 ;;initialize as 8
  (:acceleration-structure-reference :uint64))

(defcstruct vk-acceleration-structure-build-offset-info-khr
  (:primitive-count :uint32)
  (:primitive-offset :uint32)
  (:first-vertex :uint32)
  (:transform-offset :uint32))

(defcstruct vk-copy-acceleration-structure-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src vk-acceleration-structure-khr)
  (:dst vk-acceleration-structure-khr)
  (:mode VkCopyAccelerationStructureModeKHR))

(defcstruct vk-copy-acceleration-structure-to-memory-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src vk-acceleration-structure-khr)
  (:dst (:union vk-device-or-host-address-khr))
  (:mode VkCopyAccelerationStructureModeKHR))

(defcstruct vk-copy-memory-to-acceleration-structure-info-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:src (:union vk-device-or-host-address-const-khr))
  (:dst vk-acceleration-structure-khr)
  (:mode VkCopyAccelerationStructureModeKHR))

(defcstruct vk-acceleration-structure-version-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:version-data (:pointer :uint8)))

(defcstruct vk-layer-properties
  (:layer-name :char :count 256)
  (:spec-version :uint32)
  (:implementation-version :uint32)
  (:description :char :count 256))

(defcstruct vk-extension-properties
  (:extension-name :char :count 256)
  (:spec-version :uint32))

(defcstruct vk-physical-device-features2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:feature (:struct vk-physical-device-features)))

(defcstruct vk-physical-device-vulkan11-features
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

(defcstruct vk-physical-device-vulkan12-features
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

(defcstruct vk-physical-device-variable-pointers-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:variable-pointers-storage-buffer vk-bool-32)
  (:variable-pointers vk-bool-32))

(defcstruct vk-physical-device-multiview-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:multiview vk-bool-32)
  (:multiview-geometry-shader vk-bool-32)
  (:multiview-tessellation-shader vk-bool-32))

(defcstruct vk-physical-device-shader-atomic-float-features-ext
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

(defcstruct vk-physical-device-shader-atomic-int-64-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-buffer-int-64-atomics vk-bool-32)
  (:shader-shared-int-64-atomics vk-bool-32))

(defcstruct vk-physical-device-8-bit-storage-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:storage-buffer-8-bit-access vk-bool-32)
  (:uniform-and-storage-buffer-8-bit-access vk-bool-32)
  (:storage-push-constant-8 vk-bool-32))

(defcstruct vk-physical-device-16-bit-storage-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:storage-buffer-16-bit-access vk-bool-32)
  (:uniform-and-storage-buffer-16-bit-access vk-bool-32)
  (:storage-push-constant-16 vk-bool-32))

(defcstruct vk-physical-device-shader-float-16-int-8-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-float-16 vk-bool-32)
  (:shader-int8 vk-bool-32))

(defcstruct vk-physical-device-shader-clock-features-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-subgroup-clock vk-bool-32)
  (:shader-device-clock vk-bool-32))

(defcstruct vk-physical-device-sampler-ycbcr-conversion-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sampler-ycbcr-conversion vk-bool-32))

(defcstruct vk-physical-device-protected-memory-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:protected-memory vk-bool-32))

(defcstruct vk-physical-device-blend-operation-advanced-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:advanced-blend-coherent-operations vk-bool-32))

(defcstruct vk-physical-device-conditional-rendering-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:conditional-rendering vk-bool-32)
  (:inherited-conditional-rendering vk-bool-32))

(defcstruct vk-physical-device-shader-draw-parameters-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-draw-parameters vk-bool-32))

(defcstruct vk-physical-device-mesh-shader-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:task-shader vk-bool-32)
  (:mesh-shader vk-bool-32))

(defcstruct vk-physical-device-descriptor-indexing-features
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

(defcstruct vk-physical-device-vertex-attribute-divisor-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vertex-attribute-instance-rate-divisor vk-bool-32)
  (:vertex-attribute-instance-rate-zero-divisor vk-bool-32))

(defcstruct vk-physical-device-a-s-t-c-decode-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:decode-mode-shared-exponent vk-bool-32))

(defcstruct vk-physical-device-transform-feedback-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:transform-feedback vk-bool-32)
  (:geometry-streams vk-bool-32))

(defcstruct vk-physical-device-vulkan-memory-model-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:vulkan-memory-model vk-bool-32)
  (:vulkan-memory-model-device-scope vk-bool-32)
  (:vulkan-memory-model-availability-visibility-chains vk-bool-32))

(defcstruct vk-physical-device-inline-uniform-block-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:inline-uniform-block vk-bool-32)
  (:descriptor-binding-inline-uniform-block-update-after-bind vk-bool-32))

(defcstruct vk-physical-device-representative-fragment-test-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:representative-fragment-test vk-bool-32))

(defcstruct vk-physical-device-exclusive-scissor-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:exclusive-scissor vk-bool-32))

(defcstruct vk-physical-device-corner-sampled-image-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:corner-sampled-image vk-bool-32))

(defcstruct vk-physical-device-compute-shader-derivatives-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:compute-derivative-group-quads vk-bool-32)
  (:compute-derivative-group-linear vk-bool-32))

(defcstruct vk-physical-device-fragment-shader-barycentric-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-shader-barycentric vk-bool-32))

(defcstruct vk-physical-device-shader-image-footprint-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imaeg-footprint vk-bool-32))

(defcstruct vk-physical-device-shading-rate-image-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shading-rate-image vk-bool-32)
  (:shading-rate-coarse-sample-order vk-bool-32))

(defcstruct vk-physical-device-fragment-density-map-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-density-map vk-bool-32)
  (:fragment-density-map-dynamic vk-bool-32)
  (:fragment-density-map-non-subsampled-images vk-bool-32))

(defcstruct vk-physical-device-fragment-density-map2-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-density-map-deferred vk-bool-32))

(defcstruct vk-physical-device-scalar-block-layout-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:scalar-block-layout vk-bool-32))

(defcstruct vk-physical-device-uniform-buffer-standard-layout-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:uniform-buffer-standard-layout vk-bool-32))

(defcstruct vk-physical-device-depth-clip-enable-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:depth-clip-enable vk-bool-32))

(defcstruct vk-physical-device-memory-priority-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:memory-prioryity vk-bool-32))

(defcstruct vk-physical-device-buffer-device-address-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer-device-address vk-bool-32)
  (:buffer-device-address-capture-replay vk-bool-32)
  (:buffer-device-address-multi-device vk-bool-32))

(defcstruct vk-physical-device-buffer-device-address-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:buffer-device-address vk-bool-32)
  (:buffer-device-address-capture-replay vk-bool-32)
  (:buffer-device-address-multi-device vk-bool-32))

(defcstruct vk-physical-device-dedicated-allocation-image-aliasing-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:dedicated-allocation-image-aliasing vk-bool-32))

(defcstruct vk-physical-device-imageless-framebuffer-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:imageless-framebuffer vk-bool-32))

(defcstruct vk-physical-device-fragment-shader-interlock-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:fragment-shader-sample-interlock vk-bool-32)
  (:fragment-shader-pixel-interlock vk-bool-32)
  (:fragment-shader-shading-rate-interlock vk-bool-32))

(defcstruct vk-physical-device-cooperative-matrix-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:cooperative-matrix vk-bool-32)
  (:cooperative-matrix-robust-buffer-access vk-bool-32))

(defcstruct vk-physical-device-ycbcr-image-arrays-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:ycbcr-image-arrays vk-bool-32))

(defcstruct vk-physical-device-shader-subgroup-extended-types-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-subgroup-extended-types vk-bool-32))

(defcstruct vk-physical-device-host-query-reset-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:host-query-reset vk-bool-32))

(defcstruct vk-physical-device-shader-integer-functions2-features-intel
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-integer-functions2 vk-bool-32))

(defcstruct vk-physical-device-coverage-reduction-mode-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:coverage-reduction-mode vk-bool-32))

(defcstruct vk-physical-device-timeline-semaphore-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:timeline-semaphore vk-bool-32))

(defcstruct vk-physical-device-index-type-uint8-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:index-type-uint8 vk-bool-32))

(defcstruct vk-physical-device-shader-sm-builtins-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-sm-builtins vk-bool-32))

(defcstruct vk-physical-device-separate-depth-stencil-layouts-features
  (:type VkStructureType)
  (:next (:pointer :void))
  (:separate-depth-stencil-layouts vk-bool-32))

(defcstruct vk-physical-device-pipeline-executable-properties-features-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-executable-info vk-bool-32))

(defcstruct vk-physical-device-shader-demote-to-helper-invocation-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-demote-to-helper-invocation vk-bool-32))

(defcstruct vk-physical-device-texel-buffer-alignment-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:texel-buffer-alignment vk-bool-32))

(defcstruct vk-physical-device-texture-compression-astchdr-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:texture-compression-astc-hdr vk-bool-32))

(defcstruct vk-physical-device-line-rasterization-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:rectangular-lines vk-bool-32)
  (:bresenham-lines vk-bool-32)
  (:smooth-lines vk-bool-32)
  (:stippled-rectangular-lines vk-bool-32)
  (:stippled-bresenham-lines vk-bool-32)
  (:stippled-smooth-lines vk-bool-32))

(defcstruct vk-physical-device-subgroup-size-control-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subgroup-size-control vk-bool-32)
  (:compute-full-subgroups vk-bool-32))

(defcstruct vk-physical-device-coherent-memory-features-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-coherent-memory vk-bool-32))

(defcstruct vk-physical-device-ray-tracing-features-khr
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

(defcstruct vk-physical-device-extended-dynamic-state-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:extended-dynamic-state vk-bool-32))

(defcstruct vk-physical-device-device-generated-commands-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:device-generated-commands vk-bool-32))

(defcstruct vk-physical-device-diagnostics-config-features-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:diagnostics-config vk-bool-32))

(defcstruct vk-physical-device-pipeline-creation-cache-control-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:pipeline-creation-cache-control vk-bool-32))

(defcstruct vk-physical-device-private-data-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:private-data vk-bool-32))

(defcstruct vk-physical-device-robustness2-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:robust-buffer-access2 vk-bool-32)
  (:robust-image-access2 vk-bool-32)
  (:null-descriptor vk-bool-32))

(defcstruct vk-physical-device-image-robustness-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:robust-image-access vk-bool-32))

(defcstruct vk-physical-device-custom-border-color-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:custom-border-colors vk-bool-32)
  (:custom-border-color-without-format vk-bool-32))

(defcstruct vk-physical-device-performance-query-features-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:performance-counter-query-pools vk-bool-32)
  (:performance-counter-multiple-query-pools vk-bool-32))

(defcstruct vk-physical-device-4444-formats-features-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format-a4-r4-g4-b4 vk-bool-32)
  (:format-a4-b4-g4-r4 vk-bool-32))

(defcstruct vk-physical-device-push-descriptor-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-push-descriptors :uint32))

(defcstruct vk-physical-device-multiview-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-multiview-view-count :uint32)
  (:max-multiview-instance-index :uint32))

(defcstruct vk-physical-device-float-controls-properties
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

(defcstruct vk-physical-device-discard-rectangle-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-discard-rectangles :uint32))

(defcstruct vk-physical-device-sample-locations-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:sample-location-sample-counts vk-sample-count-flags)
  (:max-sample-location-grid-size (:struct vk-extent-2d))
  (:sample-location-coordinate-range :float :count 2)
  (:sample-location-sub-pixel-bits :uint32)
  (:variable-sample-locations vk-bool-32))

(defcstruct vk-physical-device-external-memory-host-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:min-imported-host-pointer-alignment vk-device-size))

(defcstruct vk-physical-device-multiview-per-view-attributes-properties-nvx
  (:type VkStructureType)
  (:next (:pointer :void))
  (:per-view-position-all-components vk-bool-32))

(defcstruct vk-physical-device-point-clipping-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:point-clipping-behavior VkPointClippingBehavior))

(defcstruct vk-physical-device-subgroup-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subgroup-size :uint32)
  (:supported-stages vk-shader-stage-flags)
  (:supported-operations vk-subgroup-feature-flags)
  (:quad-operations-in-all-stages vk-bool-32))

(defcstruct vk-physical-device-subgroup-size-control-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:min-subgroup-size :uint32)
  (:max-subgroup-size :uint32)
  (:max-compute-workgroup-subgroups :uint32)
  (:required-subgroup-size-stages vk-shader-stage-flags))

(defcstruct vk-physical-device-blend-operation-advanced-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:advanced-blend-max-color-attachments :uint32)
  (:advanced-blend-independent-blend vk-bool-32)
  (:advanced-blend-non-premultiplied-src-color vk-bool-32)
  (:advanced-blend-non-premultiplied-dst-color vk-bool-32)
  (:advanced-blend-correlated-overlap vk-bool-32)
  (:advanced-blend-all-operations vk-bool-32))

(defcstruct vk-physical-device-vertex-attribute-divisor-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-vertex-attrib-divisor :uint32))

(defcstruct vk-physical-device-sampler-filter-minmax-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:filter-minmax-single-component-formats vk-bool-32)
  (:filter-minmax-image-component-mapping vk-bool-32))

(defcstruct vk-physical-device-protected-memory-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:protected-no-fault vk-bool-32))

(defcstruct vk-physical-device-maintenance3-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-per-set-descriptors :uint32)
  (:max-memory-allocation-size vk-device-size))

(defcstruct vk-physical-device-mesh-shader-properties-nv
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

(defcstruct vk-physical-device-descriptor-indexing-properties
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

(defcstruct vk-physical-device-inline-uniform-block-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-inline-uniform-block-size :uint32)
  (:max-per-stage-descriptor-inline-uniform-blocks :uint32)
  (:max-per-stage-descriptor-update-after-bind-inline-uniform-blocks :uint32)
  (:max-descriptor-set-inline-uniform-blocks :uint32)
  (:max-descriptor-set-update-after-bind-inline-uniformq-blocks :uint32))

(defcstruct vk-physical-device-conservative-rasterization-properties-ext
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

(defcstruct vk-physical-device-fragment-density-map-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:min-fragment-density-texel-size (:struct vk-extent-2d))
  (:max-fragment-density-texel-size (:struct vk-extent-2d))
  (:fragment-density-invocations vk-bool-32))

(defcstruct vk-physical-device-fragment-density-map2-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:subsampled-loads vk-bool-32)
  (:subsampled-coarse-reconstruction-early-access vk-bool-32)
  (:max-subsampled-array-layers :uint32)
  (:max-descriptor-set-subsampled-samplers :uint32))

(defcstruct vk-physical-device-shader-core-properties-amd
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

(defcstruct vk-physical-device-shader-core-properties2-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-core-features vk-shader-core-properties-flags-amd)
  (:active-compute-unit-count :uint32))

(defcstruct vk-physical-device-depth-stencil-resolve-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supported-depth-resolve-modes vk-reslove-mode-flags)
  (:supported-stencil-resolve-modes vk-reslove-mode-flags)
  (:independent-resolve-none vk-bool-32)
  (:independent-resolve vk-bool-32))

(defcstruct vk-physical-device-performance-query-properties-khr
  (:type VkStructureType)
  (:next (:pointer :void))
  (:allow-command-buffer-query-copies vk-bool-32))

(defcstruct vk-physical-device-shading-rate-image-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shading-rate-texel-size (:struct vk-extent-2d))
  (:shading-rate-palette-size :uint32)
  (:shading-rate-max-coarse-samples :uint32))

(defcstruct vk-physical-device-transform-feedback-properties-ext
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

(defcstruct vk-physical-device-ray-tracing-properties-nv
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

(defcstruct vk-physical-device-ray-tracing-properties-khr
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

(defcstruct vk-physical-device-cooperative-matrix-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:cooperative-matrix-supported-stages vk-shader-stage-flags))

(defcstruct vk-physical-device-shader-sm-builtins-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:shader-sm-count :uint32)
  (:shader-warps-persm :uint32))

(defcstruct vk-physical-device-texel-buffer-alignment-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:storage-texel-buffer-offset-alignment-bytes vk-device-size)
  (:storage-texel-buffer-offset-single-texel-alignment vk-bool-32)
  (:uniform-texel-buffer-offset-alignment-bytes vk-device-size)
  (:uniform-texel-buffer-offset-single-texel-alignment vk-bool-32))

(defcstruct vk-physical-device-timeline-semaphore-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-timeline-semaphore-value-difference :uint64))

(defcstruct vk-physical-device-line-rasterization-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:line-sub-pixel-precision-bits :uint32))

(defcstruct vk-physical-device-robustness2-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:robust-storage-buffer-access-size-alignment vk-device-size)
  (:robust-uniform-buffer-access-size-alignment vk-device-size))

(defcstruct vk-physical-device-device-generated-commands-properties-nv
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

(defcstruct vk-multisample-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-sample-location-grid-size (:struct vk-extent-2d)))

(defcstruct vk-physical-device-custom-border-color-properties-ext 
  (:type VkStructureType)
  (:next (:pointer :void))
  (:max-custom-border-color-samplers :uint32))

(defcstruct vk-format-properties
  (:linear-tiling-features vk-format-feature-flags)
  (:optimal-tiling-features vk-format-feature-flags)
  (:buffer-features vk-format-feature-flags))

(defcstruct vk-format-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:format-properties (:struct vk-format-properties)))

(defcstruct vk-drm-format-modifier-properties-ext
  (:drm-format-modifier :uint64)
  (:drm-format-modifier-plane-count :uint32)
  (:drm-format-modifier-tiling-features vk-format-feature-flags))

(defcstruct vk-drm-format-modifier-properties-list-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier-count :uint32)
  (:drm-format-modifier-properties (:pointer (:struct vk-drm-format-modifier-properties-ext))))

(defcstruct vk-image-format-properties
  (:max-extent (:struct vk-extent-3d))
  (:max-mip-levels :uint32)
  (:max-array-layers :uint32)
  (:sample-count vk-sample-count-flags)
  (:max-resource-size vk-device-size))

(defcstruct vk-external-image-format-properties-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-format-properties (:struct vk-image-format-properties))
  (:external-memory-features vk-external-memory-feature-flags-nv)
  (:export-from-imported-handle-types vk-external-memory-handle-type-flags)
  (:compatible-handle-types vk-external-memory-handle-type-flags))

(defcstruct vk-physical-device-image-format-info2 
  (:type VkStructureType)
  (:next (:pointer :void))
  (:foramt VkFormat)
  (:type VkImageType)
  (:tiling VkImageTiling)
  (:usage vk-image-usage-flags)
  (:flags vk-image-create-flags))

(defcstruct vk-image-format-properties2
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-format-properties (:struct vk-image-format-properties)))

(defcstruct vk-texture-lod-gather-format-properties-amd
  (:type VkStructureType)
  (:next (:pointer :void))
  (:supports-texture-gather-lod-bias-amd vk-bool-32))

(defcstruct vk-physical-device-external-image-format-info 
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defcstruct vk-external-memory-properties
  (:external-memory-features vk-external-memory-feature-flags)
  (:export-from-imported-handle-types vk-external-memory-handle-type-flags)
  (:compatible-handle-types vk-external-memory-handle-type-flags))

(defcstruct vk-external-image-format-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:external-memory-properties (:struct vk-external-memory-properties)))

(defcstruct vk-physical-device-image-drm-format-modifier-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:drm-format-modifier :uint64)
  (:sharing-mode VkSharingMode)
  (:queue-family-index-count :uint32)
  (:queue-family-indices (:pointer :uint32)))

(defcstruct vk-sampler-ycbcr-conversion-image-format-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:combined-image-sampler-descriptor-count :uint32))

(defcstruct vk-android-hardware-buffer-usage-android
  (:type VkStructureType)
  (:next (:pointer :void))
  (:android-hardware-buffer-usage :uint64))

(defcstruct vk-physical-device-image-view-image-format-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:image-view-type VkImageViewType))

(defcstruct vk-filter-cubic-image-view-image-format-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:filter-cubic vk-bool-32)
  (:filter-cubic-minmax vk-bool-32))

(defcstruct vk-physical-device-external-buffer-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-buffer-create-flags)
  (:usage vk-buffer-usage-flags)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defcstruct vk-external-buffer-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:external-memory-properties (:struct vk-external-memory-properties)))

(defcstruct vk-physical-device-external-semaphore-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits))

(defcstruct vk-external-semaphore-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:export-from-imported-handle-types vk-external-semaphore-handle-type-flags)
  (:compatible-handle-types vk-external-semaphore-handle-type-flags)
  (:external-semaphore-features vk-external-semaphore-feature-flags))

(defcstruct vk-physical-device-external-fence-info
  (:type VkStructureType)
  (:next (:pointer :void))
  (:handle-type VkExternalFenceHandleTypeFlagBits))

(defcstruct vk-external-fence-properties
  (:type VkStructureType)
  (:next (:pointer :void))
  (:export-from-imported-handle-types vk-external-fence-handle-type-flags)
  (:compatible-handle-types vk-external-fence-handle-type-flags)
  (:external-fence-features vk-external-fence-feature-flags))

(defcstruct vk-debug-utils-object-name-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkObjectType)
  (:object-handle :uint64)
  (:object-name (:pointer :char)))

(defcstruct vk-debug-utils-object-tag-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkObjectType)
  (:object-handle :uint64)
  (:tag-name :uint64)
  (:tag-size size-t)
  (:tag (:pointer :void)))

(defcstruct vk-debug-utils-label-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:label-name (:pointer :char))
  (:color :float :count 4))

(defcstruct vk-debug-utils-messenger-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-debug-utils-messenger-create-flags-ext)
  (:message-severity vk-debug-utils-message-severity-flags-ext)
  (:message-type vk-debug-utils-message-type-flags-ext)
  (:pfn-user-callback pfn-vk-debug-utils-messenger-callback-ext)
  (:user-data (:pointer :void)))

(defcstruct vk-debug-utils-messenger-callback-data-ext
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

(defcstruct vk-debug-marker-object-name-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkDebugReportObjectTypeEXT)
  (:object :uint64)
  (:object-name (:pointer :char)))

(defcstruct vk-debug-marker-object-tag-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:object-type VkDebugReportObjectTypeEXT)
  (:object :uint64)
  (:tag-name :uint64)
  (:tag-size size-t)
  (:tag (:pointer :void)))

(defcstruct vk-debug-marker-marker-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:mark-name (:pointer :char))
  (:color :float :count 4))

(defcstruct vk-debug-report-callback-create-info-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags vk-debug-report-flags-ext)
  (:pfn-callback pfn-vk-debug-report-callback-ext)
  (:user-data (:pointer :void)))

(defcstruct vk-checkpoint-data-nv
  (:type VkStructureType)
  (:next (:pointer :void))
  (:stage VkPipelineStageFlagBits)
  (:checkpoint-marker (:pointer :void)))

(defcstruct vk-physical-device-tool-properties-ext
  (:type VkStructureType)
  (:next (:pointer :void))
  (:name :char :count 256)
  (:version :char :count 256)
  (:purpose vk-tool-purpose-flags-ext)
  (:description :char :count 256)
  (:layers :char :count 256))
