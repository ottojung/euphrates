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

%run guile

%var with-monad

%use (monad-current/p) "./monad-current-p.scm"
%use (monadfinobj) "./monadfinobj.scm"
%use (monadic-global/p) "./monadic-global-p.scm"
%use (monadstate-current/p) "./monadstate-current-p.scm"
%use (monadstate-arg monadstate-make-empty) "./monadstate.scm"

(define-syntax with-monad
  (syntax-rules ()
    ((_ fexpr body . bodies)
     (let* ((p (monadic-global/p))
            (f fexpr)
            (m (if p (p f (quote fexpr)) f)))
       (parameterize ((monad-current/p m)
                      (monadstate-current/p (monadstate-make-empty)))
         (call-with-values
             (lambda _ body . bodies)
           (lambda results
             (monadstate-arg
              (m (monadfinobj (lambda _ results)))))))))))

