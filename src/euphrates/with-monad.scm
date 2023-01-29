;;;; Copyright (C) 2022  Otto Jung
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
  (define-module (euphrates with-monad)
    :export (with-monad)
    :use-module ((euphrates monad-apply) :select (monad-apply))
    :use-module ((euphrates monad-current-p) :select (monad-current/p))
    :use-module ((euphrates monad-transformer-current-p) :select (monad-transformer-current/p))
    :use-module ((euphrates monadfinobj) :select (monadfinobj))
    :use-module ((euphrates monadstate) :select (monadstate-arg)))))



(define-syntax with-monad
  (syntax-rules ()
    ((_ fexpr body . bodies)
     (let* ((p (monad-transformer-current/p))
            (f fexpr)
            (m (if p (p f (quote fexpr)) f)))
       (parameterize ((monad-current/p m))
         (call-with-values
             (lambda _ body . bodies)
           (lambda results
             (monadstate-arg
              (monad-apply m (monadfinobj (lambda _ results)))))))))))
