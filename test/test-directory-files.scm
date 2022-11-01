
%run guile

;; directory-files
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (directory-files) "./src/directory-files.scm"

(assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files "test/filetests"))

(assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files "test/filetests" #f))

(assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files "test/filetests" #t))

(assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files "test/filetests/" #t))

(assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
           (directory-files "test///filetests////" #t))
