
%run guile

%use (make-temporary-filename) "./make-temporary-filename.scm"
%use (read-string-file) "./read-string-file.scm"
%use (string-trim-chars) "./string-trim-chars.scm"
%use (system*/exit-code) "./system-star-exit-code.scm"

%var system-re

(define (system-re command)
  "Like `system', but returns (output, exit status)"
  (let* ((temp (make-temporary-filename))
         (p (system*/exit-code "/bin/sh" "-c"
                               (string-append command " > " temp)))
         (output (read-string-file temp))
         (trimed (string-trim-chars output "\n \t" 'both)))
    (cons trimed p)))
