;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (olesya:language:eval expr)
  (define wrapped (list 'begin expr)) ;; need this to not polute the outer scope.
  (eval wrapped olesya:environment))


(define olesya:environment
  (environment
   '(rename (euphrates olesya-interpret)
            (olesya:language:eval eval))
   '(rename (euphrates olesya-language)
            (olesya:language:term term)
            (olesya:language:rule rule)
            (olesya:language:define define)
            (olesya:language:let let)
            (olesya:language:= =)
            (olesya:language:map map)
            (olesya:language:begin begin))))


(define (olesya:interpret program)
  (olesya:language:run
   (olesya:language:eval program)))
