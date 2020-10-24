(defpackage vkvk/tests/main
  (:use :cl
        :vkvk
        :rove))
(in-package :vkvk/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :vkvk)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
