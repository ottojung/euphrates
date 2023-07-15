


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

  (assert= "."
           (path-normalize "."))

  (assert= "."
           (path-normalize "././."))

  (assert= "../.."
           (path-normalize "hello/../../.."))

  (assert= " "
           (path-normalize " "))

  )
