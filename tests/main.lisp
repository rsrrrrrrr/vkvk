(defpackage vkvk/tests/main
  (:use :cl
        :vkvk
	:cl-glfw3))
(in-package :vkvk/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :vkvk)' in your Lisp.




(defparameter *keys-pressed* nil)
(defparameter *buttons-pressed* nil)
(defparameter *window-size* nil)

(defun update-window-title (window)
  (set-window-title (format nil "size ~A | keys ~A | buttons ~A"
                            *window-size*
                            *keys-pressed*
                            *buttons-pressed*)
                    window))

(def-key-callback key-callback (window key scancode action mod-keys)
  (declare (ignore scancode mod-keys))
  (when (and (eq key :escape) (eq action :press))
    (set-window-should-close))
  (if (eq action :press)
    (pushnew key *keys-pressed*))
  (update-window-title window))

(def-mouse-button-callback mouse-callback (window button action mod-keys)
  (declare (ignore mod-keys))
  (if (eq action :press)
    (pushnew button *buttons-pressed*))
  (update-window-title window))

(def-window-size-callback window-size-callback (window w h)
  (setf *window-size* (list w h))
  (update-window-title window))

(defparameter *vulkan-handle* nil)

(defun insert-to-handle (key val)
  (setf (getf *vulkan-handle* key) val))

(defun get-handle (key)
  (getf *vulkan-handle* key))

(defun setup-vulkan ()
  (format t "~a ~%" (get-instance-layers))
  (insert-to-handle :instance (create-instance :info-lays '("VK_LAYER_NV_optimus")
					       :info-exts (get-instance-extensions)
					       ))
  (insert-to-handle :gpus (enumerate-physical-device (get-handle :instance)))
  (insert-to-handle :gpu (first (get-handle :gpus)))
  (insert-to-handle :gpu-properties (get-physical-device-properties (get-handle :gpu)))
  (insert-to-handle :queue-properties (get-physical-device-queue-family-properties (get-handle :gpu)))
  (insert-to-handle :memory-properties (get-physical-device-memory-properties (get-handle :gpu)))
  (format t "~a~%" (get-handle :memory-properties)))

(defun clean-up ()
  (destroy-instance (get-handle :instance)))

(defun events-example ()
  ;; Graphics calls on OS X must occur in the main thread
  (with-init-window (:title "" :width 400 :height 400 :resizable t :client-api :no-gl-api)
    (set-key-callback 'key-callback)
    (set-mouse-button-callback 'mouse-callback)
    (set-window-size-callback 'window-size-callback)
    (setf *window-size* (get-window-size))
    (update-window-title *window*)
    (setup-vulkan)
    (loop until (window-should-close-p) do (wait-events))
    (clean-up)))
