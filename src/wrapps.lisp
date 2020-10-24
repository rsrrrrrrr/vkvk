(in-package :vkvk)

(export '(make-vulkan-version
	  get-instance-extensions))

;;no need export
(defun check-reslute-type (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val)))

(defun obj->list (objs num)
  (let ((count (1- (mem-ref num :uint32))))
    (loop for i upto count
	  collect (mem-aref objs :string i))))

;;export
(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let ((exts (glfwGetRequiredInstanceExtensions count)))
      (obj->list exts count))))
