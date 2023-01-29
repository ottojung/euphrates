
%run guile

;; path-replace-extension
%use (assert=) "./euphrates/assert-equal.scm"
%use (path-replace-extension) "./euphrates/path-replace-extension.scm"

(let ()
  (assert=
   "file.b.c"
   (path-replace-extension "file.b.a" ".c")))
