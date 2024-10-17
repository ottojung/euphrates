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

  (define constructed-objects
    (make-hashmap))
  (define axioms-stack
    (stack-make))
  (define axioms-set
    (make-hashset))
  (define assumed-objects
    (lexical-scope-make))

  (define (constructed? object)
    (hashmap-has? constructed-objects object))

  (define (postulated? object)
    (hashset-has? axioms-set object))

  (define (assumed? object)
    (lexical-scope-has? assumed-objects object))

  (define (add-constructed! object)
    (unless (assumed? object)
      (unless (postulated? object)
        (hashmap-set! constructed-objects object #t))))

  (define (add-axiom! object)
    (if (member object (supposed-objects-list))
        (add-assumed! object)
        (unless (constructed? object)
          (unless (assumed? object)
            (add-constructed! object)
            (hashset-add! axioms-set object)
            (stack-push! axioms-stack object)))))

  (define (add-assumed! object)
    (unless (constructed? object)
      (unless (postulated? object)
        (lexical-scope-set! assumed-objects object #t))))

  (define last-assumptions-depth
    0)

  (define (current-assumptions-depth)
    (define letstack (olesya:trace:let-stack))
    (length letstack))

  (define (update-assumptions-depth!)
    (define new-depth
      (current-assumptions-depth))

    (cond
     ((< new-depth last-assumptions-depth)
      (lexical-scope-unstage! assumed-objects))
     ((> new-depth last-assumptions-depth)
      (lexical-scope-stage! assumed-objects)))

    (set! last-assumptions-depth new-depth))

  (define (supposed-objects-list)
    (define letstack (olesya:trace:let-stack))
    (map cadr letstack))

  (define (bring-rule-down rule)
    (define prefix
      (list-fold/semigroup
       (lambda (acc cur)
         (olesya:syntax:rule:make acc cur))
       (supposed-objects-list)))

    (define-values (premise consequence)
      (olesya:syntax:rule:destruct rule 'impossible))

    (olesya:syntax:rule:make
     rule (olesya:syntax:rule:make prefix consequence)))

  (define (assumption-safe-rule? rule subject)
    (define-values (premise consequence)
      (olesya:syntax:rule:destruct rule 'impossible))

    (equal? premise subject))

  (define (callback/substitution operation result)
    (define-values (rule subject)
      (olesya:substitution:destruct operation))

    (if (or (assumed? subject) (assumed? rule))
        (add-assumed! result)
        (add-constructed! result))

    (when (assumed? subject)
      (unless (assumption-safe-rule? rule subject)
        (add-axiom! (bring-rule-down rule)))))

  (define (callback/term operation result)
    (define letstack (olesya:trace:let-stack))
    (define supposedterms (map cadr letstack))
    (add-axiom! result))

  (define (callback/rule operation result)
    (add-axiom! result))

  (define (callback/eval operation result)
    (add-constructed! result))

  (define (callback/let operation result)
    (add-assumed! result))

  (define (callback operation result)
    (update-assumptions-depth!)
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
