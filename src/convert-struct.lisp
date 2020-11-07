(in-package :vkvk)

(export '(create-device-queues))

(defstruct lsp-device-queue-create-info
  (type :structure-type-device-queue-create-info)
  (next *vk-nullptr*)
  (flag 0)
  (queue-family-index 0)
  (queue-count 0)
  (queue-properties *vk-nullptr*))

(defun create-device-queues (&key
			       (flag 0)
			       (next *vk-nullptr*)
			       (queue-family-index 0)
			       (queue-count 0)
			       (queue-properties *vk-nullptr*))
  (make-lsp-device-queue-create-info :flag flag
				     :next next
				     :queue-family-index queue-family-index
				     :queue-count queue-count
				     :queue-properties queue-properties))