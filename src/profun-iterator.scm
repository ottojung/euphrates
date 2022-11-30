;;;; Copyright (C) 2022  Otto Jung
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

%run guile

%var profun-iterator-copy
%var profun-iterator-insert!
%var profun-iterator-reset!

%var profun-iterator-constructor
%var profun-iterator-db
%var profun-iterator-env
%var profun-iterator-state
%var set-profun-iterator-state!
%var profun-iterator-query
%var set-profun-iterator-query!

%var profun-abort-insert
%var profun-abort-reset

%use (comp) "./comp.scm"
%use (define-type9) "./define-type9.scm"
%use (profun-abort-additional profun-abort-iter) "./profun-abort.scm"
%use (profun-database-add-rule! profun-database-copy profun-database-get-all profun-database-set-all!) "./profun-database.scm"
%use (profun-env-copy) "./profun-env.scm"
%use (make-profun-error) "./profun-error.scm"
%use (profun-instruction-arity profun-instruction-build/next profun-instruction-sign) "./profun-instruction.scm"
%use (profun-query-handle-underscores) "./profun-query-handle-underscores.scm"
%use (profun-rule-args profun-rule-body profun-rule-constructor profun-rule-index profun-rule-name) "./profun-rule.scm"
%use (profun-state-build profun-state-current profun-state-stack set-profun-state-current) "./profun-state.scm"

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
        (define key (profun-instruction-sign instruction))
        (define arity (profun-instruction-arity instruction))
        (values key arity))))

(define (add-prefix-to-instruction db s instruction-prefix)
  (define-values (key arity) (get-current-subroutine s))
  (define current (profun-state-current s))
  (define rules (or (profun-database-get-all db key arity) '()))
  (define (add-to-rule rule)
    ;; FIXME: add not at a begining of a rule,
    ;;        but before current instruction.
    (define body (profun-rule-body rule))
    (define new-body (append instruction-prefix body))
    (profun-rule-constructor
     (profun-rule-name rule)
     (profun-rule-index rule)
     (profun-rule-args rule)
     new-body))
  (define new-rules
    (if (list? rules)
        (map add-to-rule rules)
        (add-to-rule rules)))
  (define new-current
    (profun-instruction-build/next
     instruction-prefix current))

  (profun-database-set-all! db key arity new-rules)

  (set-profun-state-current s new-current))

(define (profun-iterator-copy iter)
  (define db (profun-iterator-db iter))
  (define env (profun-iterator-env iter))
  (define new-db (profun-database-copy db))
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
  (define new-iter (profun-iterator-copy iter))
  (define new-db (profun-iterator-db new-iter))
  (define additional (profun-abort-additional self))
  (for-each (comp (profun-database-add-rule! new-db)) additional)
  (profun-iterator-insert! new-iter inserted)
  new-iter)

(define (profun-abort-reset self new-query)
  "Evaluates `new-query' starting from state before the abort was thrown. Any later computation is ignored."

  (define iter (profun-abort-iter self))
  (define new-iter (profun-iterator-copy iter))
  (define new-db (profun-iterator-db new-iter))
  (define additional (profun-abort-additional self))
  (for-each (comp (profun-database-add-rule! new-db)) additional)
  (profun-iterator-reset! new-iter new-query)
  new-iter)
