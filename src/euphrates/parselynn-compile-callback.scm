;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:compile-callback production callback)
  (cond
   ((symbol? callback)
    (let ()
      (define ret (eval callback parselynn:default-compilation-environment))
      (unless (procedure? ret)
        (raisu* :from "parselynn:compile-callback"
                :type 'expected-procedure-code-for-callback
                :message "Expected callback code that compiles into a procedure."
                :args (list callback)))
      ret))

   ((and (pair? callback)
         (list? callback)
         (symbol? (car callback)))

    (let ()
      (define args
        (map (lambda (i) (string->symbol (string-append "$" (~a i))))
             (iota (+ 1 (length (bnf-alist:production:rhs production))))))

      (eval `(lambda ,args ,callback)
            parselynn:default-compilation-environment)))

   (else
    (raisu* :from "parselynn:compile-callback"
            :type 'expected-code-for-callback
            :message (stringf "Expected code for callback, got ~s." callback)
            :args (list callback)))))
