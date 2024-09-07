;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-state-graph->lr-parsing-table bnf-alist graph)
  (define initial-state
    (parselynn:lr-state-graph:node-id
     (parselynn:lr-state-graph:start graph)))

  (define start-symbol
    (if (bnf-alist:empty? bnf-alist)
        parselynn:epsilon
        (bnf-alist:start-symbol bnf-alist)))

  (define start-node
    (parselynn:lr-state-graph:start graph))

  (define final-node
    (lenode:get-child
     start-node start-symbol #f))

  (define final-state
    (and final-node
         (olnode:value final-node)))

  (define ret
    (parselynn:lr-parsing-table:make initial-state))

  ;; Convert terminals and nonterminals to hash sets for easy membership testing.
  (define terminals
    (list->hashset
     (bnf-alist:terminals bnf-alist)))

  (define nonterminals
    (list->hashset
     (bnf-alist:nonterminals bnf-alist)))

  ;; Define utility functions to check if a symbol is terminal or nonterminal.
  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  (define (final-state? state)
    (equal? state final-state))

  (define (process-state parent-id parent-state mapped-children)
    (parselynn:lr-parsing-table:state:add! ret parent-id)

    (when (final-state? parent-state)
      (parselynn:lr-parsing-table:action:add!
       ret parent-id parselynn:end-of-input
       (parselynn:lr-accept-action:make)))

    (define (process-child mapped-child)
      (define-tuple (label child-id child-state) mapped-child)

      (define (process-terminal)
        (parselynn:lr-parsing-table:action:add!
         ret parent-id label
         (parselynn:lr-shift-action:make
          parent-id
          parent-state
          child-id
          child-state
          )))

      (define (process-nonterminal)
        (parselynn:lr-parsing-table:goto:set!
         ret parent-id label
         (parselynn:lr-goto-action:make
          parent-id
          parent-state
          child-id
          child-state
          )))

      (cond
       ((terminal? label)
        (process-terminal))
       ((nonterminal? label)
        (process-nonterminal))
       (else
        (raisu* :from "parselynn:lr-state-graph->lr-parsing-table"
                :type 'unknown-label
                :message "Label is neither a terminal nor a nonterminal."
                :args (list label graph bnf-alist)))))

    (parselynn:lr-state:foreach-item

     (lambda (item)
       (when (parselynn:lr-item:dot-at-end? item)
         (let ()
           (define lhs
             (parselynn:lr-item:left-hand-side item))

           (define production
             (parselynn:lr-item:production item))

           (define label
             (parselynn:lr-item:lookahead item))

           (define action
             (parselynn:lr-reduce-action:make production list))

           (parselynn:lr-parsing-table:action:add!
            ret parent-id label action))))

     parent-state)

    (for-each process-child mapped-children))

  (parselynn:lr-state-graph:traverse graph process-state)

  ret)
