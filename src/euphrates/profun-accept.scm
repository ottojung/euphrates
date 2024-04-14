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




(define-type9 profun-accept-obj
  (profun-accept-constructor alist context context-changed?) profun-accept-obj?
  (alist profun-accept-alist)
  (context profun-accept-ctx)
  (context-changed? profun-accept-ctx-changed?)
  )

(define (profun-accept)
  (profun-accept-constructor '() #f #f))

(define (make-profun-accept alist context context-changed?)
  (profun-accept-constructor alist context context-changed?))

(define (profun-accept? o)
  (profun-accept-obj? o))

(define (profun-set-fn variable variable-value current-return-value)
  (unless (profun-accept-obj? current-return-value)
    (raisu 'current-return-value-must-be-a-profun-accept-obj current-return-value))
  (unless (profun-varname? variable)
    (raisu 'not-a-variable-name variable current-return-value))

  (let* ((alist (profun-accept-alist current-return-value))
         (ctx (profun-accept-ctx current-return-value))
         (ctx-changed? (profun-accept-ctx-changed? current-return-value))
         (new-alist (assq-set-value variable variable-value alist)))
    (profun-accept-constructor new-alist ctx ctx-changed?)))

(define (profun-set-meta-fn variable variable-value current-return-value)
  (define true-variable-name (profun-meta-key variable))
  (profun-set-fn true-variable-name variable-value current-return-value))

(define-syntax profun-set
  (syntax-rules ()
    ((_ (variable <- variable-value))
     (profun-set-fn variable variable-value (profun-accept)))
    ((_ (variable <- variable-value) current-return-value)
     (profun-set-fn variable variable-value current-return-value))))

(define profun-ctx-set
  (case-lambda
   ((new-context) (profun-ctx-set new-context (profun-accept)))
   ((new-context current-return-value)
    (unless (profun-accept-obj? current-return-value)
      (raisu 'current-return-value-must-be-a-profun-accept-obj current-return-value))

    (let* ((alist (profun-accept-alist current-return-value)))
      (profun-accept-constructor alist new-context #t)))))

(define-syntax profun-set-meta
  (syntax-rules ()
    ((_ (variable <- variable-value))
     (profun-set-meta-fn variable variable-value (profun-accept)))
    ((_ (variable <- variable-value) current-return-value)
     (profun-set-meta-fn variable variable-value current-return-value))))

(define-syntax profun-set-parameter
  (syntax-rules ()
    ((_ (param <- variable-value))
     (profun-set-parameter (param <- variable-value) (profun-accept)))
    ((_ (param <- variable-value) current-return-value)
     (let ()
       (unless (procedure? param)
         (raisu 'type-error "Expected a parameter, got something else" param))
       (param 'set variable-value current-return-value)))))
