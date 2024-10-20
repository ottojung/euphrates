;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Transforms `template` into `instance` by applying zero or more `olesya:syntax:rule`s.
;; Returns the rules as a list, or #f if unification is not possible.
;;
;; Importantly: this is not the usual bi-directional unification that is usually performed in logical systems (ex Prolog).
;;

(define (olesya:unify template instance)

  (define mappings
    (make-hashmap))
  (define rules
    (stack-make))
  (define (add-rule! left right)
    (hashmap-set! mappings left right)
    (stack-push! (olesya:syntax:rule:make left right))
    #t)

  (define success?
    (let loop ((template template)
               (instance instance))

      (cond
       ((symbol? template)
        (if (hashmap-has? mappings template)
            (let ()
              (define existing
                (hashmap-ref mappings template 'impossible-1273746))
              (equal? existing instance))
            (add-rule! template instance)))

       ((symbol? instance)
        #f)

       (else
        (and (pair? template)
             (pair? instance)
             (equal? (length template)
                     (length instance))
             (equal? (car template)
                     (car instance))
             (list-and-map loop
                           (cdr template)
                           (cdr instance)))))))

  (and success?
       (reverse (stack->list rules))))
