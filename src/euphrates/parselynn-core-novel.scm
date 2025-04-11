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

  (define (ll-1-driver?)
    (equal? driver-normalized-name 'll-1-driver))

  (define (report-lr-conflict conflict)
    (define state (parselynn:lr-parse-conflict:state conflict))
    (define symbol (parselynn:lr-parse-conflict:symbol conflict))
    (define actions (parselynn:lr-parse-conflict:actions conflict))
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

    (parselynn:core:signal-lr-conflict overall-type new current symbol state))

  (define (report-ll-conflict conflict)
    (cond
     ((parselynn:ll-parse-first-first-conflict? conflict)
      (let ()
        (define candidate
          (parselynn:ll-parse-first-first-conflict:candidate conflict))
        (define productions
          (parselynn:ll-parse-first-first-conflict:candidate productions))

        (define type 'll-first/first-conflict)
        (define message
          (with-output-stringified
           (parselynn:ll-parse-conflict:print conflict)))

        (parselynn:core:signal-conflict type message conflict)))

     ((parselynn:ll-parse-recursion-conflict? conflict)
      (let ()
        (define type 'll-left-recursion)
        (define message
          (with-output-stringified
           (parselynn:ll-parse-conflict:print conflict)))

        (parselynn:core:signal-conflict type message conflict)))

     (else
      (raisu* :from "parselynn:core:novel"
              :type 'unknown-type-7162376781326
              :message (stringf "Unknown type of conflict in ~s." conflict)
              :args (list conflict)))))

  (define lr-1-driver-code
    (generic-driver-code
     parselynn:lr-compute-parsing-table
     parselynn:lr-parsing-table:get-conflicts
     report-lr-conflict
     parselynn:lr-1-compile/for-core
     ))

  (define ll-1-driver-code
    (generic-driver-code
     parselynn:ll-compute-parsing-table
     parselynn:ll-parsing-table:get-conflicts
     report-ll-conflict
     parselynn:ll-1-compile/for-core
     ))

  (define (generic-driver-code
           compute-parsing-table
           get-conflicts
           report-conflict
           compile/for-core
           )
    (define (continuation all-lexer-code rules results-mode)
      (define name
        (assoc-or
         driver-normalized-name
         parselynn:core:driver-normalized-name->type/alist))

      (cond
       ((equal? results-mode 'first) 'fine)
       ((equal? results-mode 'all)
        (parselynn:core:grammar-error
         "Invalid option: ~s because ~s parser can only output a single result, so choose ~s ~s for it."
         (~a results-mode) name 'results: 'first))
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
        (compute-parsing-table bnf-alist))

      (define conflicts
        (get-conflicts table))

      (define _reported
        (for-each report-conflict conflicts))

      (define get-next-token-code
        `((define get-next-token
            (let () ,@all-lexer-code))))

      (define code
        (parameterize ((parselynn:core:conflict-handler/p (lambda _ 0)))
          (compile/for-core
           get-next-token-code
           table callback-alist)))

      `(let ()
         (lambda (actions)
           ,@code)))

    continuation)

  (cond
   ((lr-1-driver?)
    (lr-1-driver-code all-lexer-code rules results-mode))

   ((ll-1-driver?)
    (ll-1-driver-code all-lexer-code rules results-mode))

   (else
    (raisu-fmt
     'logic-error "Expected either of ~a but got ~s somehow."
     (apply
      string-append
      (list-intersperse
       ", " (map ~s (map car parselynn:core:driver-normalized-name->type/alist))))
     driver-normalized-name))))
