
%run guile

;; path-replace-extension
%use (assert=) "./src/assert-equal.scm"
%use (path-replace-extension) "./src/path-replace-extension.scm"

(let ()
  (assert=
   "file.b.c"
   (path-replace-extension "file.b.a" ".c")))
