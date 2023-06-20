
;; Quoted version of (case symbol ((val1 val2 ...) bodies...)...)
;; But only one case is allowed! So it's like
;;  (caseq symbol
;;    ('a (fun-a))
;;    ('b (fun-b))
;;    (else (fun-else))

(define-syntax caseq/callback
  (syntax-rules ()
    ((_ sym buf) (case sym . buf))))

(define-syntax caseq/helper
  (syntax-rules (quote else)
    ((_ sym buf)
     (syntax-reverse (caseq/callback sym) buf))
    ((_ sym buf (else . bodies))
     (caseq/helper
      sym ((else . bodies) . buf)))
    ((_ sym buf ((quote x) . bodies) . clauses)
     (caseq/helper
      sym (((x) . bodies) . buf)
      . clauses))))

(define-syntax caseq
  (syntax-rules ()
    ((_ sym clause . clauses)
     (caseq/helper
      sym () clause . clauses))))
