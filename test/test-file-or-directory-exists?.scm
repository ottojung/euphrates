
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates append-posix-path)
           append-posix-path))
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates file-or-directory-exists-q)
           file-or-directory-exists?))
   (import
     (only (scheme base) begin cond-expand let not))))


;; file-or-directory-exists?

(let ()
  (assert (file-or-directory-exists? "/"))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir1" "ab")))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir2")))
  (assert (not (file-or-directory-exists? (append-posix-path "test" "filetests" "dir3")))))
