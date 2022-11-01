
%run guile

%use (alphanum/alphabet/index) "./euphrates/alphanum-alphabet.scm"
%use (catch-any) "./euphrates/catch-any.scm"
%use (debugv) "./euphrates/debugv.scm"
%use (list-and-map) "./euphrates/list-and-map.scm"
%use (list-find-first) "./euphrates/list-find-first.scm"
%use (read-string-file) "./euphrates/read-string-file.scm"
%use (string->words) "./euphrates/string-to-words.scm"
%use (write-string-file) "./euphrates/write-string-file.scm"

(define file "/tmp/tttfile.scm")
(define contents (read-string-file file))
(define words (string->words contents))

(define name
  (list-find-first
   (lambda (word)
     (list-and-map
      (lambda (c)
        (or (alphanum/alphabet/index c)
            (member c '(#\- #\? #\+ #\> #\=))))
      (string->list word)))
   words))

(debugv name)

(define target-fullpath
  (string-append "test-" name ".scm"))

(catch-any
 (lambda _ (delete-file target-fullpath))
 (lambda _ 0))
(catch-any
 (lambda _ (delete-file file))
 (lambda _ 0))

;; (rename-file file target-fullpath)

(write-string-file
 target-fullpath
 (with-output-to-string
   (lambda _
     (newline)
     (display "%run guile")
     (newline)
     (display contents))))

(system* "my-fix-imports" "--" target-fullpath)

(symlink target-fullpath file)

