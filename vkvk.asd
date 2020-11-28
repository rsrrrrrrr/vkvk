(defsystem "vkvk"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on (:cffi :alexandria)
  :serial t
  :components ((:file "src/package")
	       (:file "src/enum")
	       (:file "src/foreign-type")
	       (:file "src/struct")
	       (:file "src/function")
	       (:file "src/translator")
	       (:file "src/cmd")))

