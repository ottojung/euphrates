
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates path-get-dirname)
           path-get-dirname))
   (import
     (only (scheme base) begin cond-expand let))))


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
