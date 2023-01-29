
(cond-expand
 (guile
  (define-module (euphrates syntax-tree-foreach)
    :export (syntax-tree-foreach))))


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
;; (define-syntax-rule (defn m)
;;   (define m #f))
;; (syntax-tree-foreach defn (a (b (c d)) e)) ;; declares all identifiers

