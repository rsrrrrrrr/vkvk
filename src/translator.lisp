(in-package :vkvk)

(defvkobj vk-offset-2d
    (s-offset-2d offset-2d)
  (:x :uint32)
  (:y :uint32))

(defvkobj vk-offset-3d
    (s-offset-3d offset-3d)
  (:x :uint32)
  (:y :uint32)
  (:z :uint32))

(defvkobj vk-extent-2d
    (s-extent-2d extent-2d)
  (:width :uint32)
  (:height :uint32))

(defvkobj vk-extent-3d
    (s-extent-3d extent-3d)
  (:width :uint32)
  (:height :uint32)
  (:depth :uint32))

(defvkobj vk-rect-2d
    (s-rect-2d rect-2d)
  (:offset (:struct vk-offset-2d) :parser offset-2d)
  (:extent (:struct vk-extent-2d) :parser extent-2d))

(defvkobj vk-application-info
    (s-application-info application-info)
  (:type VkStructureType)
  (:next (:pointer :void))
  (:app-name (:pointer :char))
  (:app-version :uint32)
  (:engine-name (:pointer :char))
  (:engine-version :uint32)
  (:api-version :uint32))

(defvkobj vk-instance-create-info
    (s-instance-create-info instance-create-info )
  (:type VkStructureType)
  (:next (:pointer :void))
  (:flags (vk-instance-create-flags))
  (:info (:pointer (:struct vk-application-info)) :parser application-info)
  (:layer-count :uint32)
  (:layers (:pointer (:pointer :char)) :bind :layer-count)
  (:extension-count :uint32)
  (:extensions (:pointer (:pointer :char)) :bind :extension-count))
