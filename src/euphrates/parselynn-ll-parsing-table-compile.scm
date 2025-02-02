;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:ll-parsing-table:compile
         parsing-table callback-alist)

  (define clauses
    (parselynn:ll-parsing-table:clauses parsing-table))

  (define cases-stack
    (stack-make))

  (define (handle-action action i)
    (define name
      (string->symbol
       (string-append "$" (~a (+ 1 i)))))

    (define value
      (cond
       ((parselynn:ll-match-action? action)
        (let ()
          (define expected
            `(quote ,(parselynn:ll-match-action:symbol action)))

          ;; TODO: factor out a `match` procedure.
          `(if (equal? look_ahead ,expected)
               (begin
                 (advance!)
                 ,expected)
               (error "Unexpected token!" look_ahead ,expected))))

       ((parselynn:ll-predict-action? action)
        (let ()
          (define nonterminal
            (parselynn:ll-predict-action:nonterminal action))
          (define name
            (parselynn:ll-compile:get-predictor-name nonterminal))
          `(,name)))

       (else
        (raisu-fmt
         'unexpected-action-61236613
         "Expected either a match or predict, but got ~s."
         action))))

    `(define ,name ,value))

  (define (handle-clause clause)
    (define production
      (parselynn:ll-parsing-table-clause:production clause))
    (define candidates
      (parselynn:ll-parsing-table-clause:candidates clause))
    (define actions
      (parselynn:ll-parsing-table-clause:actions clause))

    (define sorted-candidates
      (euphrates:list-sort
       (hashset->list candidates)
       (lambda (a b)
         (string<? (object->string a)
                   (object->string b)))))

    (define check-code
      `(member look_ahead (quote ,sorted-candidates)))

    (define callback
      (assoc-or
       production callback-alist
       (cons 'list (bnf-alist:production:get-argument-bindings production))))
    (define callback-arguments
      (map handle-action actions (range (length actions))))
    (define nonterminal
      (bnf-alist:production:lhs production))
    (define action-code
      `(let ()
         (define $0 (quote ,nonterminal)) ;; TODO: factor out this $0 value up the function definition.
         ,@callback-arguments
         ,callback))

    (define code
      `(,check-code ,action-code))

    (define key-value
      (cons nonterminal code))

    (stack-push! cases-stack key-value))

  (define _71236
    (for-each handle-clause clauses))

  (define cases-alist
    (reverse (stack->list cases-stack)))

  (define (grouper a b)
    (equal? (car a) (car b)))

  (define (add-tag group)
    (define first-element (car group))
    (define nonterminal (car first-element))
    (define tag (parselynn:ll-compile:get-predictor-name nonterminal))
    (cons tag group))

  (define (remove-tags tagged-group)
    (define tag (car tagged-group))
    (define group (cdr tagged-group))
    (cons tag (map cdr group)))

  (define grouped
    (map remove-tags
         (map add-tag
              (group-by/sequential grouper cases-alist))))

  (define (group->definition tagged-group)
    (define tag (car tagged-group))
    (define group (cdr tagged-group))
    `(define (,tag) (cond ,@group)))

  (define definitions
    (map group->definition grouped))

  definitions)
