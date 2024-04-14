;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



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
