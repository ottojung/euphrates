;;;; Copyright (C) 2020, 2021  Otto Jung
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

%run guile

;; Used in bottom-handler to return just some predefined multi-values.
;; Really this creates a hypergraph.
%var profun-make-tuple-set

%use (profun-accept profun-ctx-set profun-set) "./profun-accept.scm"
%use (profun-reject) "./profun-reject.scm"
%use (profun-unbound-value?) "./profun.scm"

(define (try-assign-multi args lst)
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
                 (continue (profun-set ([i] <- v) ret))
                 (and (equal? a v)
                      (continue ret)))))))))

(define (assign-multi args lst)
  (let loop ((lst lst))
    (if (null? lst)
        (profun-reject)
        (let ((try (try-assign-multi args (car lst))))
          (if try
              (profun-ctx-set
               (cdr lst) try)
              (loop (cdr lst)))))))

(define-syntax profun-make-tuple-set
  (syntax-rules ()
    ((_ value)
     (let ((lst #f))
       (lambda (args ctx)
         (define ctxx
           (or ctx (begin (unless lst (set! lst value)) lst)))
         (assign-multi args ctxx))))))
