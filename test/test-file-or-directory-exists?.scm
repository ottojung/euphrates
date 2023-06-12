

;; file-or-directory-exists?

(let ()
  (assert (file-or-directory-exists? "/"))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir1" "ab")))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir2")))
  (assert (not (file-or-directory-exists? (append-posix-path "test" "filetests" "dir3")))))
