
(let ()
  (assert= "some contents\nhere for the tests\n\n\nthe end\n" (read-string-file (append-posix-path "test" "filetests" "cdefg"))))

(let ()
  (assert= "" (read-string-file (append-posix-path "test" "filetests" "dir1" "ab"))))
