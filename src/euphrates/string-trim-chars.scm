


(define (string-trim-chars str chars-arg direction)
  (define chars (if (string? chars-arg)
                    (string->list chars-arg)
                    chars-arg))
  (define (pred c)
    (memv c chars))
  (case direction
    ((left) (string-trim str pred))
    ((right) (string-trim-right str pred))
    ((both) (string-trim-both str pred))))
