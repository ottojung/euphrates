;;;; Copyright (C) 2021, 2022  Otto Jung
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




(define petri-profun-push
  (profun-op-lambda
   (ctx argv names)
   (bool->profun-result
    (and (not ctx)
         (begin
           (unless (pair? argv)
             (raisu 'empty-profun-push argv))

           (unless (string? (car argv))
             (raisu 'profun-push-first-argument-is-not-string argv))

           (let ((name (string->symbol (car argv)))
                 (args (cdr argv)))
             (apply petri-push (cons name args))
             #t))))))

(define bottom-handler
  (profun-make-handler
   (= profun-op-unify)
   (!= profun-op-separate)
   (+ profun-op+)
   (* profun-op*)
   (< profun-op-less)
   (divisible profun-op-divisible)
   (apply profun-op-apply)
   (eval profun-op-eval)
   (print profun-op-print)
   (push petri-profun-push)))

;; Accepts usual profun definitions and returns respective petri network.
(define (petri-profun-net definitions)
  (define db (profun-create-database bottom-handler definitions))

  (define signatures (map car definitions))
  (define tr-names+duplicates (map (lambda (p) (cons (car p) (length (cdr p)))) signatures))
  (define tr-names (list-deduplicate tr-names+duplicates))
  (define transitions
    (map
     (lambda (tr-name)
       (define name (car tr-name))
       (cons tr-name
             (lambda args
               (define query `((,name ,@args)))
               (profun-eval-query db query))))
     tr-names))

  (petri-net-make (multi-alist->hashmap transitions)))
