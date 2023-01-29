
(cond-expand
 (guile
  (define-module (euphrates global-debug-mode-filter)
    :export (global-debug-mode-filter))))


(define global-debug-mode-filter (make-parameter #f))


