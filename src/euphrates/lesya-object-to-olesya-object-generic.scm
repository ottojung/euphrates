;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lesya-object->olesya-object/generic first-handler object)
  (let loop ((object object))
    (define-values (first? first)
      (first-handler object))

    (cond
     (first? first)

     ((olesya:return:ok? object)
      (olesya:return:map loop object))

     ((lesya:syntax:rule? object)
      object)

     ((lesya:syntax:specify? object)
      (let ()
        (define-values (variable replacement)
          (lesya:syntax:specify:destruct object 'impossible:must-be-specify))

        (olesya:syntax:rule:make
         variable
         replacement)))

     ((lesya:syntax:substitution? object)
      (let ()
        (define-values (rule argument)
          (lesya:syntax:substitution:destruct object 'impossible:must-be-substitution))

        (olesya:syntax:substitution:make
         (loop rule)
         (loop argument))))

     ((lesya:syntax:implication? object)
      (let ()
        (define-values (premise consequence)
          (lesya:syntax:implication:destruct object 'impossible:must-be-implication))

        (olesya:syntax:rule:make
         (loop premise)
         (loop consequence))))

     ((lesya:syntax:axiom? object)
      (let ()
        (define obj (lesya:syntax:axiom:destruct object 'impossible:must-be-axiom))
        (loop obj)))

     ((or (symbol? object) (list? object) (null? object))
      (olesya:syntax:term:make object))

     (else object))))
