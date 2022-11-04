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

(define (try-assign-multi args lst)
  (let loop ((i 0)
             (args args)
             (lst lst)
             (ret (profun-accept)))
    (if (null? args) ret
        (if (not (car args))
            (if (or (not (car lst))
                    (equal? #t (car lst)))
                (loop (+ 1 i) (cdr args) (cdr lst) ret)
                (loop (+ 1 i) (cdr args) (cdr lst)
                      (profun-set ([i] <- (car lst)) ret)))
            (and (or (equal? #t (car lst)) (equal? (car args) (car lst))) ;; they are equal
                 (loop (+ 1 i) (cdr args) (cdr lst) ret))))))

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
