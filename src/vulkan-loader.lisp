(in-package :vkvk)

(define-foreign-library vulkan-loader
  (:darwin "libvulkan.1.dylib")
  (:windows "vulkan-1.dll")
  (:unix (:or "libvulkan.so")))

(use-foreign-library vulkan-loader)
