;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <lr-parsing-table>
  (parselynn:lr-parsing-table:constructor

   initial-state ;; value of type `state-id` that corresponds to the initial state.
   states-set    ;; set of `state-id`.
   actions-set   ;; set of terminals.
   goto-set      ;; set of nonterminals.
   action-table  ;; hashmap with `key: cons<state-id, terminal | eoi>`, `value: shift-action | reduce-action | accept-action | parse-conflict`
   goto-table    ;; hashmap with `key: cons<state-id, nonterminal>`, `value: goto-action`.
   action-lists  ;; hashmap with `key: state-id`, value `list<terminal | eoi>`.
   goto-lists    ;; hashmap with `key: state-id`, value `list<nonterminal>`.

   )

  parselynn:lr-parsing-table?

  (initial-state parselynn:lr-parsing-table:initial-state)
  (states-set parselynn:lr-parsing-table:states-set)
  (actions-set parselynn:lr-parsing-table:actions-set)
  (goto-set parselynn:lr-parsing-table:goto-set)
  (action-table parselynn:lr-parsing-table:action-table)
  (goto-table parselynn:lr-parsing-table:goto-table)
  (action-lists parselynn:lr-parsing-table:action-lists)
  (goto-lists parselynn:lr-parsing-table:goto-lists)

  )


(define (parselynn:lr-parsing-table:make initial-state)
  (define action-table (make-hashmap))
  (define goto-table (make-hashmap))
  (define action-lists (make-hashmap))
  (define goto-lists (make-hashmap))
  (define states-set (make-hashset))
  (define actions-set (make-hashset))
  (define goto-set (make-hashset))

  (parselynn:lr-parsing-table:constructor
   initial-state
   states-set actions-set goto-set
   action-table goto-table
   action-lists goto-lists))


(define (parselynn:lr-parsing-table:state:initial table)
  (parselynn:lr-parsing-table:initial-state table))


(define (parselynn:lr-parsing-table:state:add! table state)
  (define states-set
    (parselynn:lr-parsing-table:states-set table))

  (hashset-add! states-set state))


(define (parselynn:lr-parsing-table:state:keys table)
  (define unordered-lst
    (hashset->list
     (parselynn:lr-parsing-table:states-set table)))

  (define lst
    (euphrates:list-sort
     unordered-lst
     (lambda (a b) (< a b))))

  lst)


(define (parselynn:lr-parsing-table:action:keys table)
  (define unordered-lst
    (hashset->list
     (parselynn:lr-parsing-table:actions-set table)))

  (define lst
    (euphrates:list-sort
     unordered-lst
     (lambda (a b)
       (string<? (~s a) (~s b)))))

  lst)


(define (parselynn:lr-parsing-table:goto:keys table)
  (define unordered-lst
    (hashset->list
     (parselynn:lr-parsing-table:goto-set table)))

  (define lst
    (euphrates:list-sort
     unordered-lst
     (lambda (a b)
       (string<? (~s a) (~s b)))))

  lst)


(define (parselynn:lr-parsing-table:action:add! table state key action)
  (define actions-set
    (parselynn:lr-parsing-table:actions-set table))

  (define action-table
    (parselynn:lr-parsing-table:action-table table))

  (define action-lists
    (parselynn:lr-parsing-table:action-lists table))

  (define hash-key
    (cons state key))

  (define existing
    (hashmap-ref
     action-table hash-key
     #f))

  (cond
   ((parselynn:lr-parse-conflict? existing)
    (parselynn:lr-parse-conflict:add! existing action))

   ((equal? existing #f)
    (hashmap-set! action-table hash-key action))

   ((equal? action existing)
    'pass)

   (else
    (hashmap-set!
     action-table hash-key
     (parselynn:lr-parse-conflict:make
      existing action))))

  (define existing-list
    (hashmap-ref action-lists state '()))

  (define new-list
    (if (member key existing-list)
        existing-list
        (cons key existing-list)))

  (parselynn:lr-parsing-table:state:add! table state)
  (hashset-add! actions-set key)
  (hashmap-set! action-lists state new-list)

  (values))


(define (parselynn:lr-parsing-table:goto:set! table state key action)
  (define states-set
    (parselynn:lr-parsing-table:states-set table))

  (define goto-set
    (parselynn:lr-parsing-table:goto-set table))

  (define goto-table
    (parselynn:lr-parsing-table:goto-table table))

  (define goto-lists
    (parselynn:lr-parsing-table:goto-lists table))

  (define hash-key
    (cons state key))

  (define existing-list
    (hashmap-ref goto-lists state '()))

  (define new-list
    (if (member key existing-list)
        existing-list
        (cons key existing-list)))

  (hashmap-set! goto-table hash-key action)
  (hashmap-set! goto-lists state new-list)
  (parselynn:lr-parsing-table:state:add! table state)
  (hashset-add! goto-set key)

  (values))


(define-syntax parselynn:lr-parsing-table:action:ref
  (syntax-rules ()
    ((_ table state key)
     (let ()
       (define table* table)
       (define state* state)
       (define key* key)

       (parselynn:lr-parsing-table:action:ref
        table* state* key*
        (raisu* :from "parselynn:lr-parsing-table"
                :type 'key-not-found
                :message "Key not found in parsing table."
                :args (list table* state* key*)))))

    ((_ table state key default)
     (let ()
       (define table* table)
       (define state* state)
       (define key* key)
       (define hash-key (cons state* key*))

       (define action-table
         (parselynn:lr-parsing-table:action-table table*))

       (hashmap-ref action-table hash-key default)))))


(define-syntax parselynn:lr-parsing-table:goto:ref
  (syntax-rules ()
    ((_ table state key)
     (let ()
       (define table* table)
       (define state* state)
       (define key* key)

       (parselynn:lr-parsing-table:goto:ref
        table* state* key*
        (raisu* :from "parselynn:lr-parsing-table"
                :type 'key-not-found
                :message "Key not found in parsing table."
                :args (list table* state* key*)))))

    ((_ table state key default)
     (let ()
       (define table* table)
       (define state* state)
       (define key* key)
       (define hash-key (cons state* key*))

       (define goto-table
         (parselynn:lr-parsing-table:goto-table table*))

       (hashmap-ref goto-table hash-key default)))))


(define (parselynn:lr-parsing-table:action:list table state)
  (define action-lists
    (parselynn:lr-parsing-table:action-lists table))

  (define existing-list
    (hashmap-ref action-lists state '()))

  existing-list)


(define (parselynn:lr-parsing-table:goto:list table state)
  (define goto-lists
    (parselynn:lr-parsing-table:goto-lists table))

  (define existing-list
    (hashmap-ref goto-lists state '()))

  existing-list)
