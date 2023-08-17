;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This is a simplified interface to lalr-parser.scm
;; This parser is very fast,
;; but the original one can be even faster,
;; IF you tweak its parameters, like define a more specific lexer.

(define (lalr-parser/simple arguments)
  (define options
    (keylist->alist arguments))

  (let ((bad-apple
         (list-find-first (negate gkeyword?) #f
                          (map car options))))
    (when bad-apple
      (raisu* :type 'type-error
              :message
              (stringf "Expected a keylist as arguments, but this is not a key: ~s"
                       bad-apple)
              :args (list 'bad-keylist bad-apple))))

  (define translate-option
    (fn-pair
     (key value)
     (define key* (gkeyword->fkeyword key))
     (define value*
       (if (memq key (list 'driver: 'output: 'on-conflict:))
           (list value)
           value))
     (cons key* value*)))

  (define options*
    (map translate-option options))

  (define rules/0
    (assq-or 'rules: options*
             (raisu* :type 'type-error
                     :message (stringf "Missing required argument ~s" (~a 'rules:))
                     :args (list 'missing-argument 'rules:))))

  (define rules/1
    (bnf-tree->alist rules/0))

  (define rules rules/1) ;; TODO: use irregex in grammar

  (define make-lexer make-lalr-lexer/latin) ;; TODO: use irregex in grammar

  (when (assq-or 'tokens: options*)
    (raisu* :type 'type-error ;; TODO: make tokens: optionally settable
            :message "This parser handles tokens automatically, no need to provide them"
            :args (list (assq-or 'tokens: options*))))

  (define options-to-upstream
    (assq-set-value
     'rules: rules
     (assq-set-value
      'tokens: lalr-lexr/latin-tokens
      options*)))

  (define upstream (lalr-parser options-to-upstream))

  (lambda (errorp)
    (upstream (make-lexer) errorp)))
