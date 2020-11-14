(in-package :vkvk)

(export '(make-lsp-device-queue-create-info
	  make-lsp-offset-2d
	  make-lsp-offset-3d
	  make-lsp-extent-2d
	  make-lsp-extent-3d
	  make-lsp-image-subresource-range
	  make-lsp-viewport
	  make-lsp-push-constant-range
	  make-lsp-specialization-map-entry
	  make-lsp-specialization-info))

;;special 
(defstruct lsp-device-queue-create-info
  (type :structure-type-device-queue-create-info :type vk-struct-type-enum :read-only t)
  (next *vk-nullptr* :type foreign-pointer)
  (flag 0 :type integer)
  (queue-family-index 0 :type integer)
  (queue-count 0 :type integer)
  (queue-properties 1.0 :type float))

(defstruct lsp-offset-2d
  (x 0 :type integer)
  (y 0 :type integer))

(defstruct lsp-offset-3d
  (x 0 :type integer)
  (y 0 :type integer)
  (z 0 :type integer))

(defstruct lsp-extent-2d
  (width 0 :type integer)
  (height 0 :type integer))

(defstruct lsp-extent-3d
  (width 0 :type integer)
  (height 0 :type integer)
  (depth 0 :type integer))

(defstruct lsp-rect-2d
  (offset (make-lsp-offset-2d) :type lsp-offset-2d)
  (extent (make-lsp-extent-2d) :type lsp-extent-2d))

(defstruct lsp-component-mapping
  (r :component-swizzle-identity :type vk-componemt-swizzle-enum)
  (g :component-swizzle-identity :type vk-componemt-swizzle-enum)
  (b :component-swizzle-identity :type vk-componemt-swizzle-enum)
  (a :component-swizzle-identity :type vk-componemt-swizzle-enum))

(defstruct lsp-image-subresource-range
  (aspect-mask :image-aspect-color-bit)
  (base-mip-level 0 :type integer)
  (level-count 1 :type integer)
  (base-array-layer 0 :type integer)
  (layer-count 1 :type integer))

(defstruct lsp-viewport
  (x 0.0 :type float)
  (y 0.0 :type float)
  (width 0.0 :type float)
  (height 0.0 :type float)
  (min-depth 0.0 :type float)
  (max-depth 0.0 :type float))

(defstruct lsp-push-constant-range
  (stage-flags 0 :type integer)
  (offset 0 :type integer)
  (size 0 :type integer))

(defstruct lsp-specialization-map-entry
  (constant-id 0 :type integer)
  (offset 0 :type integer)
  (size 0 :type integer))

(defstruct lsp-specialization-info
  (map-entry-count 0 :type integer)
  (map-entrys *vk-nullptr* :type foreign-pointer)
  (data-size 0 :type integer)
  (data *vk-nullptr* :type foreign-pointer))

(defstruct lsp-stencil-op-state
  (fail-op :stencil-op-keep :type vk-stencil-op-enum)
  (pass-op :stencil-op-keep :type vk-stencil-op-enum)
  (depth-fail-op :stencil-op-keep :type vk-stencil-op-enum)
  (compare-op :compare-op-always :type vk-compare-op-enum)
  (compare-mask 0 :type integer)
  (write-mask 0 :type integer)
  (references 0 :type integer))

(defstruct lsp-pipeline-color-blend-attachment-state
  (blend-enable 0 :type vk-bool)
  (src-color-blend-factor :blend-factor-zero :type vk-blend-factor-enum)
  (dst-color-blend-factor :blend-factor-zero :type vk-blend-factor-enum)
  (color-blend-op :blend-op-add :type vk-blend-op-enum)
  (src-alpha-blend-factor :blend-factor-zero :type vk-blend-factor-enum)
  (dst-alpha-blend-factor :blend-factor-zero :type vk-blend-factor-enum)
  (alpha-blend-op :blend-op-add :type vk-blend-op-enum)
  (color-write-mask 0))

(defstruct lsp-vertex-input-binding-description
  (binding 0 :type integer)
  (stride 0 :type integer)
  (input-rage :vertex-input-rate-instance :type vk-vertex-input-rate-enum))

(defstruct lsp-vertex-input-attribute-description
  (location 0 :type integer)
  (binding 0 :type integer)
  (format :format-r8g8b8a8-srgb :type vk-format-enum)
  (offset 0 :type integer))
