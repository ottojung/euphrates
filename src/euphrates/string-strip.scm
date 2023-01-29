
(cond-expand
 (guile
  (define-module (euphrates string-strip)
    :export (string-strip)
    :use-module ((euphrates string-trim-chars) :select (string-trim-chars)))))



(define string-strip
  (case-lambda
   ((str) (string-trim-chars str "\r\n \t" 'both))
   ((str chars) (string-trim-chars str chars 'both))))
