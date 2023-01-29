
(cond-expand
 (guile
  (define-module (euphrates rtree)
    :export (rtree rtree? rtree-ref set-rtree-ref! rtree-value rtree-children set-rtree-children!)
    :use-module ((euphrates define-type9) :select (define-type9)))))



;; recursive tree structure
(define-type9 <rtree>
  (rtree ref value children) rtree?
  (ref rtree-ref set-rtree-ref!)
  (value rtree-value)
  (children rtree-children set-rtree-children!)
  )
