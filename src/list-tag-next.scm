
%run guile

%var list-tag/next
%var list-tag/next/rev
%var list-untag/next

(define (list-tag/next/rev first-tag predicate L)
  (let loop ((rest L) (buf '()) (next '()) (cur first-tag))
    (cond
     ((null? rest)
      (cons (cons cur (reverse next)) buf))
     ((predicate (car rest))
      (loop (cdr rest) ;; rest
            (cons (cons cur (reverse next)) buf) ;; buf
            '() ;; next
            (car rest))) ;; cur
     (else
      (loop (cdr rest) ;; rest
            buf ;; buf
            (cons (car rest) next) ;; next
            cur)))))

;; Returns a list in following shape:
;; (cons ,tag ,next)
;; where ,tag is an element of ,L but ,next is a list
(define (list-tag/next first-tag predicate L)
  (reverse (list-tag/next/rev first-tag predicate L)))

(define (list-untag/next L)
  (cdr (apply append L))) ;; cdr because need to drop first-tag
