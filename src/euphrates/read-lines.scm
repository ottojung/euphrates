
(cond-expand
 (guile
  (define-module (euphrates read-lines)
    :export (read/lines))))


;; if `(map-fn line i)` returns #f then `line` is skipped
;; path is either a file path or an input port

(cond-expand
 (guile

  (use-modules (ice-9 rdelim))

  (define read/lines
    (case-lambda
     ((path)
      (define p (if (port? path) path (open path O_RDONLY)))
      (define ret
    (let loop ()
          (define line (read-line p))
          (cond
           ((eof-object? line) '())
           (else (cons line (loop))))))
      (when (string? path)
    (close-port p))
      ret)
     ((path map-fn)
      (define p (if (port? path) path (open path O_RDONLY)))
      (let loop ((i 0))
    (define line (read-line p))
    (if (eof-object? line) '()
            (let ((maped (map-fn line i)))
              (if maped
                  (cons maped (loop (+ 1 i)))
                  (loop (+ 1 i)))))))))

  ))


