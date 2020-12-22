
%run guile

%use (global-debug-mode-filter) "./global-debug-mode-filter.scm"
%use (printf) "./printf.scm"
%use (conss) "./conss.scm"

%var debug

(define [debug fmt . args]
  (let [[p (global-debug-mode-filter)]]
    (when (or (not p) (p fmt args))
      (parameterize ((current-output-port (current-error-port)))
        (apply printf (conss (string-append fmt "\n") args))))))
