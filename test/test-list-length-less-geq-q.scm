
%run guile

;; list-length-less-geq-q
%use (assert) "./src/assert.scm"
%use (list-length=<?) "./src/list-length-geq-q.scm"

(let ()

  (assert (list-length=<? 3 '(1 2 3 4 5 6)))
  (assert (list-length=<? 3 '(1 2 3)))
  (assert (not (list-length=<? 3 '(1 2))))
  (assert (list-length=<? 0 '()))
  (assert (list-length=<? -3 '(1 2)))
  (assert (list-length=<? -3 '()))

  )
