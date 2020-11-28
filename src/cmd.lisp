(in-package :vkvk)

(defun cmd-bind-pipeline (cmd bind-point pipeline)
  "bind function vkCmdBindPipeline"
  (vkCmdBindPipeline cmd bind-point pipeline))

(defun cmd-set-viewport (cmd first-viewport viewports)
  "bind function vkCmdSetViewport"
  (let ((count (length viewports)))
    (when (zerop count)
      (error "no viewport you can set"))
    (with-foreign-object (p-viewports 'viewport count)
      (loop for obj in viewports
	    for i from 0
	    do (setf (mem-aref p-viewports 'viewport i)
		     (list (vk-getf obj :x)
			   (vk-getf obj :y)
			   (vk-getf obj :width)
			   (vk-getf obj :height)
			   (vk-getf obj :min-depth)
			   (vk-getf obj :max-depth))))
      (vkCmdSetViewport cmd first-viewport count p-viewports)
      (free-objs))))

(defun cmd-set-scissor (cmd first-scissor rects)
  "function bind vkCmdSetScissor"
  (let ((count (length rects)))
    (when (zerop count)
      (error "no rects you can set"))
    (with-foreign-object (p-scissors 'rect-2d count)
      (loop for obj in rects
	    for i from 0
	    for offset = (vk-getf rects :offset)
	    for extent = (vk-getf rects :extent)
	    do (setf (mem-aref p-scissors 'viewport i)
		     (list (list (vk-getf offset :x)
				 (vk-getf offset :y))
			   (list (vk-getf extent :width)
				 (vk-getf extent :height)))))
      (vkCmdSetScissor cmd first-scissor count p-scissors)
      (free-objs))))


(defun cmd-set-line-width (cmd width)
  "function bind vkCmdSetLineWidth"
  (vkCmdSetLineWidth cmd width))

(defun cmd-set-depth-bounds (cmd constents clamp slope)
  "function bind vkCmdSetDepthBias"
  (vkCmdSetDepthBias cmd constents clamp slope))

(defun cmd-set-blend-constants (cmd blend)
  "function bind vkCmdSetBlendConstants"
  (when (and (/= (length blend) 4)
	     (every #'(lambda (x) (typep x 'float)) blend))
    (error "the length of blend is not 4, or the type of blend is not float"))
  (with-foreign-object (p-blend :float 4)
    (dotimes (i 4)
      (setf (mem-aref p-blend :float i)
	    (nth i blend)))
    (vkCmdSetBlendConstants cmd p-blend)))

(defun cmd-set-depth-bounds (cmd min max)
  "function bind vkCmdSetDepthBounds"
  (vkCmdSetDepthBounds cmd min max))

(defun cmd-set-stencil-compare-mask (cmd flags mask)
  "function bind vkCmdSetStencilCompareMask"
  (vkCmdSetStencilCompareMask cmd flags mask))

(defun cmd-set-stencil-write-mask (cmd flags mask)
  "function bind vkCmdSetStencilCompareMask"
  (vkCmdSetStencilWriteMask cmd flags mask))

(defun cmd-set-stencil-reference (cmd mask reference)
  "function bind vkCmdSetStencilReference"
  (vkCmdSetStencilReference cmd mask reference))

(defun cmd-bind-descriptor-sets (cmd bind-point layout first sets offsets)
  "function bind vkCmdBindDescriptorSets"
  (let ((set-count (length sets))
	(offset-count (length offsets)))
    (with-foreign-objects ((p-sets 'vk-descriptor-set set-count)
			   (p-offsets :uint32 offset-count))
      (set-normol-pointer p-sets sets 'vk-descriptor-set set-count)
      (set-normol-pointer p-offsets offsets :uint32 offset-count)
      (vkCmdBindDescriptorSets cmd bind-point layout first set-count p-sets offset-count p-offsets))))

(defun cmd-bind-index-buffer (cmd buffer offset type)
  "function bind vkCmdBindIndexBuffer"
  (vkCmdBindIndexBuffer cmd buffer offset type))

(defun cmd-bind-vertex-buffer (cmd first-binding count buffers offsets)
  "function bind vkCmdBindVertexBuffers"
  (let ((buffer-count (length buffers))
	(offset-count (length offsets)))
    (with-foreign-objects ((p-buffers 'vk-buffer buffer-count)
			   (p-offsets 'vk-device-size offset-count))
      (set-normol-pointer p-buffers buffers 'vk-buffer buffer-count)
      (set-normol-pointer p-offsets offsets 'vk-device-size offset-count)
      (vkCmdBindVertexBuffers cmd first-binding count p-buffers p-offsets))))

(defun cmd-draw (cmd vertex-count instance-count first-vertex first-instance)
  "function bind vkCmdDraw"
  (vkCmdDraw cmd vertex-count instance-count first-vertex first-instance))

(defun cmd-draw-indexed (cmd index-count instance-count first-index vertex-offset first-instance)
  "function bind vkCmdDrawIndexed"
  (vkCmdDrawIndexed cmd index-count instance-count first-index vertex-offset first-instance))

(defun cmd-draw-indirect (cmd buffer offset count stride)
  "function bind vkCmdDrawIndirect"
  (vkCmdDrawIndirect cmd buffer offset count stride))

(defun cmd-draw-indexed-indirect (cmd buffer offset count stride)
  "function bind vkCmdDrawIndexedIndirect"
  (vkCmdDrawIndexedIndirect cmd buffer offset count stride))

(defun cmd-dispatch (cmd x y z)
  "function bind vkCmdDispatch"
  (vkCmdDispatch cmd x y z))

(defun cmd-dispatch-indirect (cmd buffer offset)
  "function bind vkCmdDispatchIndirect"
  (vkCmdDispatchIndirect cmd buffer offset))

(defun cmd-copy-buffer (cmd src dst regions)
  "function bind vkCmdCopyBuffer"
  (let ((count (length regions)))
    (when (zerop count)
      (error "no regions you can set"))
    (with-foreign-object (p-regions 'buffer-copy count)
      (loop for obj in regions
	    for i from 0
	    do (setf (mem-aref p-regions 'buffer-copy i)
		     (list (vk-getf obj :src-offset)
			   (vk-getf obj :dst-offset)
			   (vk-getf obj :size))))
      (vkCmdCopyBuffer cmd src dst count p-regions)
      (free-objs))))

(defun cmd-copy-image (cmd src-image src-layout dst-image dst-layout regions)
  "function bind vkCmdCopyImage"
  (let ((count (length regions)))
    (when (zerop count)
      (error "no regions you can set"))
    (with-foreign-object (p-regions 'image-copy count)
      (loop for obj in regions
	    for i from 0
	    for src-subresource = (vk-getf obj :src-subresource)
	    for src-offset = (vk-getf obj :src-offset)
	    for dst-subresource = (vk-getf obj :dst-subresource)
	    for dst-offset = (vk-getf obj :dst-offset)
	    for extent = (vk-getf obj :extent)
	    do (setf (mem-aref p-regions 'buffer-copy i)
		     (list (list (vk-getf src-subresource :aspect-mask)
				 (vk-getf src-subresource :mip-level)
				 (vk-getf src-subresource :base-array-layer)
				 (vk-getf src-subresource :layer-count))
			   (list (vk-getf src-offset :x)
				 (vk-getf src-offset :y)
				 (vk-getf src-offset :z))
			   (list (vk-getf dst-subresource :aspect-mask)
				 (vk-getf dst-subresource :mip-level)
				 (vk-getf dst-subresource :base-array-layer)
				 (vk-getf dst-subresource :layer-count))
			   (list (vk-getf dst-offset :x)
				 (vk-getf dst-offset :y)
				 (vk-getf dst-offset :z))
			   (list (vk-getf extent :width)
				 (vk-getf extent :height)
				 (vk-getf extent :depth)))))
      (vkCmdCopyImage cmd src-image src-layout dst-image dst-layout count p-regions)
      (free-objs))))

(defun cmd-blit-image (cmd src-image src-layout dst-image dst-layout regions filter)
  "function bind vkCmdBlitImage"
  (let ((count (length regions)))
    (when (zerop count)
      (error "no regions you can set"))
    (with-foreign-object (p-regions 'image-blit count)
      (loop for obj in regions
	    for i from 0
	    for src-subresource = (vk-getf obj :src-subresource)
	    for src-offset = (vk-getf obj :src-offset)
	    for dst-subresource = (vk-getf obj :dst-subresource)
	    for dst-offset = (vk-getf obj :dst-offset)
	    do
	       (let ((src-offset1 (nth 0 src-offset))
		     (src-offset2 (nth 1 src-offset))
		     (dst-offset1 (nth 0 dst-offset))
		     (dst-offset2 (nth 1 dst-offset)))
		 (setf (mem-aref p-regions 'buffer-copy i)
		       (list (list (vk-getf src-subresource :aspect-mask)
				   (vk-getf src-subresource :mip-level)
				   (vk-getf src-subresource :base-array-layer)
				   (vk-getf src-subresource :layer-count))
			     (list (list (vk-getf src-offset1 :x)
					 (vk-getf src-offset1 :y)
					 (vk-getf src-offset1 :z))
				   (list (vk-getf src-offset2 :x)
					 (vk-getf src-offset2 :y)
					 (vk-getf src-offset2 :z)))
			     (list (vk-getf dst-subresource :aspect-mask)
				   (vk-getf dst-subresource :mip-level)
				   (vk-getf dst-subresource :base-array-layer)
				   (vk-getf dst-subresource :layer-count))
			     (list (list (vk-getf dst-offset1 :x)
					 (vk-getf dst-offset1 :y)
					 (vk-getf dst-offset1 :z))
				   (list (vk-getf dst-offset1 :x)
					 (vk-getf dst-offset2 :y)
					 (vk-getf dst-offset2 :z)))))))
      (vkCmdBlitImage cmd src-image src-layout dst-image dst-layout count p-regions filter)
      (free-objs))))

(defun cmd-copy-buffer-to-image (cmd src-buffer dst-image dst-layout regions)
  "function bind vkCmdCopyBufferToImage"
  (let ((count (length regions)))
    (when (zerop count)
      (error "no regions you can set"))
    (with-foreign-object (p-regions 'buffer-image-copy count)
      (loop for obj in regions
	    for i from 0
	    for image-subresource = (vk-getf obj :image-subresource)
	    for image-offset = (vk-getf obj :image-offset)
	    for image-extent = (vk-getf obj :image-extent)
	    do (setf (mem-aref p-regions 'buffer-copy i)
		     (list (list (vk-getf image-subresource :aspect-mask)
				 (vk-getf image-subresource :mip-level)
				 (vk-getf image-subresource :base-array-layer)
				 (vk-getf image-subresource :layer-count))
			   (list (vk-getf image-offset :x)
				 (vk-getf image-offset :y)
				 (vk-getf image-offset :z))
			   (list (vk-getf image-extent :width)
				 (vk-getf image-extent :height)
				 (vk-getf image-extent :depth)))))
      (vkCmdCopyBufferToImage cmd src-buffer dst-image dst-layout count p-regions)
      (free-objs))))

(defun cmd-copy-image-to-buffer (cmd src-image src-layout dst-buffer regions)
  "function bind vkCmdCopyImageToBuffer"
  (let ((count (length regions)))
    (when (zerop count)
      (error "no regions you can set"))
    (with-foreign-object (p-regions 'buffer-image-copy count)
      (loop for obj in regions
	    for i from 0
	    for image-subresource = (vk-getf obj :image-subresource)
	    for image-offset = (vk-getf obj :image-offset)
	    for image-extent = (vk-getf obj :image-extent)
	    do (setf (mem-aref p-regions 'buffer-copy i)
		     (list (list (vk-getf image-subresource :aspect-mask)
				 (vk-getf image-subresource :mip-level)
				 (vk-getf image-subresource :base-array-layer)
				 (vk-getf image-subresource :layer-count))
			   (list (vk-getf image-offset :x)
				 (vk-getf image-offset :y)
				 (vk-getf image-offset :z))
			   (list (vk-getf image-extent :width)
				 (vk-getf image-extent :height)
				 (vk-getf image-extent :depth)))))
      (vkCmdCopyImageToBuffer cmd src-image src-layout dst-buffer count p-regions)
      (free-objs))))

(defun cmd-update-buffer (cmd dst-buffer dst-offset data-size data)
  "function bind vkCmdUpdateBuffer"
  (vkCmdUpdateBuffer cmd dst-buffer dst-offset data-size data))

(defun cmd-fill-buffer (cmd dst-buffer dst-offset size data)
  "function bind vkCmdFillBuffer"
  (vkCmdFillBuffer cmd dst-buffer dst-offset size data))

(defun cmd-clear-color-image (cmd image image-layout color ranges)
  "function bind vkCmdClearColorImage"
  (let ((count (length ranges)))
    (when (zerop count)
      (error "no ranges you can set"))
    (with-foreign-objects ((p-range 'image-subresource-range count)
			   (p-color 'clear-color-value))
      (loop for obj in ranges
	    for i from 0
	    do (setf (mem-aref p-range 'image-subresource-range i)
		     (list (vk-getf obj :aspect-mask)
			   (vk-getf obj :base-mip-level)
			   (vk-getf obj :level-count)
			   (vk-getf obj :base-array-layer)
			   (vk-getf obj :layer-count))))
      (setf (mem-ref p-color 'clear-color-value)
	    (list (vk-getf color :f32)
		  (vk-getf color :i32)
		  (vk-getf color :ui32)))
      (vkCmdClearColorImage cmd image image-layout p-color count p-range)
      (free-objs))))

(defun cmd-clear-depth-stencil-image (cmd image image-layout stencils ranges)
  "bind function vkCmdClearDepthStencilImage"
  (let ((count (length ranges))
	(stencil-count (length stencils)))
    (when (zerop count)
      (error "no ranges you can set"))
    (with-foreign-objects ((p-range 'image-subresource-range count)
			   (p-stencil 'clear-depth-stencil-value stencil-count))
      (loop for obj in ranges
	    for i from 0
	    do (setf (mem-aref p-range 'image-subresource-range i)
		     (list (vk-getf obj :aspect-mask)
			   (vk-getf obj :base-mip-level)
			   (vk-getf obj :level-count)
			   (vk-getf obj :base-array-layer)
			   (vk-getf obj :layer-count))))
      (loop for obj in stencils
	    for i from 0
	    do (setf (mem-aref p-stencil 'clear-depth-stencil-value)
		     (list (vk-getf obj :depth)
			   (vk-getf obj :stencil))))
      (vkCmdClearDepthStencilImage cmd image image-layout p-stencil count p-range)
      (free-objs))))

(defun cmd-clear-attachments (cmd attachments rects)
  "bind function vkCmdClearAttachments"
  (let ((attachemnt-count (length attachments))
	(rect-count (length rects)))
    (when (or (zerop attachemnt-count) (zerop rect-count))
      (error "no attachemnt or rect you can set"))
    (with-foreign-objects ((p-attachment 'clear-attachment attachemnt-count)
			   (p-rect 'clear-rect rect-count))
      (loop for obj in attachments
	    for i from 0
	    do (setf (mem-aref p-attachment 'clear-attachment i)
		     (list (vk-getf obj :aspect-mask)
			   (vk-getf obj :color-attachment)
			   (vk-getf obj :clear-values))))
      (loop for obj in rects
	    for i from 0
	    for rect = (vk-getf obj :rect)
	    for rect-offset = (vk-getf rect :offset)
	    for rect-extent = (vk-getf rect :extent)
	    do (setf (mem-aref p-rect 'clear-rect i)
		     (list (list (list (vk-getf rect-offset :x)
				       (vk-getf rect-offset :y))
				 (list (vk-getf rect-extent :width)
				       (vk-getf rect-extent :height)))
			   (vk-getf obj :base-array-layer)
			   (vk-getf obj :layer-count))))
      (vkCmdClearAttachments cmd attachemnt-count p-attachment rect-count p-rect)
      (free-objs))))

(defun cmd-resolve-image (cmd src-image src-layout dst-image dst-layout regions)
  "bind function vkCmdResolveImage"
  (let ((count (length regions)))
    (when (zerop count)
      (error "no regions you can set"))
    (with-foreign-object (p-regions 'image-copy count)
      (loop for obj in regions
	    for i from 0
	    for src-subresource = (vk-getf obj :src-subresource)
	    for src-offset = (vk-getf obj :src-offset)
	    for dst-subresource = (vk-getf obj :dst-subresource)
	    for dst-offset = (vk-getf obj :dst-offset)
	    for extent = (vk-getf obj :extent)
	    do (setf (mem-aref p-regions 'buffer-copy i)
		     (list (list (vk-getf src-subresource :aspect-mask)
				 (vk-getf src-subresource :mip-level)
				 (vk-getf src-subresource :base-array-layer)
				 (vk-getf src-subresource :layer-count))
			   (list (vk-getf src-offset :x)
				 (vk-getf src-offset :y)
				 (vk-getf src-offset :z))
			   (list (vk-getf dst-subresource :aspect-mask)
				 (vk-getf dst-subresource :mip-level)
				 (vk-getf dst-subresource :base-array-layer)
				 (vk-getf dst-subresource :layer-count))
			   (list (vk-getf dst-offset :x)
				 (vk-getf dst-offset :y)
				 (vk-getf dst-offset :z))
			   (list (vk-getf extent :width)
				 (vk-getf extent :height)
				 (vk-getf extent :depth)))))
      (vkCmdResolveImage cmd src-image src-layout dst-image dst-layout count p-regions)
      (free-objs))))

(defun cmd-set-event (cmd event mask)
  "bind function vkCmdSetEvent"
  (vkCmdSetEvent cmd event mask))

(defun cmd-reset-event (cmd event mask)
  "bind function vkCmdResetEvent"
  (vkCmdResetEvent cmd event mask))

(defun cmd-wait-event (cmd events src-mask dst-mask memory-barriers buffer-barriers image-barriers)
  "bind function vkCmdWaitEvents"
  (let ((event-count (length events))
	(memory-count (length memory-barriers))
	(buffer-count (length buffer-barriers))
	(image-count  (length image-barriers)))
    (when (some #'zerop (list event-count memory-count buffer-count image-count))
      (error "set value error"))
    (with-foreign-objects ((p-events 'vk-event event-count)
			   (p-memory-barriery 'memory-barrier memory-count)
			   (p-buffer-memory-barriery 'buffer-memory-barrier buffer-count)
			   (p-image-memory-barriery 'image-memory-barrier image-count))
      (set-normol-pointer p-events events 'vk-event event-count)
      (loop for obj in memory-barriers
	    for i from 0
	    do (setf (mem-aref p-memory-barriery 'memory-barrier i)
		     (list :structure-type-memory-barrier
			   (vk-getf obj :next)
			   (vk-getf obj :src-access-mask)
			   (vk-getf obj :dst-access-mask))))
      (loop for obj in buffer-barriers
	    for i from 0
	    do (setf (mem-aref p-buffer-memory-barriery 'buffer-memory-barrier i)
		     (list :structure-type-buffer-memory-barrier
			   (vk-getf obj :next)
			   (vk-getf obj :src-access-mask)
			   (vk-getf obj :dst-access-mask)
			   (vk-getf obj :src-queue-family-index)
			   (vk-getf obj :dst-queue-family-index)
			   (vk-getf obj :buffer)
			   (vk-getf obj :offset)
			   (vk-getf obj :size))))
      (loop for obj in image-barriers
	    for i from 0
	    for range = (vk-getf obj :sub-resource-range)
	    do (setf (mem-aref p-image-memory-barriery 'image-memory-barrier i)
		     (list :structure-type-image-memory-barrier
			   (vk-getf obj :next)
			   (vk-getf obj :src-access-mask)
			   (vk-getf obj :dst-access-mask)
			   (vk-getf obj :old-layout)
			   (vk-getf obj :new-layout)
			   (vk-getf obj :src-queue-family-index)
			   (vk-getf obj :dst-queue-family-index)
			   (vk-getf obj :image)
			   (list (vk-getf range :aspect-mask)
				 (vk-getf range :base-mip-level)
				 (vk-getf range :level-count)
				 (vk-getf range :base-array-layer)
				 (vk-getf range :layer-count)))))
      (vkCmdWaitEvents cmd
		       src-mask dst-mask
		       event-count p-events
		       memory-count p-memory-barriery
		       buffer-count p-buffer-memory-barriery
		       image-count p-image-memory-barriery)
      (free-objs))))

(defun cmd-pipeline-barrier (cmd src-mask dst-mask flags memory-barriers buffer-barriers image-barriers)
  "bind function vkCmdPipelineBarrier"
  (let ((memory-count (length memory-barriers))
	(buffer-count (length buffer-barriers))
	(image-count  (length image-barriers)))
    (when (some #'zerop (list memory-count buffer-count image-count))
      (error "set value error"))
    (with-foreign-objects ((p-memory-barriery 'memory-barrier memory-count)
			   (p-buffer-memory-barriery 'buffer-memory-barrier buffer-count)
			   (p-image-memory-barriery 'image-memory-barrier image-count))
      (loop for obj in memory-barriers
	    for i from 0
	    do (setf (mem-aref p-memory-barriery 'memory-barrier i)
		     (list :structure-type-memory-barrier
			   (vk-getf obj :next)
			   (vk-getf obj :src-access-mask)
			   (vk-getf obj :dst-access-mask))))
      (loop for obj in buffer-barriers
	    for i from 0
	    do (setf (mem-aref p-buffer-memory-barriery 'buffer-memory-barrier i)
		     (list :structure-type-buffer-memory-barrier
			   (vk-getf obj :next)
			   (vk-getf obj :src-access-mask)
			   (vk-getf obj :dst-access-mask)
			   (vk-getf obj :src-queue-family-index)
			   (vk-getf obj :dst-queue-family-index)
			   (vk-getf obj :buffer)
			   (vk-getf obj :offset)
			   (vk-getf obj :size))))
      (loop for obj in image-barriers
	    for i from 0
	    for range = (vk-getf obj :sub-resource-range)
	    do (setf (mem-aref p-image-memory-barriery 'image-memory-barrier i)
		     (list :structure-type-image-memory-barrier
			   (vk-getf obj :next)
			   (vk-getf obj :src-access-mask)
			   (vk-getf obj :dst-access-mask)
			   (vk-getf obj :old-layout)
			   (vk-getf obj :new-layout)
			   (vk-getf obj :src-queue-family-index)
			   (vk-getf obj :dst-queue-family-index)
			   (vk-getf obj :image)
			   (list (vk-getf range :aspect-mask)
				 (vk-getf range :base-mip-level)
				 (vk-getf range :level-count)
				 (vk-getf range :base-array-layer)
				 (vk-getf range :layer-count)))))
      (vkCmdPipelineBarrier cmd
			    src-mask dst-mask
			    flags
			    memory-count p-memory-barriery
			    buffer-count p-buffer-memory-barriery
			    image-count p-image-memory-barriery)
      (free-objs))))

(defun cmd-begin-query (cmd pool query flags)
  "bind function vkCmdBeginQuery"
  (vkCmdBeginQuery cmd pool query flags))

(defun cmd-end-query (cmd pool query)
  "bind function vkCmdEndQuery"
  (vkCmdEndQuery cmd pool query))

(defun cmd-begin-conditional-rendering-ext (buffer begin)
  "bind function vkCmdBeginConditionalRenderingEXT"
  (with-foreign-object (p-begin 'conditional-rendering-begin-info-ext)
    (setf (mem-ref p-begin 'conditional-rendering-begin-info-ext)
	  (list :structure-type-conditional-rendering-begin-info-ext
		(vk-getf begin :next)
		(vk-getf begin :buffer)
		(vk-getf begin :offset)
		(vk-getf begin :flags)))
    (vkCmdBeginConditionalRenderingEXT buffer p-begin)))

(defun cmd-end-conditional-rendering-ext (buffer)
  "bind function vkCmdEndConditionalRenderingEXT"
  (vkCmdEndConditionalRenderingEXT buffer))

(defun cmd-reset-query-pool (cmd pool first count)
  "bind function vkCmdResetQueryPool"
  (vkCmdResetQueryPool cmd pool first count))

(defun cmd-write-timestamp (cmd stage pool query)
  "bind function vkCmdWriteTimestamp"
  (vkCmdWriteTimestamp cmd stage pool query))

(defun cmd-copy-query-pool-results (pool first count dst-buffer dst-offset stride flags)
  "bind function vkCmdCopyQueryPoolResults"
  (vkCmdCopyQueryPoolResults pool first count dst-buffer dst-offset stride flags))

(defun cmd-push-constants (cmd layout flag offset size value)
  "bind function vkCmdPushConstants"
  (vkCmdPushConstants cmd layout flag offset size value))

(defun cmd-begin-redner-pass (cmd begin constents)
  "bind function vkCmdBeginRenderPass"
  (with-foreign-object (p-info 'render-pass-begin-info)
    (let* ((render-area (vk-getf begin :render-area))
	   (rect-offset (vk-getf render-area :offset))
	   (rect-extent (vk-getf render-area :extent))
	   (clear-values (vk-getf begin :clear-values))
	   (count (length clear-values)))
      (setf (mem-ref p-info 'render-pass-begin-info)
	    (list :structure-type-render-pass-begin-info
		  (vk-getf begin :next)
		  (vk-getf begin :render-pass)
		  (vk-getf begin :framebuffer)
		  (list (list (vk-getf rect-offset :x)
			      (vk-getf rect-offset :y))
			(list (vk-getf rect-extent :width)
			      (vk-getf rect-extent :height)))
		  count
		  (loop for obj in clear-values
			for obj-color = (vk-getf obj :color)
			for obj-stencil = (vk-getf obj :depth-stencil)
			for i from 0
			collect (list (list (vk-getf obj-color :f32)
					    (vk-getf obj-color :i32)
					    (vk-getf obj-color :ui32))
				      (list (vk-getf obj-stencil :depth)
					    (vk-getf obj-stencil :stencil))))))
      (vkCmdBeginRenderPass cmd p-info constents)
      (free-objs))))

(defun cmd-nect-subpass (cmd constents)
  "bind function vkCmdNextSubpass"
  (vkCmdNextSubpass cmd constents))

(defun cmd-end-render-pass (buffer)
  "bind function vkCmdEndRenderPass"
  (vkCmdEndRenderPass buffer))

(defun cmd-execute-commnads (cmd buffers)
  "bind function vkCmdExecuteCommands"
  (let ((count (length buffers)))
    (when (zerop count)
      (error "no buffer you can set"))
    (with-foreign-object (p-buffers 'vk-command-buffer count)
      (set-normol-pointer p-buffers buffers 'vk-command-buffer count)
      (vkCmdExecuteCommands cmd count p-buffers))))

(defun cmd-execute-generated-commands-nv (cmd perprocessed info)
  "bind function vkCmdExecuteGeneratedCommandsNV"
  (let* ((buffers (vk-getf info :preprocess-buffer))
	 (count (length buffers)))
    (with-foreign-object (p-info 'generated-commands-info-nv)
    (setf (mem-ref p-info 'generated-commands-info-nv)
	  (list :structure-type-generated-commands-info-nv
		(vk-getf info :next)
		(vk-getf info :pipeline-bind-point)
		(vk-getf info :pipeline)
		(vk-getf info :indirect-commands-layout)
		(vk-getf info :stream-count)
		(vk-getf info :streams)
		count
		(loop for obj in buffers
		      for i from 0
		      collect (list (vk-getf obj :buffer)
				    (vk-getf obj :offset)))
		(vk-getf info :preprocess-offset)
		(vk-getf info :preprocess-size)
		(vk-getf info :sequences-count-buffer)
		(vk-getf info :sequences-count-offset)
		(vk-getf info :sequences-index-buffer)
		(vk-getf info :sequences-index-offset)))
      (vkCmdExecuteGeneratedCommandsNV cmd perprocessed p-info)
      (free-objs))))

(defun cmd-bind-pipeline-shader-group-nv (cmd bind-point pipeline index)
  "bind function vkCmdBindPipelineShaderGroupNV"
  (vkCmdBindPipelineShaderGroupNV cmd bind-point pipeline index))

(defun cmd-dispatch-base (cmd bx by bz cx cy cz)
  "bind function vkCmdDispatchBase"
  (vkCmdDispatchBase cmd
		     bx by bz
		     cx cy cz))

(defun cmd-set-device-mask (cmd mask)
  "bind function vkCmdSetDeviceMask"
  (vkCmdSetDeviceMask cmd mask))

(defun cmd-push-descriptor-set-with-template-khr (cmd template layout set data)
  "bind function vkCmdPushDescriptorSetWithTemplateKHR"
  (vkCmdPushDescriptorSetWithTemplateKHR cmd template layout set data))

(defun cmd-write-buffer-marker-amd (cmd stage buffer offset marker)
  "bind function vkCmdWriteBufferMarkerAMD"
  (vkCmdWriteBufferMarkerAMD cmd stage buffer offset marker))

(defun cmd-draw-indirect-count (cmd buffer offset count-buffer count-buffer-offset count stride)
  "bind function vkCmdDrawIndirectCount"
  (vkCmdDrawIndirectCount cmd buffer offset
			  count-buffer count-buffer-offset
			  count stride))

(defun cmd-draw-indexed-indirect-count (cmd buffer offset count-buffer count-buffer-offset count stride)
  "bind function vkCmdDrawIndexedIndirectCount"
  (vkCmdDrawIndexedIndirectCount cmd buffer offset
				 count-buffer count-buffer-offset
				 count stride))

(defun cmd-set-checkpoint-nv (cmd marker)
  "bind function vkCmdSetCheckpointNV"
  (vkCmdSetCheckpointNV cmd marker))

#|

(defcfun ("vkCmdPreprocessGeneratedCommandsNV" vkCmdPreprocessGeneratedCommandsNV) :void
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-generated-commands-info-nv))))


(defcfun ("vkCmdPushDescriptorSetKHR" vkCmdPushDescriptorSetKHR) :void
(command-buffer vk-command-buffer)
(pipeline-bind-point VkPipelineBindPoint)
(layout vk-pipeline-layout)
(set :uint32)
(write-count :uint32)
(writes (:pointer (:struct vk-write-descriptor-set))))

(defcfun ("vkCmdSetViewportWScalingNV" vkCmdSetViewportWScalingNV) :void
(command-buffers vk-command-buffer)
(first-viewport :uint32)
(count :uint32)
(viewport-scalings (:pointer (:struct vk-viewport-w-scaling-nv))))

(defcfun ("vkCmdSetDiscardRectangleEXT" vkCmdSetDiscardRectangleEXT) :void
(command-buffer vk-command-buffer)
(first-discard-rectangle :uint32)
(discard-rectangle-count :uint32)
(discard-rectangle (:pointer (:struct vk-rect-2d))))

(defcfun ("vkCmdSetSampleLocationsEXT" vkCmdSetSampleLocationsEXT) :void
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-sample-locations-info-ext))))

(defcfun ("vkCmdBeginRenderPass2" vkCmdBeginRenderPass2) :void
(command-buffer vk-command-buffer)
(begin-info (:pointer (:struct vk-render-pass-begin-info)))
(subpass-begin-info (:pointer (:struct vk-subpass-begin-info))))

(defcfun ("vkCmdNextSubpass2" vkCmdNextSubpass2) :void
(command-buffer vk-command-buffer)
(begin-info (:pointer (:struct vk-subpass-begin-info)))
(end-info (:pointer (:struct vk-subpass-end-info))))

(defcfun ("vkCmdEndRenderPass2" vkCmdEndRenderPass2) :void
(command-buffer vk-command-buffer)
(end-info (:pointer (:struct vk-subpass-end-info))))



(defcfun ("vkCmdBindTransformFeedbackBuffersEXT" ) :void
(command-buffer vk-command-buffer)
(first-binding :uint32)
(count :uint32)
(buffers (:pointer vk-buffer))
(offsets (:pointer vk-device-size))
  (sizes (:pointer vk-device-size)))



(defcfun ("vkCmdBeginTransformFeedbackEXT" vkCmdBeginTransformFeedbackEXT) :void
(command-buffer vk-command-buffer)
(firset-counter-buffer :uint32)
(counter-buffer-count :uint32)
(buffers (:pointer vk-buffer))
(offset (:pointer vk-device-size)))

(defcfun ("vkCmdEndTransformFeedbackEXT" vkCmdEndTransformFeedbackEXT) :void
(command-buffer vk-command-buffer)
(firset-counter-buffer :uint32)
(counter-buffer-count :uint32)
(buffers (:pointer vk-buffer))
(offset (:pointer vk-device-size)))

(defcfun ("vkCmdBeginQueryIndexedEXT" vkCmdBeginQueryIndexedEXT) :void
(command-buffer vk-command-buffer)
(pool vk-query-pool)
(query :uint32)
(flags vk-query-control-flags)
(index :uint32))

(defcfun ("vkCmdEndQueryIndexedEXT" vkCmdEndQueryIndexedEXT) :void
(command-buffer vk-command-buffer)
(pool vk-query-pool)
(query :uint32)
(index :uint32))

(defcfun ("vkCmdDrawIndirectByteCountEXT" vkCmdDrawIndirectByteCountEXT) :void
(command-buffer vk-command-buffer)
(instance-count :uint32)
(first-instance :uint32)
(count-buffer vk-buffer)
(count-buffer-offset vk-device-size)
(count-offset :uint32)
(vertex-stride :uint32))

(defcfun ("vkCmdSetExclusiveScissorNV" vkCmdSetExclusiveScissorNV) :void
(command-buffer vk-command-buffer)
(first-scissor :uint32)
(scissor-count :uint32)
(scissors (:pointer (:struct vk-rect-2d))))

(defcfun ("vkCmdBindShadingRateImageNV" vkCmdBindShadingRateImageNV) :void
(command-buffer vk-command-buffer)
(image-view vk-image-view)
(layout VkImageLayout))

(defcfun ("vkCmdSetViewportShadingRatePaletteNV" vkCmdSetViewportShadingRatePaletteNV) :void
(command-buffer vk-command-buffer)
(first-viewport :uint32)
(viewport-count :uint32)
(shading-rate-palettes (:pointer (:struct vk-shading-rate-palette-nv))))

(defcfun ("vkCmdSetCoarseSampleOrderNV" vkCmdSetCoarseSampleOrderNV) :void
(command-buffer vk-command-buffer)
(type VkCoarseSampleOrderTypeNV)
(count :uint32)
(custom-sample-orders (:pointer (:struct vk-coarse-sample-order-custom-nv))))

(defcfun ("vkCmdDrawMeshTasksNV" vkCmdDrawMeshTasksNV) :void
(command-buffer vk-command-buffer)
(count :uint32)
(first-task :uint32))

(defcfun ("vkCmdDrawMeshTasksIndirectNV" vkCmdDrawMeshTasksIndirectNV) :void
(command-buffer vk-command-buffer)
(buffer vk-buffer)
(offset vk-device-size)
(count :uint32)
(stride :uint32))

(defcfun ("vkCmdDrawMeshTasksIndirectCountNV" vkCmdDrawMeshTasksIndirectCountNV) :void
(command-buffer vk-command-buffer)
(buffer vk-command-buffer)
(offset vk-device-size)
(count-buffer vk-buffer)
(count-buffer-offset vk-device-size)
(max-draw-count :uint32)
(stride :uint32))

(defcfun ("vkCmdCopyAccelerationStructureNV" vkCmdCopyAccelerationStructureNV) :void
(command-buffer vk-command-buffer)
(dst vk-acceleration-structure-khr)
(src vk-acceleration-structure-khr)
(mode VkCopyAccelerationStructureModeKHR))

(defcfun ("vkCmdCopyAccelerationStructureKHR" vkCmdCopyAccelerationStructureKHR) :void
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-copy-acceleration-structure-info-khr))))

(defcfun ("vkCmdCopyAccelerationStructureToMemoryKHR" vkCmdCopyAccelerationStructureToMemoryKHR) :void
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-copy-acceleration-structure-info-khr))))

(defcfun ("vkCmdCopyMemoryToAccelerationStructureKHR" vkCmdCopyMemoryToAccelerationStructureKHR) :void
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-copy-memory-to-acceleration-structure-info-khr))))

(defcfun ("vkCmdWriteAccelerationStructuresPropertiesKHR" vkCmdWriteAccelerationStructuresPropertiesKHR) :void
(command-buffer vk-command-buffer)
(count :uint32)
(acceleration-structures (:pointer vk-acceleration-structure-khr))
(type VkQueryType)
(pool vk-query-pool)
(first-query :uint32))

(defcfun ("vkCmdBuildAccelerationStructureNV" vkCmdBuildAccelerationStructureNV) :void
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-acceleration-structure-info-nv)))
(instance-data vk-buffer)
(offset vk-device-size)
(update vk-bool-32)
(dst vk-acceleration-structure-khr)
(src vk-acceleration-structure-khr)
(scratch vk-buffer)
(scratch-offset vk-device-size))

(defcfun ("vkCmdTraceRaysKHR" vkCmdTraceRaysKHR) :void
(command-buffer vk-command-buffer)
(raygen-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(miss-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(hit-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(callable-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(width :uint32)
(height :uint32)
(depth :uint32))

(defcfun ("vkCmdTraceRaysNV" vkCmdTraceRaysNV) :void
(command-buffer vk-command-buffer)
(raygen-shader-binding-table-buffer vk-buffer)
(raygen-shader-binding-offset vk-device-size)
(miss-shader-binding-table-buffer vk-buffer)
(miss-shader-binding-offset vk-device-size)
(miss-shader-binding-stride vk-device-size)
(hit-shader-binding-table-buffer vk-buffer)
(hit-shader-binding-offset vk-device-size)
(hit-shader-binding-stride vk-device-size)
(callable-shader-binding-table-buffer vk-buffer)
(callable-shader-binding-offset vk-device-size)
(callable-shader-binding-stride vk-device-size)
(width :uint32)
(height :uint32)
(depth :uint32))

(defcfun ("vkCmdTraceRaysIndirectKHR" vkCmdTraceRaysIndirectKHR) :void
(command-buffer vk-command-buffer)
(raygen-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(miss-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(hit-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(callable-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
(buffer vk-buffer)
(offset vk-device-size))

(defcfun ("vkCmdSetPerformanceMarkerINTEL" vkCmdSetPerformanceMarkerINTEL) VkResult
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-performance-marker-info-intel))))

(defcfun ("vkCmdSetPerformanceStreamMarkerINTEL" vkCmdSetPerformanceStreamMarkerINTEL) VkResult
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-performance-stream-marker-info-intel))))

(defcfun ("vkCmdSetPerformanceOverrideINTEL" vkCmdSetPerformanceOverrideINTEL) VkResult
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-performance-override-info-intel))))

(defcfun ("vkCmdSetLineStippleEXT" vkCmdSetLineStippleEXT) :void
(command-buffer vk-command-buffer)
(factory :uint32)
(pattern :uint16))

(defcfun ("vkCmdBuildAccelerationStructureKHR" vkCmdBuildAccelerationStructureKHR) :void
(commabd-buffer vk-command-buffer)
(count :uint32)
(infos (:pointer (:struct vk-acceleration-structure-build-geometry-info-khr)))
(offset-infos (:pointer (:pointer (:struct vk-acceleration-structure-build-offset-info-khr)))))

(defcfun ("vkCmdBuildAccelerationStructureIndirectKHR" vkCmdBuildAccelerationStructureIndirectKHR) :void
(command-buffer vk-command-buffer)
(info (:pointer (:struct vk-acceleration-structure-build-geometry-info-khr)))
(buffer vk-buffer)
(offset vk-device-size)
(stride :uint32))
|#
