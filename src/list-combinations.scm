
%run guile

%var list-combinations

%for (COMPILER "guile")

;; bitwise operations
(use-modules (srfi srfi-60))

(define (bitwise-bit-set? x i) (bit-set? i x))

%end

(define (with-repetitions/fixed alphabet-lst size)
  (define v (make-vector size))
  (define A (list->vector alphabet-lst))
  (define A-size (vector-length A))
  (define M (- A-size 1))
  (define yM (- size 1))

  (define (a-vector->list v)
    (let loop ((i 0) (buf '()))
      (if (>= i size) buf
          (loop (+ 1 i)
                (cons (vector-ref A (vector-ref v i)) buf)))))

  (let loop ((i 0))
    (when (> size i)
      (vector-set! v i 0)
      (loop (+ 1 i))))

  (cons
   (a-vector->list v)
   (let loop ((y 0))
     (let ((x (vector-ref v y)))
       (if (= x M)
           (if (= y yM) '()

               (begin
                 (let rloop ((y2 y))
                   (when (>= y2 0)
                     (vector-set! v y2 0)))

                 (loop (+ 1 y))))
           (begin
             (vector-set! v y (+ 1 x))
             (cons (a-vector->list v)
                   (loop 0))))))))

(define (with-repetitions/infinite alphabet-lst callback)
  (define v (make-vector 10))
  (define A (list->vector alphabet-lst))
  (define A-size (vector-length A))
  (define M (- A-size 1))

  (define (prefix-zero-count v)
    (let ((s (vector-length v)))
      (let loop ((i 0))
        (cond
         ((>= i s) s)
         ((= 0 (vector-ref v i)) (loop (+ 1 i)))
         (else i)))))

  (define (a-vector->list v s)
    (let loop ((i 0) (buf '()))
      (if (>= i s) buf
          (loop (+ 1 i)
                (cons (vector-ref A (vector-ref v i)) buf)))))

  (define (vector-resize!)
    (let ((ret (make-vector (+ 1 (vector-length v)) 0)))
      (let loop ((i (- (vector-length v) 1)))
        (when (>= i 0)
          (vector-set! ret i (vector-ref v i))
          (loop (- i 1))))
      (set! v ret)))

  (let loop ((i 0))
    (when (> (vector-length v) i)
      (vector-set! v i 0)
      (loop (+ 1 i))))

  (when (callback (a-vector->list v 0))
    (let loop ((y 0) (m 0))
      (let ((x (vector-ref v y)))
        (if (= x M)
            (begin
              (when (= y (- (vector-length v) 1))
                (vector-resize!))

              (let rloop ((y2 y))
                (when (>= y2 0)
                  (vector-set! v y2 0)))

              (loop (+ 1 y) (max (+ y 1) m)))
            (begin
              (vector-set! v y (+ 1 x))
              (when (callback (a-vector->list v (+ 1 m)))
                (loop 0 m))))))))

(define-syntax-rule (list-fold (acc-name acc-value)
                               (i-name i-value)
                               . bodies)
  (let loop ((acc-name acc-value) (i-all i-value))
    (if (null? i-all) acc-name
        (let ((i-name (car i-all)))
          (let ((new-acc (begin . bodies)))
            (loop new-acc (cdr i-all)))))))

(define range-to
  (case-lambda
    ((start to incr)
     (if (= to start) '()
         (cons start (range-to (+ incr start) to incr))))
    ((to)
     (range-to 0 to 1))))

;; adopted from: https://github.com/racket/racket/blob/master/racket/collects/racket/list.rkt
;; license: MIT
(define (no-repetitions l k)
  (define (increment x) (+ 1 x))
  (define v (list->vector l))
  (define N (vector-length v))
  (define N-1 (- N 1))
  (define (vector-ref/bits v b)
    (list-fold [acc '()]
               [i (range-to N-1 -1 -1)]
               (if (bitwise-bit-set? b i)
                   (cons (vector-ref v i) acc)
                   acc)))
  (define-values (first last incr)
    (cond
     [(not k)
      ;; Enumerate all binary numbers [1..2**N].
      (values 0 (- (expt 2 N) 1) increment)]
     [(< N k)
      ;; Nothing to produce
      (values 1 0 values)]
     [else
      ;; Enumerate numbers with `k` ones, smallest to largest
      (let* ((first (- (expt 2 k) 1))
             (gospers-hack ;; https://en.wikipedia.org/wiki/Combinatorial_number_system#Applications
              (if (zero? first)
                  increment
                  (lambda (n)
                    (let* ([u (bitwise-and n (- n))]
                           [v (+ u n)])
                      (+ v (arithmetic-shift (quotient (bitwise-xor v n) u) -2)))))))
        (values first (arithmetic-shift first (- N k)) gospers-hack))]))

  (let loop ((curr first))
    (if (<= curr last)
        (cons (vector-ref/bits v curr)
              (loop (incr curr)))
        '())))

(define list-combinations
  (case-lambda
   ((l) (list-combinations l #f #f))
   ((l k) (list-combinations l k #f))
   ((l k repetitions-callback)
    (if repetitions-callback
        (if k
            (with-repetitions/fixed l k)
            (with-repetitions/infinite l repetitions-callback))
        (no-repetitions l k)))))

