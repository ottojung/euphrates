
(cond-expand
 (guile
  (define-module (euphrates random-choice)
    :export (random-choice)
    :use-module ((euphrates big-random-int) :select (big-random-int)))))



(define (random-choice len alphabet#vector)
  (let ((size (vector-length alphabet#vector)))
    (let loop ((len len) (buf '()))
      (if (<= len 0) buf
          (loop (- len 1)
                (cons (vector-ref alphabet#vector (big-random-int size))
                      buf))))))

