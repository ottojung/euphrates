



;; recursive tree structure
(define-type9 <rtree>
  (rtree ref value children) rtree?
  (ref rtree-ref set-rtree-ref!)
  (value rtree-value)
  (children rtree-children set-rtree-children!)
  )
