
(cond-expand
 (guile
  (define-module (test-directory-files-depth-iter)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates directory-files-depth-iter) :select (directory-files-depth-iter)))))


(define iter
  (directory-files-depth-iter 9 "test/filetests"))

(define collect
  (let loop ()
    (define x (iter))
    (if x (cons x (loop)) '())))

(assert=HS '(("test/filetests/cdefg" "cdefg" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests"))
           collect)

(assert=HS '(("test/filetests/cdefg" "cdefg" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests"))
           collect)

(define iter/with-dirs
  (directory-files-depth-iter #t 9 "test/filetests"))

(define collect/with-dirs
  (let loop ()
    (define x (iter/with-dirs))
    (if x (cons x (loop)) '())))

(assert=HS '(("test/filetests/cdefg" "cdefg" "test/filetests") ("test/filetests/dir2" "dir2" "test/filetests") ("test/filetests/dir1" "dir1" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1" "dir1" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests"))
           collect/with-dirs)
