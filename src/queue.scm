
%run guile

%use (make-unique) "./make-unique.scm"

%var make-queue
%var queue-empty?
%var queue-peek
%var queue-push!
%var queue-pop!

(define make-queue
  (case-lambda
   (() (make-queue 10))
   ((initial-size)
    (let ((ret (make-vector 4)))
      (vector-set! ret 0 (make-vector initial-size))
      (vector-set! ret 1 0)
      (vector-set! ret 2 0)
      (vector-set! ret 3 'euphrates-queue)
      ret))))

(define (queue-empty? q)
  (= (vector-ref q 1) (vector-ref q 2)))

(define (queue-peek q)
  (if (= (vector-ref q 1) (vector-ref q 2))
      (throw 'empty-queue-peek)
      (vector-ref (vector-ref q 0) (vector-ref q 1))))

(define (queue-push! q value)
  (let* ((v (vector-ref q 0))
         (first (vector-ref q 1))
         (last (vector-ref q 2))
         (size (vector-length v))
         (last+1 (+ 1 last))
         (new-last (if (< last+1 size) last+1 0))
         (need-realloc? (= new-last first))
         (new-size (* 2 size))
         (v (if (not need-realloc?) v
                    (let ((ret (make-vector new-size)))
                      (let loop ((i 0) (j first))
                        (when (< i size)
                          (vector-set! ret i (vector-ref v j))
                          (loop (+ 1 i) (if (< (+ 1 j) size) (+ 1 j) 0))))
                      (vector-set! q 0 ret)
                      ret))))
    (if need-realloc?
        (begin
          (vector-set! q 1 0)
          (vector-set! q 2 size)
          (vector-set! v (- size 1) value))
        (begin
          (vector-set! q 2 new-last)
          (vector-set! v last value)))))

(define queue-pop!
  (let ((private-default (make-unique)))
    (case-lambda
     ((q)
      (let ((ret (queue-pop! q private-default)))
        (if (eq? private-default ret)
            (throw 'empty-queue-peek)
            ret)))

     ((q default)
      (if (= (vector-ref q 1) (vector-ref q 2)) default
          (let* ((v (vector-ref q 0))
                 (size (vector-length v))
                 (first (vector-ref q 1))
                 (first+1 (+ 1 first))
                 (new-first (if (< first+1 size) first+1 0)))
            (vector-set! q 1 new-first)
            (vector-ref v first)))))))

