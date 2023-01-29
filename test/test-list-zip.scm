
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (list-zip) "./euphrates/list-zip.scm"

(let () ;; list-zip
  (assert= '((1 . a) (2 . b) (3 . c))
           (list-zip '(1 2 3) '(a b c)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2 3) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b c)))
  (assert= '()
           (list-zip '() '(a b c)))
  )
