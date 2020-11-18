(in-package :vkvk)

(defun check-foreign-enum-type (type val)
  (member val (foreign-enum-keyword-list type)))

(deftype foreign-enum-type (type)
  (let ((check (gensym)))
    (setf (symbol-function check)
	  #'(lambda (val)
	      (check-foreign-enum-type type val)))
    `(satisfies ,check)))

(defun check-vk-bool-type (val)
  `(or (= ,val 0)
       (= ,val 1)))

(deftype vk-bool ()
  `(satisfies check-vk-bool-type))

(defun check-foreign-pointer (val)
  (pointerp val))

(deftype foreign-pointer ()
  `(satisfies check-foreign-pointer))

(defun check-uint8 (val)
  `(and (>= ,val 0)
	(<= ,val (ash 1 8))))

(defun check-uint16 (val)
  `(and (>= ,val 0)
	(<= ,val (ash 1 16))))

(defun check-uint32 (val)
  `(and (>= ,val 0)
	(<= ,val (ash 1 32))))

(defun check-uint64 (val)
  `(and (>= ,val 0)
	(<= ,val (ash 1 64))))

#.(if (= 8 (foreign-type-size :pointer))
      `(deftype non-dispatch-handle () `(satisfies check-foreign-pointer))
      `(deftype non-dispatch-handle () `(satisfies check-uint64)))

(defun check-struct-type-enum (val)
  `(typep ,val (foreign-enum-type vkstructuretype)))
(deftype vk-struct-type-enum ()
  `(satisfies check-struct-type-enum))

(defun check-componemt-swizzle-enum (val)
  `(typep ,val (foreign-enum-type vkcomponentswizzle)))
(deftype vk-componemt-swizzle-enum ()
  `(satisfies check-componemt-swizzle-enum))

(defun check-stencil-op-enum (val)
  `(typep ,val (foreign-enum-type vkstencilop)))
(deftype vk-stencil-op-enum ()
  `(satisfies check-stencil-op-enum))

(defun check-compare-op-enum (val)
  `(typep ,val (foreign-enum-type vkcompareop)))
(deftype vk-compare-op-enum ()
  `(satisfies check-compare-op-enum))

(defun check-blend-factor-enum (val)
  `(typep ,val (foreign-enum-type vkblendfactor)))
(deftype vk-blend-factor-enum ()
  `(satisfies check-blend-factor-enum))

(defun check-blend-op-enum (val)
  `(typep ,val (foreign-enum-type vkblendop)))
(deftype vk-blend-op-enum ()
  `(satisfies check-blend-op-enum))

(defun check-vertex-input-rate-enum (val)
  `(typep ,val (foreign-enum-type vkvertexinputrate)))
(deftype vk-vertex-input-rate-enum ()
  `(satisfies check-vertex-input-rate))

(defun check-format-enum (val)
  `(typep ,val (foreign-enum-type vkformat)))
(deftype vk-format-enum ()
  `(satisfies check-format-enum))

(defun check-dynamic-state (val)
  `(typep ,val (foreign-enum-type VkDynamicState)))
(deftype vk-dynamic-state-enum ()
  `(satisfies check-dynamic-state))
