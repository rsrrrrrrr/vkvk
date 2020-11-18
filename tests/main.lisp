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

(defun make-graphics-pipeline ()
  (insert-to-handle :vert (create-shader-module (get-handle :device)
						"~/codes/vkvk/tests/vert.spv"))
  (insert-to-handle :frag (create-shader-module (get-handle :device)
						"~/codes/vkvk/tests/frag.spv"))
  (insert-to-handle :vert-shader-stage (create-graphics-pipeline-shader-stage (get-handle :vert))) ;;stage as default vert
  (insert-to-handle :frage-shader-stage (create-graphics-pipeline-shader-stage (get-handle :frag)
									       :stage :shader-stage-fragment-bit))
  (insert-to-handle :vertex-input-state (create-graphics-pipeline-vertex-input-state))
  (insert-to-handle :input-assembly-state (create-graphics-pipeline-input-assembly-state :topology :primitive-topology-triangle-list))
  (insert-to-handle :viewport-state (create-graphics-pipeline-viewport-state
				     :viewports (list
						 (make-lsp-viewport :x 0.0
								    :y 0.0
								    :width 600.0
								    :height 600.0
								    :min-depth 0.0
								    :max-depth 1.0))

				     :scissors (list
						(make-lsp-rect-2d :offset
								  (make-lsp-offset-2d :x 0 :y 0)
								  :extent
								  (make-lsp-extent-2d :width 600 :height 600)))))
  (insert-to-handle :rasterization-state (create-graphics-pipeline-rasterization-state :line-width 1.0
										       :cull-mode :cull-mode-back-bit
										       :front-face :front-face-clockwise))
  (insert-to-handle :multisample-state (create-graphics-pipeline-multisample-state)))

(defun select-format-and-color-space (a-lst)
  (labels ((select (lst)
	     (cond ((null lst) nil)
		   ((and (eql (getf (first lst) :format) :format-b8g8r8a8-srgb)
			 (eql (getf (first lst) :color-space) :color-space-srgb-nonlinear-khr))
		    (first lst))
		   (t (select (rest lst))))))
    (let ((result (select a-lst))
	  (default (first a-lst)))
      (if (null result)
	  (progn
	    (insert-to-handle :surface-format :format-b8g8r8a8-srgb)
	    (insert-to-handle :surface-color-space :color-space-srgb-nonlinear-khr))
	  (progn
	    (insert-to-handle :surface-format (getf default :format))
	    (insert-to-handle :surface-color-space (getf default :color-space)))))))

(defun select-present-mode (lst)
  (cond ((null lst) (insert-to-handle :present-mode :present-mode-fifo-khr))
	((eql (first lst) :present-mode-mailbox-khr) (insert-to-handle :present-mode (first lst)))
	(t (select-present-mode (rest lst)))))

(defun show-info ()
  (format t "gpu properties: ~%~4t~{~4t~a~%~}~%" (get-handle :gpu-properties))
  (format t "queue family properties: ~%~4t~{~4t~a~%~}~%" (get-handle :queue-family-properties))
  (format t "gpu memory info: ~%~4t~{~4t~a~%~}~%" (get-handle :gpu-memory-info))
  (format t "gpu r4g4 unorm pack8 format info: ~%~4t~a~%" (get-handle :gpu-format-properties))
  (format t "surface capabilities: ~%~4t~{~4t~a~%~}" (get-handle :surface-cap))
  (format t "surface format: ~%~4t~{~4t~a~%~}" (get-handle :surface-formats))
  (format t "surface present mode: ~%~4t~{~4t~a~%~}" (get-handle :surface-present-mode))
  (format t "select surface format : ~%~4t~a~%" (get-handle :surface-format))
  (format t "select surface color space : ~%~4t~a~%" (get-handle :surface-color-space))
  (format t "select present mode : ~%~4t~a~%" (get-handle :present-mode))
  (format t "swapchain images : ~%~4t~a~%" (get-handle :swapchain-images))
  (format t "image views : ~%~4t~a~%" (get-handle :image-views)))

(defun setup-vulkan ()
  (insert-to-handle :instance (create-instance :info-exts (enumerate-instance-extensions)
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
	  (insert-to-handle :present-queue-index (first queue))))
    (insert-to-handle :device (create-device (get-handle :gpu)
					     :info-exts '("VK_KHR_swapchain")
					     :info-queues (list
							   (make-lsp-device-queue-create-info :queue-family-index (get-handle :graphics-queue-index)
											      :queue-count 1
											      :queue-properties 1.0))))
    (insert-to-handle :surface (glfw-create-surface (get-handle :instance)
						    *window*))
    (insert-to-handle :surface-cap (get-physical-device-surface-capabilities (get-handle :gpu)
									     (get-handle :surface)))
    (insert-to-handle :surface-formats (get-physical-device-surface-format (get-handle :gpu)
									   (get-handle :surface)))
    (insert-to-handle :surface-present-mode (get-physical-device-surfaec-present-mode (get-handle :gpu)
										      (get-handle :surface)))
    (insert-to-handle :graphics-queue (get-device-queue (get-handle :device)
							(get-handle :graphics-queue-index)
							0))
    (insert-to-handle :present-queue (get-device-queue (get-handle :device)
						       (get-handle :present-queue-index)
						       0))
    
    (insert-to-handle :pipeline-layout (create-pipeline-layout (get-handle :device)))
    (destroy-shader-module (get-handle :device)
			   (get-handle :vert))
    (destroy-shader-module (get-handle :device)
			   (get-handle :frag))
    (select-format-and-color-space (get-handle :surface-formats))
    (select-present-mode (get-handle :surface-present-mode))
    (insert-to-handle :swapchain1 (create-swapchain (get-handle :device)
						    (get-handle :surface)
						    :info-min-image-count (1+ (getf (get-handle :surface-cap)
										    :min-image-count))
						    :info-image-sharing-mode (if (null queue)
										 :sharing-mode-concurrent
										 :sharing-mode-exclusive)
						    :info-queue-family-indices (unless (null queue)
										 (list (get-handle :graphics-queue-index)
										       (get-handle :present-queue-index)))
						    :info-pre-transform (getf (get-handle :surface-cap) :current-transform)
						    :info-present-mode (get-handle :present-mode)))
    (insert-to-handle :swapchain-images (get-swapchain-images (get-handle :device)
							      (get-handle :swapchain1)))
    (insert-to-handle :image-views (loop for obj in (get-handle :swapchain-images)
					 collect (create-image-view (get-handle :device)
								    obj)))
    

    (show-info)))

(defun clean-up ()
  (destroy-pipeline-layout (get-handle :device)
			   (get-handle :pipeline-layout))
  (loop for obj in (get-handle :image-views)
	do (destroy-image-view (get-handle :device) obj))
  (destroy-swapchain (get-handle :device) (get-handle :swapchain1))
  (destroy-surface (get-handle :instance) (get-handle :surface))
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
