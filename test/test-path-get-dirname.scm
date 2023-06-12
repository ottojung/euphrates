
(cond-expand
 (guile
  (define-module (test-path-get-dirname)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates path-get-dirname) :select (path-get-dirname))
    )))

(let ()
  (assert=
   "/home/user/Documents"
   (path-get-dirname "/home/user/Documents/file.txt"))

  (assert=
   "home"
   (path-get-dirname "home/user"))

  (assert=
   "/home"
   (path-get-dirname "/home/user/"))

  (assert=
   "/home"
   (path-get-dirname "/home/user////"))

  (assert=
   "/home"
   (path-get-dirname "/home////user////"))

  (assert=
   "/"
   (path-get-dirname "/home"))

  (assert=
   "/"
   (path-get-dirname "/"))

  (assert=
   "/"
   (path-get-dirname "////"))

  (assert=
   "/"
   (path-get-dirname "////home"))

  (assert=
   "/"
   (path-get-dirname "////home///"))

  (assert=
   "."
   (path-get-dirname "home"))

  (assert=
   "."
   (path-get-dirname ""))

  )
