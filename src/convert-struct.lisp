(in-package :vkvk)

(export '(create-device-queues
	  lsp-offset-2d
	  lsp-offset-3d
	  lsp-extent-2d
	  lsp-extent-3d
	  lsp-component-mapping
	  lsp-image-subresource-range
	  lsp-push-constant-range))

(defun check-foreign-enum-type (type val)
  (member val (foreign-enum-keyword-list type)))

(deftype foreign-enum-type (type)
  (let ((check (gensym)))
    (setf (symbol-function check)
	  #'(lambda (val)
	      (check-foreign-enum-type type val)))
    `(satisfies ,check)))

(defun check-foreign-pointer (val)
  (pointerp val))

(deftype foreign-pointer ()
  `(satisfies check-foreign-pointer))

;;special 
(defstruct lsp-device-queue-create-info
  (type :structure-type-device-queue-create-info)
  (next *vk-nullptr*)
  (flag 0 :type integer)
  (queue-family-index 0 :type integer)
  (queue-count 0 :type integer)
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

(defstruct lsp-component-mapping
  (r :component-swizzle-identity)
  (g :component-swizzle-identity)
  (b :component-swizzle-identity)
  (a :component-swizzle-identity))

(defstruct lsp-image-subresource-range
  (aspect-mask :image-aspect-color-bit)
  (base-mip-level 0 :type integer)
  (level-count 1 :type integer)
  (base-array-layer 0 :type integer)
  (layer-count 1 :type integer))

(defstruct vk-viewport
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
  (map-entrys *vk-nullptr*)
  (data-size 0 :type integer)
  (data *vk-nullptr*))
