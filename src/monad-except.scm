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

%run guile

%var monad-except

%use (monadstate-lval monadstate-qtags) "./monadstate.scm"
%use (monadfin?) "./monadfin.scm"
%use (monad-arg monad-ret monad-ret/thunk monad-replicate-multiple monad-handle-multiple) "./monad.scm"
%use (raisu) "./raisu.scm"
%use (catch-any) "./catch-any.scm"
%use (cons!) "./cons-bang.scm"

(define (monad-except)
  (let ((exceptions '()))
    (lambda (monad-input)
      (if (monadfin? monad-input)
          (monad-ret monad-input
                     (if (null? exceptions)
                         (monad-arg monad-input)
                         (apply raisu 'except-monad exceptions)))
          (if (or (null? exceptions)
                  (memq 'always (monadstate-qtags monad-input)))
              (monad-ret/thunk
               monad-input
               (catch-any
                (lambda _
                  (call-with-values
                      (lambda _ ((monadstate-lval monad-input)))
                    (lambda vals
                      (lambda _ (apply values vals)))))
                (lambda args
                  (cons! args exceptions)
                  (lambda _ (raisu 'monad-except-default)))))
              (monad-ret/thunk
               monad-input
               (lambda _ (raisu 'monad-except-default))))))))
