;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:folexer:expression:check expr)
  (define expr0 expr)

  (or (labelinglogic:expression? expr)
      (let loop ((expr expr))
        (cond
         ((string? expr) 'ok)
         ((char? expr) 'ok)

         ((pair? expr)

          (unless (list? expr)
            (raisu* :from "parselynn:folexer:expression:check"
                    :type 'improper-list
                    :message (stringf "Expression must be a list, but isn't: ~s" expr)
                    :args (list expr expr0)))

          (let ()
            (define type (car expr))
            (define args (cdr expr))
            (cond

             ((member type (list 'or 'and 'not))
              (for-each loop args))

             ((member type (list 'class))
              (unless (list-singleton? args)
                (raisu* :from "parselynn:folexer:expression:check"
                        :type 'class-arity-bad
                        :message (stringf "Expression of type 'class must be have exactly one argument, but it has ~s, : ~s" (length args) expr)
                        :args (list (length args) expr expr0))))

             (else
              (raisu* :from "parselynn:folexer:expression:check"
                      :type 'unknown-type-of-expr
                      :message (stringf "Expression type ~s unrecognized: ~s" type expr)
                      :args (list type expr expr0))))))

         ((labelinglogic:expression? expr)
          (raisu* :from "parselynn:folexer:expression:check"
                  :type 'expression-type-not-supported
                  :message (stringf "Expression ~s from labelinglogic is not supported in folexer" expr)
                  :args (list expr expr0)))

         (else
          (raisu* :from "parselynn:folexer:expression:check"
                  :type 'unknown-object-type
                  :message (stringf "Object unrecognized: ~s" expr)
                  :args (list expr expr0)))))))
