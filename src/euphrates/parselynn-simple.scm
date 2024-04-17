;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This is a simplified interface to parselynn.scm
;; This parser is very fast,
;; but the original one can be even faster,
;; IF you tweak its parameters, like define a more specific lexer.

(define (parselynn:simple arguments)
  (define options
    (keylist->alist arguments))

  (parselynn:simple:check-options options)

  (define translate-option
    (fn-pair
     (key value)
     (define key* (gkeyword->fkeyword key))
     (define value*
       (if (memq key* (list 'driver: 'output: 'on-conflict: 'on-error: 'load: 'sync-to-disk:))
           (list value)
           value))
     (cons key* value*)))

  (define options*
    (map translate-option options))

  (define rules/0
    (assq-or 'grammar: options*
             ;; TODO: make grammar optional.
             (raisu* :from "parselynn:simple"
                     :type 'missing-argument
                     :message (stringf "Missing required argument ~s" (~a 'grammar:))
                     :args (list 'grammar:))))

  (define rules/0a
    (semis-ebnf-tree->ebnf-tree rules/0))

  (define (parselynn:simple:escape-re yield name t) t)
  (define ebnf-parser
    (generic-ebnf-tree->alist
     '= '/ parselynn:simple:escape-re))

  (define rules/1
    (ebnf-parser rules/0a))

  (define-values (rules/2 taken-token-names-set tokens-map)
    (parselynn:simple:extract-regexes rules/1))

  (with-unique-identifier-context
   :existing-names taken-token-names-set

   (define rules/3
     (unique-identifier->symbol/recursive rules/2))

   (define lexer
     (make-parselynn:folexer tokens-map))

   (define additional-grammar-rules
     (parselynn:folexer:additional-grammar-rules lexer))

   (define rules
     (append rules/3 additional-grammar-rules))

   (define base-model
     (parselynn:folexer:base-model lexer))

   (define tokens
     (labelinglogic:model:names base-model))

   (define lexer-code
     (parselynn:folexer:compile/iterator
      lexer))

   (define hidden-tree-labels
     (list->hashset
      (append
       tokens
       (map car additional-grammar-rules))))

   (define non-terminals
     (list->hashset (map car rules)))

   (when (assq-or 'tokens: options*)
     (raisu* :from "parselynn:simple"
             :type 'invalid-argument ;; TODO: make tokens: optionally settable
             :message "This parser handles tokens automatically, no need to provide them"
             :args (list (assq-or 'tokens: options*))))

   (define (extract+check key)
     (define-values (ret set-list)
       (parselynn:simple:extract-set key options*))

     (parselynn:simple:check-set non-terminals set-list)
     (and (not (hashset-null? ret)) (cons key ret)))

   (define transformations
     (filter
      identity
      (map extract+check
           (list 'flatten: 'join: 'skip: 'inline:))))

   (define options-to-upstream
     (assq-set-value
      'lexer-code: lexer-code
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
         options*)))))

   (define backend-parser
     (parselynn:core options-to-upstream))

   (make-parselynn:simple:struct
    arguments backend-parser
    hidden-tree-labels transformations)))
