(defsystem "vkvk"
  :version "0.1.0"
  :author "yjc18915568435@gmail.com"
  :license ""
  :depends-on (:cffi)
  :serial t
  :components ((:file "src/package")
	       (:file "src/vulkan-loader")))

