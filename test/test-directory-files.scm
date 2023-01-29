
%run guile

;; directory-files
%use (assert=HS) "./euphrates/assert-equal-hs.scm"
%use (directory-files) "./euphrates/directory-files.scm"

(assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files "test/filetests"))

(assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files #f "test/filetests"))

(assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files #t "test/filetests"))

(assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files #t "test/filetests/"))

(assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files #t "test///filetests////"))
