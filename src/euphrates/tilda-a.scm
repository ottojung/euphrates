
(define (~a x)
  (cond
   ((string? x) x)
   ((number? x) (number->string x))
   ((symbol? x) (symbol->string x))
   (else (stringf "~a" x))))
