;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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
  (define-module (euphrates profun-make-tuple-set)
    :export (profun-make-tuple-set)
    :use-module ((euphrates profun-accept) :select (profun-accept profun-ctx-set profun-set))
    :use-module ((euphrates profun-op-lambda) :select (profun-op-lambda))
    :use-module ((euphrates profun-reject) :select (profun-reject))
    :use-module ((euphrates profun-value) :select (profun-unbound-value?)))))

;; Used in bottom-handler to return just some predefined multi-values.
;; Really this creates a hypergraph.


(define (try-assign-multi args names lst)
  (let loop ((i 0)
             (args args)
             (lst lst)
             (ret (profun-accept)))
    (define (continue new-ret) (loop (+ 1 i) (cdr args) (cdr lst) new-ret))

    (if (null? args) ret
        (let ((a (car args))
              (v (car lst)))
          (case v
            ((#t) (continue ret))
            ((#f) (and (profun-unbound-value? a)
                       (continue ret)))
            (else
             (if (profun-unbound-value? a)
                 (continue (profun-set ((list-ref names i) <- v) ret))
                 (and (equal? a v)
                      (continue ret)))))))))

(define (assign-multi args names lst)
  (let loop ((lst lst))
    (if (null? lst)
        (profun-reject)
        (let ((try (try-assign-multi args names (car lst))))
          (if try
              (profun-ctx-set
               (cdr lst) try)
              (loop (cdr lst)))))))

(define-syntax profun-make-tuple-set/help
  (syntax-rules ()
    ((_ args-list args value)
     (let ((lst #f))
       (profun-op-lambda
        (ctx args-list names)
        (define ctxx
          (or ctx (begin (unless lst (set! lst value)) lst)))
        (assign-multi args names ctxx))))))

(define-syntax profun-make-tuple-set
  (syntax-rules ()
    ((_ (a . args) value)
     (profun-make-tuple-set/help (a . args) (list a . args) value))
    ((_ args value)
     (profun-make-tuple-set/help args args value))))
