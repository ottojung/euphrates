



(define (random-choice len alphabet#vector)
  (let ((size (vector-length alphabet#vector)))
    (let loop ((len len) (buf '()))
      (if (<= len 0) buf
          (loop (- len 1)
                (cons (vector-ref alphabet#vector (big-random-int size))
                      buf))))))

