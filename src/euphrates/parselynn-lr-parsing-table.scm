;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <lr-parsing-table>
  (parselynn:lr-parsing-table:constructor

   states-set    ;; set of `state id`.
   actions-set   ;; set of terminals.
   goto-set      ;; set of nonterminals.
   action-table  ;; associative list with `key: (cons state-id (terminal | eoi))`, `value: stack<shift-action | reduce-action>`.
   goto-table    ;; associative list with `key: state-id`, `value: assoc<nonterminal, goto-action | accept-action>`.

   )

  parselynn:lr-parsing-table?

  (states-set parselynn:lr-parsing-table:states-set)
  (actions-set parselynn:lr-parsing-table:actions-set)
  (goto-set parselynn:lr-parsing-table:goto-set)
  (action-table parselynn:lr-parsing-table:action-table)
  (goto-table parselynn:lr-parsing-table:goto-table)

  )


(define (parselynn:lr-parsing-table:make)
  (define action-table (make-hashmap))
  (define goto-table (make-hashmap))
  (define states-set (make-hashset))
  (define actions-set (make-hashset))
  (define goto-set (make-hashset))

  (parselynn:lr-parsing-table:constructor
   states-set actions-set goto-set action-table goto-table))


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

  (define hash-key
    (cons state key))

  (define existing
    (hashmap-ref
     action-table hash-key
     #f))

  (define stack
    (or existing
        (let ()
          (define new (stack-make))
          (hashmap-set! action-table hash-key new)
          new)))

  (unless (member action (stack->list stack))
    (stack-push! stack action))

  (parselynn:lr-parsing-table:state:add! table state)
  (hashset-add! actions-set key)

  (values))


(define (parselynn:lr-parsing-table:goto:set! table state key action)
  (define states-set
    (parselynn:lr-parsing-table:states-set table))

  (define goto-set
    (parselynn:lr-parsing-table:goto-set table))

  (define goto-table
    (parselynn:lr-parsing-table:goto-table table))

  (define existing
    (hashmap-ref goto-table state '()))

  (define new-elem
    (cons key action))

  (define new
    (cons new-elem existing))

  (hashmap-set! goto-table state new)
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

       (define existing
         (hashmap-ref action-table hash-key #f))

       (if existing
           (stack->list existing)
           default)))))


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

       (define goto-table
         (parselynn:lr-parsing-table:goto-table table*))

       (define existing
         (hashmap-ref goto-table state '()))

       (assoc-or key* existing default)))))


(define (parselynn:lr-parsing-table:goto:list table state)
  (define goto-table
    (parselynn:lr-parsing-table:goto-table table))

  (define existing
    (hashmap-ref goto-table state '()))

  (map car existing))
