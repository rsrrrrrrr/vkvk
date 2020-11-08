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

(defun select-format-and-color-space (a-lst)
  (labels ((select (lst)
	     (cond ((null lst) nil)
		   ((and (eql (vkvk-slot lst 'format) :format-b8g8r8a8-srgb)
			 (eql (vkvk-slot lst 'color-space) :color-space-srgb-nonlinear-khr))
		    lst)
		   (t (select (rest lst))))))
    (let ((result (select a-lst))
	  (default (first a-lst)))
      (if (null result)
	  default
	  result))))

(defun select-present-mode (lst)
  (cond ((null lst) :present-mode-fifo-khr)
	((eql (first lst) :present-mode-mailbox-khr) (first lst))
	(t (select-present-mode (rest lst)))))

(defun show-info ()
  (format t "gpu properties: ~%~4t~{~4t~a~%~}~%" (get-handle :gpu-properties))
  (format t "queue family properties: ~%~4t~{~4t~a~%~}~%" (get-handle :queue-family-properties))
  (format t "gpu memory info: ~%~4t~{~4t~a~%~}~%" (get-handle :gpu-memory-info))
  (format t "gpu r4g4 unorm pack8 format info: ~%~4t~a~%" (get-handle :gpu-format-properties))
  (format t "surface capabilities: ~%~4t~{~4t~a~%~}" (get-handle :surface-cap))
  (format t "surface format: ~%~4t~{~4t~a~%~}" (get-handle :surface-format))
  (format t "surface present mode: ~%~4t~{~4t~a~%~}" (get-handle :surface-present-mode))
  (format t "select format : ~%~4t~a~%" (select-format-and-color-space (get-handle :surface-format)))
  (format t "select present mode : ~%~4t~a~%" (select-present-mode (get-handle :surface-present-mode)))
  (format t "select format :~%~4t~a~%" (vkvk-slot (select-format-and-color-space (get-handle :surface-format))
						  'format))
  (when (equal (first (second (select-format-and-color-space (get-handle :surface-format))))
	       'color-space)
    (format t "select color-space" )))

(defun setup-vulkan ()
  (insert-to-handle :instance (create-instance :info-exts (get-instance-extensions)
					       :info-lays '("VK_LAYER_KHRONOS_validation")
					       :dbg t))
  (insert-to-handle :gpus (enumerate-physical-device (get-handle :instance)))
  (insert-to-handle :gpu (first (get-handle :gpus)))
  (insert-to-handle :gpu-properties (get-physical-device-properties (get-handle :gpu)))
  (insert-to-handle :queue-family-properties (get-physical-device-queue-family-properties (get-handle :gpu)))
  (insert-to-handle :gpu-memory-info (get-physical-device-memory-properties (get-handle :gpu)))
  (insert-to-handle :gpu-features (get-physical-device-features (get-handle :gpu)))
  (insert-to-handle :gpu-format-properties (get-physical-device-format-properties (get-handle :gpu)
										  :format-r4g4-unorm-pack8))
  (insert-to-handle :graphics-queue-index (select-queue (get-handle :gpu)
							:queue-graphics-bit))
  (insert-to-handle :present-queue-index (get-present-queues (get-handle :instance)
							     (get-handle :gpu)))
  (let ((queue (intersection (get-handle :graphics-queue-index)
			     (get-handle :present-queue-index))))
    (if (null queue)
	(progn
	  (insert-to-handle :graphics-queue-index (first (get-handle :graphics-queue-index)))
	  (insert-to-handle :present-queue-index (first (get-handle :present-queue-index))))
	(progn
	  (insert-to-handle :graphics-queue-index (first queue))
	  (insert-to-handle :present-queue-index (first queue)))))
  (insert-to-handle :device (create-device (get-handle :gpu)
					   :info-exts '("VK_KHR_swapchain")
					   :info-queues (list
							 (create-device-queues :queue-family-index (get-handle :graphics-queue-index)
									       :queue-count 1
									       :queue-properties 1.0)
							 (create-device-queues :queue-family-index (get-handle :present-queue-index)
									       :queue-count 1
									       :queue-properties 1.0))))
  (insert-to-handle :surface (glfw-create-surface (get-handle :instance)
						  *window*))
  (insert-to-handle :surface-cap (get-physical-device-surface-capabilities (get-handle :gpu)
									   (get-handle :surface)))
  (insert-to-handle :surface-format (get-physical-device-surface-format (get-handle :gpu)
									(get-handle :surface)))
  (insert-to-handle :surface-present-mode (get-physical-device-surfaec-present-mode (get-handle :gpu)
										    (get-handle :surface)))
  (insert-to-handle :graphics-queue-index (get-device-queue (get-handle :device)
							    (get-handle :graphics-queue-index)
							    0))
  (insert-to-handle :present-queue-index (get-device-queue (get-handle :device)
							   (get-handle :present-queue-index)
							   0))
  (show-info))

(defun clean-up ()
  (destroy-device (get-handle :device))
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
