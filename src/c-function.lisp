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

(defcfun ("vkGetDeviceProcAddr" get-device-proc-addr) :pointer
  (device vk-device)
  (name :string))

(defcfun ("vkGetInstanceProcAddr" get-instance-proc-addr) :pointer
  (instance vk-instance)
  (name :string))

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

(defcfun ("vkEnumerateDeviceLayerProperties" vkEnumerateDeviceLayerProperties) VkResult
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-layer-properties))))

(defcfun ("vkEnumerateDeviceExtensionProperties" vkEnumerateDeviceExtensionProperties) VkResult
  (physical-device vk-physical-device)
  (layer-name :string)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-extension-properties))))

(defcfun ("vkCreateInstance" vkCreateInstance) vkresult
  (info (:pointer (:struct vk-instance-create-info)))
  (allocator vk-p-allocator)
  (instance vk-instance))

(defcfun ("vkDestroyInstance" vkDestroyInstance) :void
  (instance vk-instance)
  (allocator vk-p-allocator))

(defcfun ("vkCreateDevice" vkCreateDevice) VkResult
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-device-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (device (:pointer vk-device)))

(defcfun ("vkDestroyDevice" vkDestroyDevice) :void
  (device vk-device)
  (allocator (:pointer (:struct vk-allocation-callback))))
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

(defcfun ("vkGetPhysicalDeviceFeatures" vkGetPhysicalDeviceFeatures) :void
  (physical-device vk-physical-device)
  (features (:pointer (:struct vk-physical-device-features))))

(defcfun ("vkGetPhysicalDeviceFormatProperties" vkGetPhysicalDeviceFormatProperties) :void
  (physical-device vk-physical-device)
  (format VkFormat)
  (properties (:pointer (:struct vk-format-properties))))
