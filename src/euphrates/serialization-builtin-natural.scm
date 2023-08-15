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
  (define (serialize/human-hashtable? o) (hash-table? o))
  (define (serialize/human-hashtable o) (hash-map->list cons o))
  (define (deserialize/human-hashtable o) (alist->hash-table o))
  (define (is-parameter? o) (parameter? o))
  ))

(define serialize-builtin/natural
  (case-lambda
   ((o loop)
    (serialize-builtin/natural
     o loop
     (lambda _
       (raisu 'unknown-builtin-type 'serialize o))))
   ((o loop fail)
    (cond
     ((number? o) o)
     ((string? o) o)
     ((symbol? o) `(quote ,o))
     ((char? o) o)
     ((equal? #t o) o)
     ((equal? #f o) o)
     ((list? o) `(list ,@(map loop o)))
     ((pair? o) `(cons ,(loop (car o)) ,(loop (cdr o))))
     ((vector? o) `(vector ,@(map loop o)))
     ((is-parameter? o) `(make-parameter ,@(loop (o))))
     ((error-object? o) `(error-object ,(loop (error-object-message o)) ,@(map loop (error-object-irritants o))))
     ((equal? (when #f #f) o) '*unspecified*)
     ((eof-object? o) '*eof-object*)
     ((serialize/human-hashtable? o) `(alist->hash-table ,(loop (serialize/human-hashtable o))))
     ((box? o) `(make-box ,(loop (box-ref o))))
     ((atomic-box? o) `(make-atomic-box ,(loop (atomic-box-ref o))))
     (else (fail))))))

(define deserialize-builtin/natural
  (case-lambda
   ((o loop)
    (deserialize-builtin/natural
     o loop
     (lambda _ (raisu 'unknown-tag (car o)))))
   ((o loop fail)
    (cond
     ((number? o) o)
     ((string? o) o)
     ((char? o) o)
     ((equal? #t o) o)
     ((equal? #f o) o)
     ((equal? o '*eof-object*) (eof-object))
     ((equal? o '*unspecified*) (when #f #f))

     ((pair? o)
      (case (car o)
        ((quote) (cadr o))
        ((list) (map loop (cdr o)))
        ((cons) (cons (loop (cadr o)) (loop (caddr o))))
        ((vector) (apply vector (map loop (cdr o))))
        ((make-parameter) (make-parameter (loop (cadr o))))
        ((error-object) (apply make-error-object (cdr o)))
        ((alist->hash-table) (deserialize/human-hashtable (loop (cadr o))))
        ((make-box) (make-box (loop (cadr o))))
        ((make-atomic-box) (make-atomic-box (loop (cadr o))))
        (else (fail))))
     (else (raisu 'unknown-builtin-object o))))))
