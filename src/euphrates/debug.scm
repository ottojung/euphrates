



(define [debug fmt . args]
  (let [[p (global-debug-mode-filter)]]
    (when (or (not p) (p fmt args))
      (parameterize ((current-output-port (current-error-port)))
        (apply printf (conss (string-append fmt "\n") args))))))
