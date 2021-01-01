
%run guile

%var list-combinations

%for (COMPILER "guile")

;; bitwise operations
(use-modules (srfi srfi-60))

(define (bitwise-bit-set? x i) (bit-set? i x))

%end

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

;; Generate combinations of the list `l`.
;; - If `k` is a natural number, generate all combinations of size `k`.
;; - If `k` is #f, generate all combinations of any size (powerset of `l`).
(define list-combinations
  (case-lambda
   ((l) (list-combinations l #f))
   ((l k)
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
          '())))))

