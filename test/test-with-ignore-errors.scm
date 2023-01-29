
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (raisu) "./euphrates/raisu.scm"
%use (string->words) "./euphrates/string-to-words.scm"
%use (with-ignore-errors!) "./euphrates/with-ignore-errors.scm"

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
