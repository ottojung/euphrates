
(cond-expand
 (guile
  (define-module (test-directory-files)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates directory-files) :select (directory-files)))))

;; directory-files

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
