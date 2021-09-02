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

%var petri-net-parse

%use (petri-net-obj) "./petri-net-obj.scm"
%use (raisu) "./raisu.scm"
%use (list-and-map) "./list-and-map.scm"
%use (multi-alist->hashmap hashmap-foreach hashmap-map) "./ihashmap.scm"

(define (petri-net-parse-verify-types list-of-transitions)

  (unless (list? list-of-transitions)
    (raisu 'parse-error 'list-of-transitions-must-be-a-list))

  (unless (list-and-map list? list-of-transitions)
    (raisu 'parse-error 'list-of-transitions-must-be-a-list-of-lists))

  (unless (list-and-map (lambda (lst) (= 3 (length lst))) list-of-transitions)
    (raisu 'parse-error 'list-of-transitions-must-be-a-list-of-lists-of-length-3))

  (unless (list-and-map symbol? (map car list-of-transitions))
    (raisu 'parse-error 'list-of-transitions-must-be-a-list-of-lists-where-first-element-is-symbol))

  (unless (list-and-map (lambda (n) (and (integer? n) (<= 0 n)))  (map cadr list-of-transitions))
    (raisu 'parse-error 'list-of-transitions-must-be-a-list-of-lists-where-second-element-is-nonnegative-integer))

  (unless (list-and-map procedure? (map caddr list-of-transitions))
    (raisu 'parse-error 'list-of-transitions-must-be-a-list-of-lists-where-third-element-is-procedure))

  #t)

;; Example `list-of-transitions':
;;   (list (list 'hello 0 (lambda () (display "Hello\n") (petri-push 'bye "Robert")))
;;         (list 'bye   1 (lambda (name) (display "Bye ") (display name) (display "!\n")))
;;         (list 'hi    0 (lambda () (display "Hi\n") (petri-push 'bye "Robert"))))
(define (petri-net-parse list-of-transitions)
  (define valid?
    (petri-net-parse-verify-types list-of-transitions))

  (define first-and-third-columns (map (lambda (p) (cons (car p) (caddr p))) list-of-transitions))
  (define transitions (multi-alist->hashmap first-and-third-columns))

  (define first-and-second-columns (map (lambda (p) (cons (car p) (cadr p))) list-of-transitions))
  (define arities0 (multi-alist->hashmap first-and-third-columns))
  (define arities (hashmap-map (lambda (key value) (car value)) arities0))

  (hashmap-foreach
   (lambda (key value)
     (define first (car value))
     (unless (list-and-map (lambda (elem) (= first elem)) (cdr value))
       (raisu 'parse-error 'list-of-transitions-has-different-arities-for-the-same-name key value)))
   arities0)

  (petri-net-obj transitions arities))
