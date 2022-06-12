
%run guile

;; accepts format like "2:30" or "30:2" or "2:20:3" or "2:20:3.22"
%var string->seconds/columned

%use (raisu) "./raisu.scm"
%use (range) "./range.scm"
%use (string-split/simple) "./string-split-simple.scm"

(define (string->seconds/columned s)
  (define L (string-split/simple s #\:))
  (define len (length L))
  (define _124124
    (when (> len 4)
      (raisu 'bad-format:expected-4-components-but-got len)))
  (define nums (map string->number L))
  (define filled-out
    (append
     (map (const 0)
          (range (- 4 len)))
     nums))

  (let loop ((filled-out filled-out))
    (unless (null? filled-out)
      (unless (number? (car filled-out))
        (raisu 'bad-format:expected-all-numbers))))

  (+ (* (list-ref filled-out 0) 24 60 60)
     (* (list-ref filled-out 1) 60 60)
     (* (list-ref filled-out 2) 60)
     (* (list-ref filled-out 3) 1)))
