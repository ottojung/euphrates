
(cond-expand
 (guile
  (define-module (euphrates string-to-seconds-columned)
    :export (string->seconds/columned)
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates range) :select (range))
    :use-module ((euphrates string-split-simple) :select (string-split/simple)))))

;; accepts format like "2:30" or "30:2" or "2:20:3" or "2:20:3.22"


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
        (raisu 'bad-format:expected-all-numbers))
      (loop (cdr filled-out))))

  (+ (* (list-ref filled-out 0) 24 60 60)
     (* (list-ref filled-out 1) 60 60)
     (* (list-ref filled-out 2) 60)
     (* (list-ref filled-out 3) 1)))
