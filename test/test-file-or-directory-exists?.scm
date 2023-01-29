
(cond-expand
 (guile
  (define-module (test-file-or-directory-exists?)
    :use-module ((euphrates append-posix-path) :select (append-posix-path))
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates file-or-directory-exists-q) :select (file-or-directory-exists?)))))

;; file-or-directory-exists?

(let ()
  (assert (file-or-directory-exists? "/"))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir1" "ab")))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir2")))
  (assert (not (file-or-directory-exists? (append-posix-path "test" "filetests" "dir3")))))
