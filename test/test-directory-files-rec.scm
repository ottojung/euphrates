
%run guile

;; directory-files-rec
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (directory-files-rec) "./src/directory-files-rec.scm"

(let ()
  (assert=HS '(("test/filetests/cdefg" "cdefg" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests"))
             (directory-files-rec "test/filetests")))
