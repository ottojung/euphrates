;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;
;; This function takes an Olesya program,
;; and returns all the axioms that the program relies on.
;;
;; It also crashes when there are unexpected transformations.
;;


(define (olesya:reverse program)
  (define-values (callback get-assumptions)
    (olesya:reverse:make-analyzer))

  (define trace
    (olesya:trace:with-callback
     callback
     (olesya:trace program)))

  (get-assumptions))


(define (olesya:reverse:make-analyzer)

  (define created-objects-set
    (make-hashset))
  (define axioms-stack
    (stack-make))
  (define axioms-set
    (make-hashset))

  (define (add-axiom! object)
    (unless (hashset-has? created-objects-set object)
      (unless (hashset-has? axioms-set object)
        (hashset-add! axioms-set object)
        (stack-push! axioms-stack object))))

  (define (add-created! object)
    (unless (hashset-has? created-objects-set object)
      (hashset-add! created-objects-set object)))

  (define (callback/substitution operation result)
    (define-values (rule subject)
      (olesya:substitution:destruct operation))

    (add-axiom! rule)
    (add-created! result)

    ;; (debugs rule)
    ;; (debugs subject)

    0)

  (define (callback/term operation result)
    (add-axiom! result)
    (add-created! result))

  (define (callback/rule operation result)
    (add-axiom! result)
    (add-created! result))

  (define (callback operation result)

    ;; (debugs operation)
    ;; (debugs result)

    (cond
     ((olesya:substitution? operation)
      (callback/substitution operation result))
     ((olesya:syntax:term? operation)
      (callback/term operation result))
     ((olesya:syntax:rule? operation)
      (callback/rule operation result))
     (else
      ;; (debugs operation)
      'TODO:support-other-operations)))

  (define (get-assumptions)
    (reverse
     (stack->list axioms-stack)))

  (values callback get-assumptions))
