
%run guile

%var monad-filter

%use (monad-replace) "./monad-replace.scm"
%use (raisu) "./raisu.scm"

;; Skips evaluation based on given predicate
;; NOTE: don't use on multiple-values!
(define (monad-filter test-any)
  (monad-replace
   (lambda (tags arg#lazy)
     (if (or-map test-any tags)
         (lambda _ (raisu 'filter-monad-skipped-evaluation))
         arg#lazy))))
