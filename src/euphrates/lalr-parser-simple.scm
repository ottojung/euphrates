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
       (if (memq key (list 'driver: 'output: 'on-conflict:))
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

  (define non-terminals
    (list->hashset (map car rules/1)))

  (define-values (terminal-prefix terminal-prefix/re)
    (let ()
      (define (make-prefix x)
        (string-append "t" (if (= 0 x) "" (~a x)) "_"))
      (define (make-prefix/re x)
        (string-append "r" (if (= 0 x) "" (~a x)) "_"))

      (define lowest-index
        (list-fold
         (acc 0)
         (cur (map ~a (list-collapse rules/1)))
         (if (or (string-prefix? (make-prefix acc) cur)
                 (string-prefix? (make-prefix/re acc) cur))
             (+ 1 acc) acc)))

      (values (make-prefix lowest-index)
              (make-prefix/re lowest-index))))

  (define rhss
    (map cdr rules/1))

  (define all-expansion-terms
    (apply append (apply append rhss)))

  (define (string-terminal? x)
    (string? x))

  (define (re-terminal? x)
    (and (list? x)
         (pair? x)
         (equal? 're (car x))))

  (define (terminal? x)
    (or (string-terminal? x)
        (re-terminal? x)))

  (define all-terminals
    (filter terminal? all-expansion-terms))

  (define all-nonterminals
    (map car rules/1))

  (define (terminal->token t)
    (cond
     ((string-terminal? t)
      (string->symbol (string-append terminal-prefix t)))
     ((re-terminal? t)
      (string->symbol
       (string-append
        terminal-prefix/re
        (apply string-append
               (list-intersperse "_" (map ~a t))))))
     (else (raisu 'impossible t))))

  (define terminal->irregex
    (curry-if re-terminal? cdr))

  (define tokens-map
    (map (compose-under cons terminal->token terminal->irregex)
         all-terminals))

  (define make-lexer
    (make-lalr-lexer/irregex-factory tokens-map))

  (define tokens
    (map car tokens-map))

  (define (translate-terminal x)
    (string->symbol (string-append terminal-prefix x)))

  (define (maybe-translate-terminal x)
    (if (terminal? x)
        (terminal->token x)
        x))

  (define (translate-rhs rhs)
    (map maybe-translate-terminal rhs))

  (define rules/2
    (map
     (fn-cons identity (comp (map translate-rhs)))
     rules/1))

  (define rules rules/2)

  (when (assq-or 'tokens: options*)
    (raisu* :from "lalr-parser/simple"
            :type 'invalid-argument ;; TODO: make tokens: optionally settable
            :message "This parser handles tokens automatically, no need to provide them"
            :args (list (assq-or 'tokens: options*))))

  (define flattened/l
    (assq-or 'flatten: options* '()))

  (unless (list? flattened/l)
    (raisu* :from "lalr-parser/simple"
            :type 'invalid-flatten-set
            :message
            (stringf "The ~s option expected a list of productions to flatten, but found something other than a list"
                     (~a 'flatten:))
            :args (list 'flatten: flattened/l)))

  (define flattened
    (list->hashset flattened/l))

  (define joined/l
    (assq-or 'join: options* '()))

  (unless (list? joined/l)
    (raisu* :from "lalr-parser/simple"
            :type 'invalid-join-set
            :message
            (stringf "The ~s option expected a list of productions to join, but found something other than a list"
                     (~a 'join:))
            :args (list 'join: joined/l)))

  (define joined
    (list->hashset joined/l))

  (define skiped/l
    (assq-or 'skip: options* '()))

  (unless (list? skiped/l)
    (raisu* :from "lalr-parser/simple"
            :type 'invalid-skip-set
            :message
            (stringf "The ~s option expected a list of productions to skip, but found something other than a list"
                     (~a 'skip:))
            :args (list 'skip: skiped/l)))

  (define skiped
    (list->hashset skiped/l))

  (define options-to-upstream
    (assq-unset-value
     'skip:
     (assq-unset-value
      'join:
      (assq-unset-value
       'flatten:
       (assq-unset-value
        'grammar:
        (assq-set-value
         'rules: rules
         (assq-set-value
          'tokens: tokens
          options*)))))))

  (define upstream (lalr-parser options-to-upstream))

  (lalr-parser/simple-check-set non-terminals skiped)
  (lalr-parser/simple-check-set non-terminals joined)
  (lalr-parser/simple-check-set non-terminals flattened)

  (lambda (errorp input)
    (lalr-parser/simple-transform-result
     flattened joined skiped
     (upstream (make-lexer input) errorp))))
