
;; accepts format like "2h30m" or "30m2h" or "2h20s3m" or "2.5h20s3m"
;;                             or "30 minutes and 2 hours"
;;                             or "30 minutes and 1 hour"
;;                             or "30 minutes and2hours"
;;                             or "30 MINUTEs and 2 hoUrS"
;;                             or "30.05 MINUTEs and 2 hoUrS"
;;                             or "30.05 MINUTEs + 2 hoUrS"

(define string->seconds
  (let ()
    (define time-table
      '((s . 1)
        (m . 60)
        (h . 3600)
        (d . ,(* 24 60 60 60))
        (w . ,(* 7 24 60 60 60))
        (second . 1)
        (seconds . 1)
        (sec . 1)
        (minute . 60)
        (minutes . 60)
        (min . 60)
        (hour . 3600)
        (hours . 3600)
        (day . ,(* 24 60 60 60))
        (days . ,(* 24 60 60 60))
        (week . ,(* 7 24 60 60 60))
        (weeks . ,(* 7 24 60 60 60))))

    (lambda (s)
      (define lst (string->list s))
      (define (class c)
        (cond ((char-numeric? c) 'numeric)
              ((equal? #\. c) 'numeric)
              ((char-whitespace? c) 'white)
              (else 'other)))
      (define groups
        (group-by/sequential (lambda (a b) (equal? (class a) (class b)))
                             lst))

      (define parsed-groups
        (map (compose-under or
                            (compose-under-seq and string->number inexact->exact)
                            (compose string->symbol string-downcase))
             (filter (negate string-null-or-whitespace?)
                     (map list->string groups))))

      (define result
        (let loop ((lst parsed-groups) (last #f))
          (if (null? lst)
              (cond
               ((number? last) last)
               ((equal? #f last) 0)
               (else
                (raisu 'bad-format-for-string->seconds "String ends too soon, expected a number")))
              (let ((x (car lst)))
                (cond
                 ((number? x)
                  (if (number? last)
                      (raisu 'bad-format-for-string->seconds "Expected a modifier, but got a number" x)
                      (loop (cdr lst) x)))
                 ((memq x '(and +))
                  (if (number? last)
                      (raisu 'bad-format-for-string->seconds "Expected a modifier, but got a connector" x)
                      (loop (cdr lst) last)))
                 (last
                  (let ((modifier (assq-or x time-table #f)))
                    (if modifier
                        (if (number? last)
                            (+ (* modifier last) (loop (cdr lst) #f))
                            (raisu 'bad-format-for-string->seconds "Expected a number, but got a modifier" x))
                        (raisu 'bad-format-for-string->seconds "Expected a modifier, but got an unrecognized word" x))))
                 (else
                  (raisu 'bad-format-for-string->seconds "Expected a number, but got a word" x)))))))

      (if (integer? result)
          result
          (exact->inexact result)))))
