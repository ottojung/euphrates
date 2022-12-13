
%run guile

%use (assert=HS) "./src/assert-equal-hs.scm"
%use (directory-files-depth-iter) "./src/directory-files-depth-iter.scm"

(define iter
  (directory-files-depth-iter 9 "test/filetests"))

(define collect
  (let loop ()
    (define x (iter))
    (if x (cons x (loop)) '())))

(assert=HS '(("test/filetests/cdefg" "cdefg" "test/filetests") ("test/filetests/dir2" "dir2" "test/filetests") ("test/filetests/dir1" "dir1" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1" "dir1" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests"))
           collect)

(define iter/no-dirs
  (directory-files-depth-iter #t 9 "test/filetests"))

(define collect/no-dirs
  (let loop ()
    (define x (iter/no-dirs))
    (if x (cons x (loop)) '())))

(assert=HS '(("test/filetests/cdefg" "cdefg" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests"))
           collect/no-dirs)
