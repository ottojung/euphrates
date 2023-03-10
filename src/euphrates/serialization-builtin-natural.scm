;;;; Copyright (C) 2022  Otto Jung
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

(cond-expand
 (guile
  (define-module (euphrates serialization-builtin-natural)
    :export (serialize-builtin/natural deserialize-builtin/natural)
    :use-module ((euphrates atomic-box) :select (atomic-box-ref atomic-box? make-atomic-box))
    :use-module ((euphrates box) :select (box-ref box? make-box))
    :use-module ((euphrates raisu) :select (raisu)))))

;; NOTE: does not handle `procedure's!



(cond-expand
 (guile
  (use-modules (ice-9 hash-table))

  (define (serialize/human-hashtable? o) (hash-table? o))
  (define (serialize/human-hashtable o) (hash-map->list cons o))
  (define (deserialize/human-hashtable o) (alist->hash-table o))
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
     ((parameter? o) `(make-parameter ,@(loop (o))))
     ((equal? (when #f #f) o) o)
     ((eof-object? o) o)
     ((serialize/human-hashtable? o) `(alist->hash-table ,(loop (serialize/human-hashtable o))))
     ((box? o) `(box ,(loop (box-ref o))))
     ((atomic-box? o) `(box ,(loop (atomic-box-ref o))))
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

     ((pair? o)
      (case (car o)
        ((quote) (cadr o))
        ((list) (map loop (cdr o)))
        ((cons) (cons (loop (cadr o)) (loop (caddr o))))
        ((vector) (apply vector (map loop (cdr o))))
        ((make-parameter) (make-parameter (loop (cadr o))))
        ((alist->hash-table) (deserialize/human-hashtable (loop (cadr o))))
        ((make-box) (make-box (loop (cadr o))))
        ((make-atomic-box) (make-atomic-box (loop (cadr o))))
        (else (fail))))
     (else (raisu 'unknown-builtin-object o))))))
