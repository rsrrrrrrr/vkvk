(in-package :vkvk)

(export '(create-device-queues))

(defstruct lsp-device-queue-create-info
  (type :structure-type-device-queue-create-info)
  (next *vk-nullptr*)
  (flag 0)
  (queue-family-index 0)
  (queue-count 0)
  (queue-properties *vk-nullptr*))

(defun create-device-queues (&key
			       (flag 0)
			       (next *vk-nullptr*)
			       (queue-family-index 0)
			       (queue-count 0)
			       (queue-properties *vk-nullptr*))
  (make-lsp-device-queue-create-info :flag flag
				     :next next
				     :queue-family-index queue-family-index
				     :queue-count queue-count
				     :queue-properties queue-properties))

(defstruct lsp-offset-2d
  (x 0)
  (y 0))

(defstruct lsp-offset-3d
  (x 0)
  (y 0)
  (z 0))

(defstruct lsp-extent-2d
  (width 0)
  (height 0))

(defstruct lsp-extent-3d
  (width 0)
  (height 0)
  (depth 0))

(defstruct lsp-component-mapping
  (r :component-swizzle-identity)
  (g :component-swizzle-identity)
  (b :component-swizzle-identity)
  (a :component-swizzle-identity))

(defstruct lsp-image-subresource-range
  (aspect-mask :image-aspect-color-bit)
  (base-mip-level 0)
  (level-count 1)
  (base-array-layer 0)
  (layer-count 1))
