
%run guile

%use (make-temporary-filename) "./make-temporary-filename.scm"
%use (read-string-file) "./read-string-file.scm"
%use (string-trim-chars) "./string-trim-chars.scm"
%use (system*/exit-code) "./system-star-exit-code.scm"
%use (stringf) "./stringf.scm"
%use (file-delete) "./file-delete.scm"

%var system-re

(define (system-re fmt . args)
  "Like `system', but returns (output, exit status)"
  (let* ((command (apply stringf (cons fmt args)))
         (temp (make-temporary-filename))
         (p (system*/exit-code "/bin/sh" "-c"
                               (string-append command " > " temp)))
         (output (read-string-file temp))
         (trimed (string-trim-chars output "\n \t" 'both)))
    (file-delete temp)
    (cons trimed p)))
