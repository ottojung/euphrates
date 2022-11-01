
%run guile

%var rtree
%var rtree?
%var rtree-ref
%var set-rtree-ref!
%var rtree-value
%var rtree-children
%var set-rtree-children!

%use (define-dumb-record) "./define-dumb-record.scm"

;; recursive tree structure
(define-dumb-record <rtree>
  (rtree ref value children) rtree?
  (ref rtree-ref set-rtree-ref!)
  (value rtree-value)
  (children rtree-children set-rtree-children!)
  )
