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

    (define letstack (olesya:trace:let-stack))
    (define supposedterms (map cadr letstack))
    (unless (null? letstack)
      (let ()
        (debug "")
        (debug "")
        (debug "mapping")
        (debugs letstack)
        (debug "op: ~s" operation)
        (debugs result)

        (define prefix
          (list-fold/semigroup
           (lambda (acc cur)
             (olesya:syntax:rule:make acc cur))
           supposedterms))

        (debugs prefix)

        (define-values (premise consequence)
          (olesya:syntax:rule:destruct rule 'impossible))

        (define prefixed-rule
          (olesya:syntax:rule:make
           (olesya:syntax:rule:make prefix premise)
           (olesya:syntax:rule:make prefix consequence)))

        (debugs prefixed-rule)

        ))

    (add-axiom! rule)
    (add-created! result)

    ;; (debugs rule)
    ;; (debugs subject)

    0)

  (define (callback/term operation result)
    (define letstack (olesya:trace:let-stack))
    (define supposedterms (map cadr letstack))
    (unless (member result supposedterms)
      (add-axiom! result)
      (add-created! result)))

  (define (callback/rule operation result)
    (add-axiom! result)
    (add-created! result))

  (define (callback/eval operation result)
    (add-created! result))

  (define (callback/let operation result)
    (add-created! result))

  (define (callback operation result)
    (unless (olesya:trace:in-eval?)
      (cond
       ((olesya:substitution? operation)
        (callback/substitution operation result))
       ((olesya:syntax:term? operation)
        (callback/term operation result))
       ((olesya:syntax:rule? operation)
        (callback/rule operation result))
       ((olesya:syntax:eval? operation)
        (callback/eval operation result))
       ((olesya:syntax:let? operation)
        (callback/let operation result))
       (else
        (raisu* :from "olesya:reverse"
                :type 'unknown-operation
                :message "Uknown operation in reverse."
                :args (list operation result))))))

  (define (get-assumptions)
    (reverse
     (stack->list axioms-stack)))

  (values callback get-assumptions))
