
%run guile

;; file-or-directory-exists?
%use (append-posix-path) "./euphrates/append-posix-path.scm"
%use (assert) "./euphrates/assert.scm"
%use (file-or-directory-exists?) "./euphrates/file-or-directory-exists-q.scm"

(let ()
  (assert (file-or-directory-exists? "/"))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir1" "ab")))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir2")))
  (assert (not (file-or-directory-exists? (append-posix-path "test" "filetests" "dir3")))))
