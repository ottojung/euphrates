;;;; Copyright (C) 2022, 2023  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.






(define-type9 <profun-iterator>
  (profun-iterator-constructor db env state query) profun-iterator?
  (db profun-iterator-db)
  (env profun-iterator-env)
  (state profun-iterator-state set-profun-iterator-state!)
  (query profun-iterator-query set-profun-iterator-query!)
  )

(define (get-current-subroutine s)
  (define stack (profun-state-stack s))
  (if (null? stack)
      (values #f #f)
      (let ()
        (define instruction (car stack))
        (define key (profun-instruction-name instruction))
        ;; (define body (profun-instruction-body instruction))
        (define arity (profun-instruction-arity instruction))
        (values key arity))))

(define (add-prefix-to-instruction db s instruction-prefix)
  (define current (profun-state-current s))
  (define new-current
    (profun-instruction-build/next
     instruction-prefix current))

  (set-profun-state-current s new-current))

(define (profun-iterator-copy iter)
  (define db (profun-iterator-db iter))
  (define env (profun-iterator-env iter))
  (define new-db (profun-database-copy db))
  (define new-env (profun-env-copy env))
  (define state (profun-iterator-state iter))
  (define query (profun-iterator-query iter))
  (profun-iterator-constructor new-db new-env state query))

(define (profun-iterator-copy/extend iter new-rules)
  (define db (profun-iterator-db iter))
  (define env (profun-iterator-env iter))
  (define new-db (profun-database-extend db new-rules))
  (define new-env (profun-env-copy env))
  (define state (profun-iterator-state iter))
  (define query (profun-iterator-query iter))
  (profun-iterator-constructor new-db new-env state query))

(define (profun-iterator-insert! iter instruction-prefix)
  (define usymboled-prefix
    (profun-query-handle-underscores instruction-prefix))
  (define db (profun-iterator-db iter))
  (define state (profun-iterator-state iter))
  (define new-state
    (if (symbol? usymboled-prefix)
        (make-profun-error usymboled-prefix)
        (add-prefix-to-instruction db state usymboled-prefix)))
  (set-profun-iterator-state! iter new-state))

(define (profun-iterator-reset! iter new-query)
  (define usymboled-query
    (profun-query-handle-underscores new-query))
  (define new-state
    (if (symbol? usymboled-query)
        (make-profun-error usymboled-query)
        (profun-state-build usymboled-query)))
  (set-profun-iterator-state! iter new-state)
  (set-profun-iterator-query! iter usymboled-query))

(define (profun-abort-insert self inserted)
  "Inserts `inserted' just before the instruction that throwed this abort, and continues evaluation."

  (define iter (profun-abort-iter self))
  (define additional (profun-abort-additional self))
  (define new-iter (profun-iterator-copy/extend iter additional))
  (profun-iterator-insert! new-iter inserted)
  new-iter)

(define (profun-abort-reset self new-query)
  "Evaluates `new-query' starting from state before the abort was thrown. Any later computation is ignored."

  (define iter (profun-abort-iter self))
  (define additional (profun-abort-additional self))
  (define new-iter (profun-iterator-copy/extend iter additional))
  (profun-iterator-reset! new-iter new-query)
  new-iter)
