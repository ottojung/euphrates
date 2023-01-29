
(cond-expand
 (guile
  (define-module (euphrates list-tag-prev)
    :export (list-tag/prev list-tag/prev/rev))))


(define (list-tag/prev/rev last-tag predicate L)
  (let loop ((rest L) (buf '()) (prev '()) (cur #f))
    (cond
     ((null? rest)
      (cons (cons last-tag prev) buf))
     ((predicate (car rest))
      (loop (cdr rest) ;; rest
            (cons (cons (car rest) prev) buf) ;; buf
            '() ;; prev
            #f)) ;; cur
     (else
      (loop (cdr rest) ;; rest
            buf ;; buf
            (cons (car rest) prev) ;; prev
            cur)))))

;; Returns a list in following shape:
;; (cons ,tag ,prev)
;; where ,tag is an element of ,L but ,prev is a list
;; NOTE: ,prev is reversed!
(define (list-tag/prev last-tag predicate L)
  (reverse (list-tag/prev/rev last-tag predicate L)))
