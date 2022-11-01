
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (raisu) "./src/raisu.scm"
%use (string->words) "./src/string-to-words.scm"
%use (with-ignore-errors!) "./src/with-ignore-errors.scm"

(let () ;; with-ignore-errors
  (assert=
   "error:"
   (cadr
    (string->words
     (with-output-to-string
       (lambda ()
         (parameterize ((current-error-port (current-output-port)))
           (with-ignore-errors!
            (raisu 'test "arg1" "arg2")))))))))
