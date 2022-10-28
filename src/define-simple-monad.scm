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

%var define-simple-monad

%use (monadfin?) "./monadfin.scm"

(define-syntax define-simple-monad
  (syntax-rules ()
    ((_ (fn-name monad-input-name) . bodies)
     (define fn-name
       (lambda (monad-something)
         (if (monadfin? monad-something) monad-something
             ((lambda (monad-input-name) . bodies)
              monad-something)))))))
