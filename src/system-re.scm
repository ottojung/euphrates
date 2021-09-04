
%run guile

%use (make-temporary-filename) "./make-temporary-filename.scm"
%use (read-string-file) "./read-string-file.scm"
%use (string-trim-chars) "./string-trim-chars.scm"
%use (system*/exit-code) "./system-star-exit-code.scm"
%use (stringf) "./stringf.scm"
%use (file-delete) "./file-delete.scm"
%use (shell-quote/permissive) "./shell-quote-permissive.scm"
%use (~a) "./tilda-a.scm"

;; Escapes all args, so variable substitution won't work!
;; i.e. (system-re "cat ~a" "$HOME/.bashrc") => will invoke `cat '$HOME/.bashrc'` and will not work :(
;; correct usage:
;;      (system-re "cat \"$HOME\"/~a" ".bashrc") => will invoke `cat \"$HOME\"'/.bashrc'` :)
;; or:
;;      (system-re "cat ~a" (string-append (getenv "HOME") "/.bashrc") => will invoke `cat '/home/user/.bashrc'` :)
%var system-re

(define (system-re fmt . args)
  "Like `system', but returns (output, exit status)"
  (let* ((command (apply stringf (cons fmt (map (compose shell-quote/permissive ~a) args))))
         (temp (make-temporary-filename))
         (p (system*/exit-code
             "/bin/sh" "-c"
             (string-append "/bin/sh -c " (shell-quote/permissive command) " > " temp)))
         (output (read-string-file temp))
         (trimed (string-trim-chars output "\n \t" 'both)))
    (file-delete temp)
    (cons trimed p)))
