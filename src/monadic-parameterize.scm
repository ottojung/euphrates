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

%var monadic-parameterize
%var with-monadic-left
%var with-monadic-right

%use (monadic-global/p) "./monadic-global-p.scm"

(define-syntax monadic-parameterize
  (syntax-rules ()
    ((_ f . body)
     (parameterize ((monadic-global/p f))
       (begin . body)))))

(define-syntax with-monadic-left
  (syntax-rules ()
    ((_ f . body)
     (let ((current-monad (monadic-global/p)))
       (let ((new-monad
              (lambda (old-monad old-monad-quoted)
                (let ((applied (if current-monad
                                   (current-monad old-monad old-monad-quoted)
                                   old-monad)))
                  (compose f applied)))))
         (parameterize ((monadic-global/p new-monad))
           (begin . body)))))))

(define-syntax with-monadic-right
  (syntax-rules ()
    ((_ f . body)
     (let ((current-monad (monadic-global/p)))
       (let ((new-monad
              (lambda (old-monad old-monad-quoted)
                (let ((applied (if current-monad
                                   (current-monad old-monad old-monad-quoted)
                                   old-monad)))
                  (compose applied f)))))
         (parameterize ((monadic-global/p new-monad))
           (begin . body)))))))
