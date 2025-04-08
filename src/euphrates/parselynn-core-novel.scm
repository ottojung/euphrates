;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:core:novel
         driver-normalized-name
         all-lexer-code
         rules
         results-mode
         )

  (define (lr-1-driver?)
    (equal? driver-normalized-name 'lr-1-driver))

  (define (lr-1-driver-code all-lexer-code rules results-mode)
    (cond
     ((equal? results-mode 'first) 'fine)
     ((equal? results-mode 'all)
      (parselynn:core:grammar-error
       "Invalid option: ~s because LR(1) parser can only output a single result, so choose ~s ~s for it."
       (~a results-mode) 'results: 'first))
     (else (raisu 'impossible 'expected-all-or-first results-mode)))

    (define (rules->bnf-alist rules)

      (define something

        (bnf-alist:map-grouped-productions
         (lambda (name)
           (lambda (group)
             (let loop ((group group))
               (if (null? group) group
                   (let ()
                     (define production (car group))
                     (if (equal? ': production)
                         (loop (cdr (cdr group)))
                         (cons production (loop (cdr group)))))))))

         rules))

      something)

    (define (rules->callback-alist rules)
      (define H (make-hashmap))

      (bnf-alist:map-grouped-productions
       (lambda (name)
         (lambda (group)
           (unless (null? group)
             (let loop ((group (cdr group))
                        (prev (car group)))
               (unless (null? group)
                 (let ()
                   (define current (car group))
                   (when (equal? ': current)
                     (hashmap-set!
                      H (list name prev)
                      (car (cdr group))))

                   (loop (cdr group) current)))))))

       rules)

      (hashmap->alist H))

    (define bnf-alist
      (rules->bnf-alist rules))

    (define callback-alist
      (rules->callback-alist rules))

    (define table
      (parselynn:lr-compute-parsing-table bnf-alist))

    (define conflicts
      (parselynn:lr-parsing-table:get-conflicts table))

    (define _reported
      (for-each
       (lambda (conflict)
         (define state (car conflict))
         (define symbol-alist (cdr conflict))
         (for-each
          (lambda (symbol-actions-pair)
            (define-pair (symbol actions) symbol-actions-pair)
            (define first2 (list-take-n 2 actions))
            (define-tuple (action1 action2) first2)

            (define (get-type action)
              (cond
               ((parselynn:lr-shift-action? action)
                "shift")
               ((parselynn:lr-reduce-action? action)
                "reduce")
               (else
                (raisu-fmt 'impossible-6123513 "Expected either shift or reduce here, but got ~s." action))))

            (define type1
              (get-type action1))
            (define type2
              (get-type action2))
            (define overall-type
              (string->symbol
               (string-append type1 "/" type2)))
            (define new
              (with-output-stringified
               (parselynn:lr-action:print action1)))
            (define current
              (with-output-stringified
               (parselynn:lr-action:print action2)))

            (parselynn:core:signal-conflict overall-type new current symbol state))
          symbol-alist))

       conflicts))

    (define get-next-token-code
      `((define get-next-token
          (let () ,@all-lexer-code))))

    (define code
      (parameterize ((parselynn:core:conflict-handler/p (lambda _ 0)))
        (parselynn:lr-1-compile/for-core
         get-next-token-code
         table callback-alist)))

    `(let ()
       (lambda (actions)
         ,@code)))

  (cond
   ((lr-1-driver?)
    (lr-1-driver-code all-lexer-code rules results-mode))

   (else
    (raisu-fmt
     'logic-error "Expected either of ~a but got ~s somehow."
     (apply
      string-append
      (list-intersperse
       ", " (map ~s (map car parselynn:core:driver-normalized-name->type/alist))))
     driver-normalized-name))))
