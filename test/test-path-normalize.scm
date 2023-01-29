
(cond-expand
 (guile
  (define-module (test-path-normalize)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates path-normalize) :select (path-normalize)))))


(let () ;; path-normalize
  (assert= "../../some/to/a/dir"
           (path-normalize "../.././some/path/../to/a/dir/."))

  (assert= "/some/to/a/dir"
           (path-normalize "/../.././some/path/../to/a/dir/."))

  (assert= "/some/to/a/dir"
           (path-normalize "/../.././some/path/../to/a/dir/"))

  (assert= "/some/to/a/dir"
           (path-normalize "/../.././some/path/../to/a/dir///"))

  (assert= "/some/to/a"
           (path-normalize "/../.././some/path/../to/a/dir///.."))

  (assert= "/"
           (path-normalize "/"))
  (assert= "/"
           (path-normalize "//"))
  (assert= "/"
           (path-normalize "/////"))
  (assert= "/"
           (path-normalize "/././"))
  (assert= "/"
           (path-normalize "/././../.././"))
  (assert= "/"
           (path-normalize "/././../.././."))
  (assert= "/"
           (path-normalize "/././../.././.."))

  (assert= ""
           (path-normalize ""))

  (assert= " "
           (path-normalize " "))

  )
