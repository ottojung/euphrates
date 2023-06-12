



(define string-strip
  (case-lambda
   ((str) (string-trim-chars str "\r\n \t" 'both))
   ((str chars) (string-trim-chars str chars 'both))))
