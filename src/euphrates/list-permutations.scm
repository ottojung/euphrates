


;; adopted from: https://github.com/racket/racket/blob/master/racket/collects/racket/list.rkt#L691
;; license: MIT

;; This implements an algorithm known as "Ord-Smith".  (It is described in a
;; paper called "Permutation Generation Methods" by Robert Sedgewlck, listed as
;; Algorithm 8.)  It has a number of good properties: it is very fast, returns
;; a list of results that has a maximum number of shared list tails, and it
;; returns a list of reverses of permutations in lexical order of the input,
;; except that the list itself is reversed so the first permutation is equal to
;; the input and the last is its reverse.  In other words, (map reverse
;; (permutations (reverse l))) is a list of lexicographically-ordered
;; permutations (but of course has no shared tails at all -- I couldn't find
;; anything that returns sorted results with shared tails efficiently).  I'm
;; not listing these features in the documentation, since I'm not sure that
;; there is a need to expose them as guarantees -- but if there is, then just
;; revise the docs.  (Note that they are tested.)
;;
;; In addition to all of this, it has just one loop, so it is easy to turn it
;; into a "streaming" version that spits out the permutations one-by-one, which
;; could be used with a "callback" argument as in the paper, or can implement
;; an efficient `in-permutations'.  It uses a vector to hold state -- it's easy
;; to avoid this and use a list instead (in the loop, the part of the c vector
;; that is before i is all zeros, so just use a list of the c values from i and
;; on) -- but that makes it slower (by about 70% in my timings).
(define (swap+flip l i j)
  ;; this is the main helper for the code: swaps the i-th and j-th items, then
  ;; reverses items 0 to j-1; with special cases for 0,1,2 (which are
  ;; exponentially more frequent than others)
  (case j
    [(0) `(,(cadr l) ,(car l) ,@(cddr l))]
    [(1) (let ([a (car l)] [b (cadr l)] [c (caddr l)] [l (cdddr l)])
           (case i [(0)  `(,b ,c ,a ,@l)]
                 [else `(,c ,a ,b ,@l)]))]
    [(2) (let ([a (car l)] [b (cadr l)] [c (caddr l)] [d (cadddr l)]
               [l (cddddr l)])
           (case i [(0)  `(,c ,b ,d ,a ,@l)]
                 [(1)  `(,c ,d ,a ,b ,@l)]
                 [else `(,d ,b ,a ,c ,@l)]))]
    [else (let loop ([n i] [l1 '()] [r1 l])
            (if (> n 0) (loop (- n 1) (cons (car r1) l1) (cdr r1))
                (let loop ([n (- j i)] [l2 '()] [r2 (cdr r1)])
                  (if (> n 0) (loop (- n 1) (cons (car r2) l2) (cdr r2))
                      `(,@l2 ,(car r2) ,@l1 ,(car r1) ,@(cdr r2))))))]))

(define (list-permutations l)
  (cond
   [(or (null? l) (null? (cdr l))) (list l)]
   [else
    (let* ((N (- (length l) 2))
           (c (make-vector (+ 1 N) 0)))
      (let loop ([i 0] [acc (list (reverse l))])
        (let ((ci (vector-ref c i)))
          (cond [(<= ci i) (vector-set! c i (+ 1 ci))
                 (loop 0 (cons (swap+flip (car acc) ci i) acc))]
                [(< i N)   (vector-set! c i 0)
                 (loop (+ 1 i) acc)]
                [else      acc]))))]))
