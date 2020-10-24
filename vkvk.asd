(defsystem "vkvk"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "vkvk/tests"))))

(defsystem "vkvk/tests"
  :author ""
  :license ""
  :depends-on ("vkvk"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for vkvk"
  :perform (test-op (op c) (symbol-call :rove :run c)))
