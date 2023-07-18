
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-equal-hs) assert=HS))
   (import
     (only (euphrates directory-files)
           directory-files))
   (import
     (only (scheme base) begin cond-expand quote))))


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
