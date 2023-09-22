;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This is a simplified interface to lalr-parser.scm
;; This parser is very fast,
;; but the original one can be even faster,
;; IF you tweak its parameters, like define a more specific lexer.

(define (lalr-parser/simple arguments)
  (define options
    (keylist->alist arguments))

  (lalr-parser/simple-check-options options)

  (define translate-option
    (fn-pair
     (key value)
     (define key* (gkeyword->fkeyword key))
     (define value*
       (if (memq key* (list 'driver: 'output: 'on-conflict:))
           (list value)
           value))
     (cons key* value*)))

  (define options*
    (map translate-option options))

  (define rules/0
    (assq-or 'grammar: options*
             ;; TODO: make grammar optional.
             (raisu* :from "lalr-parser/simple"
                     :type 'missing-argument
                     :message (stringf "Missing required argument ~s" (~a 'grammar:))
                     :args (list 'grammar:))))

  (define rules/0a
    (semis-ebnf-tree->ebnf-tree rules/0))

  (define (lalr-parser/simple-escape-re yield name t) t)
  (define ebnf-parser
    (generic-ebnf-tree->alist
     '= '/ lalr-parser/simple-escape-re))

  (define rules/1
    (ebnf-parser rules/0a))

  (define-values (rules/2 taken-token-names-set tokens-map)
    (lalr-parser/simple-extract-regexes rules/1))

  (define lexer
    (make-lalr-lexer/singlechar
     taken-token-names-set tokens-map))

  (define additional-grammar-rules
    (lalr-lexer/singlechar:additional-grammar-rules lexer))

  (define rules
    (append rules/2 additional-grammar-rules))

  (define non-terminals
    (list->hashset (map car rules)))

  (define (initialize-lexer input)
    (define lexer-result
      (lalr-lexer/singlechar:run-on-string lexer input))

    (define lexer-iterator
      (lalr-lexer/singlechar-result:as-iterator lexer-result))

    lexer-iterator)

  (define tokens/0
    (map car tokens-map))

  (define tokens
    (let ((S (list->hashset tokens/0)))
      (let loop ((term additional-grammar-rules))
        (cond
         ((list? term) (for-each loop term))
         ((symbol? term)
          (unless (hashset-has? non-terminals term)
            (hashset-add! S term)))))

      (hashset-foreach
       (lambda (nt)
         (when (hashset-has? S nt)
           (hashset-delete! S nt)))
       non-terminals)

      (hashset->list S)))

  (when (assq-or 'tokens: options*)
    (raisu* :from "lalr-parser/simple"
            :type 'invalid-argument ;; TODO: make tokens: optionally settable
            :message "This parser handles tokens automatically, no need to provide them"
            :args (list (assq-or 'tokens: options*))))

  (define (extract+check key)
    (define-values (ret set-list)
      (lalr-parser/simple-extract-set key options*))
    (lalr-parser/simple-check-set non-terminals set-list)
    (cons key ret))

  (define flattened (extract+check 'flatten:))
  (define joined  (extract+check 'join:))
  (define skiped (extract+check 'skip:))
  (define inlined (extract+check 'inline:))

  (define transformations
    (list flattened joined skiped inlined))

  (define options-to-upstream
    (assq-set-value
     'rules: rules
     (assq-set-value
      'tokens: tokens
      (assq-unset-multiple-values
       (list 'inline:
             'skip:
             'join:
             'flatten:
             'grammar:)
       options*))))

  (define backend-parser
    (lalr-parser options-to-upstream))

  (lambda (errorp input)
    (lalr-parser/simple-transform-result
     transformations
     (lalr-parser/simple-do-char->string
      (lalr-parser-run/with-error-handler
       backend-parser errorp (initialize-lexer input))))))
