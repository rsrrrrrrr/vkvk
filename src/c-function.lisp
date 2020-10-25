(in-package :vkvk)

(export '(get-vulkan-support
	  queue-family-index-support-present-p))

;;no need wrapp
(defcfun ("glfwVulkanSupported" get-vulkan-support) :boolean
  "return true if vulkan is available")

(defcfun ("glfwGetPhysicalDevicePresentationSupport" queue-family-index-support-present-p) :int
  (instance vk-handle)
  (physical-device vk-handle)
  (index :uint32))

;;need wrapp
(defcfun ("glfwGetRequiredInstanceExtensions" glfwGetRequiredInstanceExtensions) (:pointer :string)
  (count (:pointer :uint32)))

(defcfun ("glfwCreateWindowSurface" glfwCreateWindowSurface) VkResult
  (instance vk-instance)
  (window :pointer)
  (allocator (:pointer (:struct vk-allocation-callback)))
  (surface vk-surface-khr))

(defcfun ("vkEnumerateInstanceLayerProperties" vkEnumerateInstanceLayerProperties) vkresult
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-layer-properties))))

(defcfun ("vkCreateInstance" vkCreateInstance) vkresult
  (info (:pointer (:struct vk-instance-create-info)))
  (allocator vk-p-allocator)
  (instance vk-instance))

(defcfun ("vkDestroyInstance" vkDestroyInstance) :void
  (instance vk-instance)
  (allocator vk-p-allocator))

;;get function
(defcfun ("vkEnumeratePhysicalDevices" vkEnumeratePhysicalDevices) VkResult
  (instance vk-instance)
  (count (:pointer :uint32))
  (physical-devices (:pointer vk-physical-device)))

(defcfun ("vkGetPhysicalDeviceProperties" vkGetPhysicalDeviceProperties) :void
  (physical-device vk-physical-device)
  (properties (:pointer (:struct vk-physical-device-properties))))

(defcfun ("vkGetPhysicalDeviceQueueFamilyProperties" vkGetPhysicalDeviceQueueFamilyProperties) :void
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-queue-family-properties))))

(defcfun ("vkGetPhysicalDeviceMemoryProperties" vkGetPhysicalDeviceMemoryProperties) :void
  (physical-device vk-physical-device)
  (properties (:pointer (:struct vk-physical-device-memory-properties))))
