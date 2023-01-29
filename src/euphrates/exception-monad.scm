;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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

(cond-expand
 (guile
  (define-module (euphrates exception-monad)
    :export (exception-monad)
    :use-module ((euphrates catch-any) :select (catch-any))
    :use-module ((euphrates cons-bang) :select (cons!))
    :use-module ((euphrates monad-make-no-cont) :select (monad-make/no-cont))
    :use-module ((euphrates monadfinobj) :select (monadfinobj?))
    :use-module ((euphrates monadstate) :select (monadstate-arg monadstate-lval monadstate-qtags monadstate-ret monadstate-ret/thunk))
    :use-module ((euphrates raisu) :select (raisu)))))



(define (exception-monad)
  (let ((exceptions '()))
    (monad-make/no-cont
     (lambda (monad-input)
       (if (monadfinobj? monad-input)
           (monadstate-ret monad-input
                           (if (null? exceptions)
                               (monadstate-arg monad-input)
                               (apply raisu 'except-monad exceptions)))
           (if (or (null? exceptions)
                   (memq 'always (monadstate-qtags monad-input)))
               (monadstate-ret/thunk
                monad-input
                (catch-any
                 (lambda _
                   (call-with-values
                       (lambda _ ((monadstate-lval monad-input)))
                     (lambda vals
                       (lambda _ (apply values vals)))))
                 (lambda args
                   (cons! args exceptions)
                   (lambda _ (raisu 'exception-monad-default)))))
               (monadstate-ret/thunk
                monad-input
                (lambda _ (raisu 'exception-monad-default)))))))))
