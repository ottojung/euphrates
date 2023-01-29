
(cond-expand
 (guile
  (define-module (euphrates tilda-a)
    :export (~a))))


(define (~a x)
  (cond
   ((string? x) x)
   ((number? x) (number->string x))
   ((symbol? x) (symbol->string x))
   (else
    (with-output-to-string
      (lambda _
        (display x))))))


