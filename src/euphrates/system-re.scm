
(cond-expand
 (guile
  (define-module (euphrates system-re)
    :export (system-re)
    :use-module ((euphrates make-temporary-filename) :select (make-temporary-filename))
    :use-module ((euphrates read-string-file) :select (read-string-file))
    :use-module ((euphrates string-trim-chars) :select (string-trim-chars))
    :use-module ((euphrates system-star-exit-code) :select (system*/exit-code))
    :use-module ((euphrates stringf) :select (stringf))
    :use-module ((euphrates file-delete) :select (file-delete))
    :use-module ((euphrates shell-quote-permissive) :select (shell-quote/permissive))
    :use-module ((euphrates tilda-a) :select (~a)))))


;; Escapes all args, so variable substitution won't work!
;; i.e. (system-re "cat ~a" "$HOME/.bashrc") => will invoke `cat '$HOME/.bashrc'` and will not work :(
;; correct usage:
;;      (system-re "cat \"$HOME\"/~a" ".bashrc") => will invoke `cat \"$HOME\"'/.bashrc'` :)
;; or:
;;      (system-re "cat ~a" (string-append (getenv "HOME") "/.bashrc") => will invoke `cat '/home/user/.bashrc'` :)

(define (system-re fmt . args)
  "Like `system', but returns (output, exit status)"
  (let* ((command (apply stringf (cons fmt (map (compose shell-quote/permissive ~a) args))))
         (temp (make-temporary-filename))
         (p (system*/exit-code
             "/bin/sh" "-c"
             (string-append "/bin/sh -c " (shell-quote/permissive command) " > " temp)))
         (output (read-string-file temp)))
    (file-delete temp)
    (cons output p)))
