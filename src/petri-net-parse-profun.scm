;;;; Copyright (C) 2021  Otto Jung
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

%var petri-profun-net

%use (petri-push) "./petri.scm"
%use (petri-net-make) "./petri-net-make.scm"
%use (profun-op-unify) "./profun-op-unify.scm"
%use (profun-op-separate) "./profun-op-separate.scm"
%use (profun-op+) "./profun-op-plus.scm"
%use (profun-op*) "./profun-op-mult.scm"
%use (profun-op-less) "./profun-op-less.scm"
%use (profun-op-divisible) "./profun-op-divisible.scm"
%use (profun-op-apply) "./profun-op-apply.scm"
%use (profun-op-eval) "./profun-op-eval.scm"
%use (profun-op-print) "./profun-op-print.scm"
%use (profun-make-handler) "./profun-make-handler.scm"
%use (profun-create-database profun-eval-query) "./profun.scm"
%use (list-deduplicate) "./list-deduplicate.scm"
%use (multi-alist->hashmap) "./ihashmap.scm"
%use (raisu) "./raisu.scm"

(define (petri-profun-push argv ctx)
  (and (not ctx)
       (begin
         (unless (pair? argv)
           (raisu 'empty-profun-push argv))

         (unless (list? (car argv))
           (raisu 'profun-push-first-argument-is-not-list argv))

         (unless (symbol? (car (car argv)))
           (raisu 'profun-push-car-of-first-argument-is-not-symbol argv))

         (let ((name (cadr (car argv)))
               (args (cdr argv)))
           (apply petri-push (cons name args))
           #t))))

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
