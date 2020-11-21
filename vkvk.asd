(defsystem "vkvk"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:cffi :alexandria)
  :serial t
  :components ((:file "src/package")
	       (:file "src/enum")
	       (:file "src/foreign-type")
	       (:file "src/function")
	       (:file "src/struct")
	       (:file "src/convert")
	       (:file "src/instance")
	       (:file "src/gpu")
	       (:file "src/device")
	       (:file "src/surface")
	       (:file "src/pipeline")
	       (:file "src/cmd")
	       (:file "src/memory")
	       (:file "src/resource")))

