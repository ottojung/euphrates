;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic::bindings:check classes/s tokens-alist)

  (define (fail-tokens-check show args)
    (raisu* :from "labelinglogic::init"
            :type 'tokens-alist-type-error
            :message (stringf "Type error in ~s: ~a." (quote tokens-alist) show)
            :args args))

  (unless (list? tokens-alist)
    (fail-tokens-check "must be a list" (list tokens-alist)))

  (when (null? tokens-alist)
    (fail-tokens-check "must be non-empty" (list tokens-alist)))

  (unless (list-and-map pair? tokens-alist)
    (fail-tokens-check "must an alist" (list tokens-alist)))

  (define keys
    (map car tokens-alist))

  (unless (list-and-map symbol? keys)
    (fail-tokens-check
     "every key must be a symbol"
     (list (filter (negate symbol?) keys))))

  (define duplicates
    (list-get-duplicates keys))

  (unless (null? duplicates)
    (fail-tokens-check
     "keys must not repeat"
     (list duplicates)))

  (for-each
   (lambda (binding)
     (unless (list? binding)
       (raisu* :from "labelinglogic"
               :type 'bad-binding
               :message "Binding in labelinglogic must be a list, but was not"
               :args (list binding)))

     (unless (list-length= 2 binding)
       (raisu* :from "labelinglogic"
               :type 'bad-binding-length
               :message "Binding in labelinglogic must have two components, but did not"
               :args (list binding)))

     (define-tuple (name expr) binding)

     (unless (symbol? name)
       (raisu* :from "labelinglogic"
               :type 'bad-expr
               :message "Expression in labelinglogic must be a list, but was not"
               :args (list expr)))

     (labelinglogic::expression::check expr)

     (define constants (labelinglogic::expression:constants expr))

     (define undefined-constants
       (filter (negate (lambda (x) (hashset-has? classes/s x))) constants))

     (unless (null? undefined-constants)
       (raisu* :from "labelinglogic"
               :type 'bad-expr
               :message "Binding references undefined class."
               :args (list expr binding undefined-constants)))

     )

   tokens-alist)

  (when #f #t))
