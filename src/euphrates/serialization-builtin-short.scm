;;;; Copyright (C) 2022, 2023  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
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


;; NOTE: does not handle `procedure's!



(cond-expand
 (guile
  (define (serialize/short-hashtable? o) (hash-table? o))
  (define (serialize/short-hashtable o) (hash-map->list cons o))
  (define (deserialize/short-hashtable o) (alist->hash-table o))
  (define (is-parameter? o) (parameter? o))
  ))

(define serialize-builtin/short
  (case-lambda
   ((o loop)
    (serialize-builtin/short
     o loop
     (lambda _ (raisu 'unknown-builtin-type 'serialize o))))
   ((o loop fail)
    (cond
     ((list? o) (map loop o))
     ((pair? o) (cons (loop (car o)) (loop (cdr o))))
     ((vector? o) (apply vector (map loop (vector->list o))))
     ((is-parameter? o) (make-parameter (loop (o))))
     ((box? o) (make-box (loop (box-ref o))))
     ((atomic-box? o) (make-atomic-box (loop (atomic-box-ref o))))
     ((serialize/short-hashtable? o)
      `(@hash-table ,(loop (serialize/short-hashtable o))))
     ((symbol? o)
      (if (string-prefix? "@" (symbol->string o))
          `(@quote ,o)
          o))
     ((builtin-type? o) o)
     (else (fail))))))

(define deserialize-builtin/short
  (case-lambda
   ((o loop)
    (deserialize-builtin/short
     o loop
     (lambda _ (raisu 'unknown-tag o))))
   ((o loop fail)
    (cond
     ((list? o)
      (if (not (null? o))
          (case (car o)
            ((@hash-table)
             (deserialize/short-hashtable (loop (cadr o))))
            ((@quote) (cadr o))
            (else (map loop o)))
          (map loop o)))
     ((pair? o) (cons (loop (car o)) (loop (cdr o))))
     ((vector? o) (apply vector (map loop (vector->list o))))
     ((is-parameter? o) (make-parameter (loop (o))))
     ((box? o) (make-box (loop (box-ref o))))
     ((atomic-box? o) (make-atomic-box (loop (atomic-box-ref o))))
     ((builtin-type? o) o)
     ((and (symbol? o) (not (string-prefix? "@" (symbol->string o)))) o)
     (else (fail))))))
