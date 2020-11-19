(defsystem "vkvk"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:cffi)
  :serial t
  :components ((:file "src/package")
	       (:file "src/enum")
	       (:file "src/foreign-type")
	       (:file "src/function")
	       (:file "src/struct")
	       (:file "src/convert")
	       (:file "src/instance/instance")
	       (:file "src/gpu/gpu")
	       (:file "src/device/device")
	       (:file "src/surface/surface")
	       (:file "src/pipeline/pipeline")
	       (:file "src/cmd/cmd")
	       (:file "src/memory/memory")
	       (:file "src/resource/resource")))

