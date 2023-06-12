

;; path-replace-extension

(let ()
  (assert=
   "file.b.c"
   (path-replace-extension "file.b.a" ".c")))
