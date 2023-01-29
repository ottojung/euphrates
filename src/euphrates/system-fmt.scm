;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(cond-expand
 (guile
  (define-module (euphrates system-fmt)
    :export (system-fmt)
    :use-module ((euphrates system-star-exit-code) :select (system*/exit-code))
    :use-module ((euphrates stringf) :select (stringf))
    :use-module ((euphrates shell-quote-permissive) :select (shell-quote/permissive))
    :use-module ((euphrates tilda-a) :select (~a)))))

;; Escapes all args, so variable substitution won't work!
;; i.e. (system-re "cat ~a" "$HOME/.bashrc") => will invoke `cat '$HOME/.bashrc'` and will not work :(
;; correct usage:
;;      (system-re "cat \"$HOME\"/~a" ".bashrc") => will invoke `cat \"$HOME\"'/.bashrc'` :)
;; or:
;;      (system-re "cat ~a" (string-append (getenv "HOME") "/.bashrc") => will invoke `cat '/home/user/.bashrc'` :)
;;
;; Returns exit code, which is a number.


(define (system-fmt fmt . args)
  (let* ((command (apply stringf (cons fmt (map (compose shell-quote/permissive ~a) args)))))
    (system*/exit-code "/bin/sh" "-c" command)))
