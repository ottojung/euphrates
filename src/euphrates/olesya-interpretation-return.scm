;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 <olesya:return:ok>
  (olesya:return:ok value) olesya:return:ok?
  (value olesya:return:ok:value))


(define-type9 <olesya:return:fail>
  (olesya:return:fail value) olesya:return:fail?
  (value olesya:return:fail:value))


(define (olesya:return? object)
  (cond
   ((olesya:return:ok? object)
    #t)

   ((olesya:return:fail? object)
    #t)

   (else
    #f)))


(define (olesya:return:value object)
  (cond
   ((olesya:return:ok? object)
    (olesya:return:ok:value object))

   ((olesya:return:fail? object)
    (olesya:return:fail:value object))

   (else
    (raisu-fmt
     'expected-ok-or-fail
     "Wrong type of object. Expected ok or fail, got ~s." object))))


(define (olesya:return:type object)
  (cond
   ((olesya:return:ok? object)
    'ok)

   ((olesya:return:fail? object)
    'fail)

   (else
    (raisu-fmt
     'expected-ok-or-fail
     "Wrong type of object. Expected ok or fail, got ~s." object))))


(define (olesya:return:map function object)
  (cond
   ((olesya:return:ok? object)
    (olesya:return:ok (function (olesya:return:ok:value object))))

   ((olesya:return:fail? object)
    (olesya:return:fail (function (olesya:return:fail:value object))))

   (else
    (raisu-fmt
     'expected-ok-or-fail
     "Wrong type of object. Expected ok or fail, got ~s." object))))
