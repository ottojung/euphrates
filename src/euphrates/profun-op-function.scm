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

(cond-expand
 (guile
  (define-module (euphrates profun-op-function)
    :export (profun-op-function)
    :use-module ((euphrates list-singleton-q) :select (list-singleton?))
    :use-module ((euphrates list-span-n) :select (list-span-n))
    :use-module ((euphrates profun-accept) :select (profun-accept profun-set))
    :use-module ((euphrates profun-answer-huh) :select (profun-answer?))
    :use-module ((euphrates profun-error) :select (make-profun-error))
    :use-module ((euphrates profun-op) :select (make-profun-op))
    :use-module ((euphrates profun-reject) :select (profun-reject))
    :use-module ((euphrates profun-request-value) :select (profun-request-value))
    :use-module ((euphrates profun-value) :select (profun-bound-value? profun-unbound-value? profun-value-unwrap))
    :use-module ((euphrates raisu) :select (raisu)))))



(define-syntax profun-op-function
  (syntax-rules ()
    ((_ (in-arity out-arity) proc)
     (begin
       (unless (and (number? in-arity) (number? out-arity))
         (raisu 'arities-must-be-numbers in-arity out-arity))
       (unless (procedure? proc)
         (raisu 'proc-must-be-a-procedure proc))

       (make-profun-op
        (+ in-arity out-arity)
        (lambda (get-func ctx var-names)

          (define args-names var-names)
          (define vars
            (map get-func var-names))
          (define args
            (map profun-value-unwrap vars))
          (if (null? args)
              (profun-reject)
              (let ()
                (define-values (in-args out-args)
                  (list-span-n in-arity args))
                (define-values (in-names out-names)
                  (list-span-n in-arity args-names))
                (define unbound-names
                  (filter
                   identity
                   (map (lambda (arg name)
                          (and (profun-unbound-value? arg)
                               name))
                        in-args in-names)))

                (if (not (null? unbound-names))
                    (profun-request-value
                     (if (list-singleton? unbound-names)
                         (car unbound-names)
                         (cons 'and unbound-names)))
                    (let ()
                      (define results
                        (call-with-values
                            (lambda _ (apply proc in-args))
                          list))

                      (if (not (= out-arity (length results)))
                          (if (and (list-singleton? results)
                                   (profun-answer? (car results)))
                              (car results)
                              (make-profun-error
                               'bad-number-of-args-returned
                               (length results) out-arity))
                          (let loop ((results results)
                                     (out-args out-args)
                                     (out-names out-names)
                                     (ret (profun-accept)))
                            (if (null? results)
                                ret
                                (let ((r (car results))
                                      (o (car out-args)))
                                  (cond
                                   ((profun-bound-value? o)
                                    (if (equal? o r)
                                        (loop (cdr results)
                                              (cdr out-args)
                                              (cdr out-names)
                                              ret)
                                        (profun-reject)))
                                   ((profun-answer? r) r)
                                   (else
                                    (loop (cdr results)
                                          (cdr out-args)
                                          (cdr out-names)
                                          (profun-set
                                           ((car out-names) <- r)
                                           ret))))))))))))))))

    ((_ in-arity proc)
     (profun-op-function (in-arity 1) proc))))
