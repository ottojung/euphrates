
(cond-expand
 (guile
  (define-module (euphrates debug)
    :export (debug)
    :use-module ((euphrates global-debug-mode-filter) :select (global-debug-mode-filter))
    :use-module ((euphrates printf) :select (printf))
    :use-module ((euphrates conss) :select (conss)))))



(define [debug fmt . args]
  (let [[p (global-debug-mode-filter)]]
    (when (or (not p) (p fmt args))
      (parameterize ((current-output-port (current-error-port)))
        (apply printf (conss (string-append fmt "\n") args))))))
