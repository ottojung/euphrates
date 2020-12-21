
%run guile

%use (big-random-int) "./big-random-int.scm"

%var random-choice

(define (random-choice len alphabet#vector)
  (let ((size (vector-length alphabet#vector)))
    (let loop ((len len) (buf (list)))
      (if (<= len 0) buf
          (loop (- len 1)
                (cons (vector-ref alphabet#vector (big-random-int size))
                      buf))))))

