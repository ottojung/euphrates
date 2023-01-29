
(cond-expand
 (guile
  (define-module (test-path-replace-extension)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates path-replace-extension) :select (path-replace-extension)))))

;; path-replace-extension

(let ()
  (assert=
   "file.b.c"
   (path-replace-extension "file.b.a" ".c")))
