
(define-syntax syntax-tree-foreach
  (syntax-rules ()
    [(_ f ((xs ...) ys ...))
     (begin (syntax-tree-foreach f (xs ...))
            (syntax-tree-foreach f (ys ...)))]
    [(_ f (x xs ...))
     (begin (f x)
            (syntax-tree-foreach f (xs ...)))]
    [(_ f ())
     (begin)]))

;; Example:
;; (define-syntax defn
;;   (syntax-rules ()
;;     ((_ m)
;;      (define m #f))))
;; (syntax-tree-foreach defn (a (b (c d)) e)) ;; declares all identifiers
