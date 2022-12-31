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

%run guile

%var profun-op-equals

%use (list-and-map) "./list-and-map.scm"
%use (profun-ctx-set profun-set) "./profun-accept.scm"
%use (profun-op-lambda) "./profun-op-lambda.scm"
%use (profun-reject) "./profun-reject.scm"
%use (make-profun-RFC) "./profun-RFC.scm"
%use (profun-unbound-value?) "./profun-value.scm"

(define (profun-op-equals-argument? lst)
  (define (pairs? elem)
    (and (list? elem)
         (list-and-map
          (lambda (p)
            (and (pair? p)
                 (symbol? (car p))))
          elem)))

  (and (list? lst)
       (list-and-map pairs? lst)))

(define (profun-op-equals-aux ctx)
  (if (null? ctx)
      (profun-reject)
      (let loop ((pairs (car ctx)))
        (if (null? pairs)
            (profun-ctx-set (cdr ctx))
            (let* ((x (car pairs))
                   (name (car x))
                   (value (cdr x)))
              (profun-set
               (name <- value)
               (loop (cdr pairs))))))))

(define profun-op-equals
  (profun-op-lambda
   (ctx (lst) (lst-name))
   (cond
    (ctx (profun-op-equals-aux ctx))
    ((profun-unbound-value? lst)
     (make-profun-RFC lst-name))
    ((profun-op-equals-argument? lst)
     (let ((ctxx (or ctx lst)))
       (profun-op-equals-aux ctxx)))
    (else
     (profun-reject)))))
