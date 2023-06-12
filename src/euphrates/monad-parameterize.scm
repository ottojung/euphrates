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




(define-syntax monad-parameterize
  (syntax-rules ()
    ((_ f . body)
     (parameterize ((monad-transformer-current/p f))
       (begin . body)))))

(define-syntax with-monad-left
  (syntax-rules ()
    ((_ f . body)
     (let ((current-monad (monad-transformer-current/p)))
       (let ((new-monad
              (lambda (old-monad old-monad-quoted)
                (let ((applied (if current-monad
                                   (current-monad old-monad old-monad-quoted)
                                   old-monad)))
                  (monad-compose f applied)))))
         (parameterize ((monad-transformer-current/p new-monad))
           (begin . body)))))))

(define-syntax with-monad-right
  (syntax-rules ()
    ((_ f . body)
     (let ((current-monad (monad-transformer-current/p)))
       (let ((new-monad
              (lambda (old-monad old-monad-quoted)
                (let ((applied (if current-monad
                                   (current-monad old-monad old-monad-quoted)
                                   old-monad)))
                  (monad-compose applied f)))))
         (parameterize ((monad-transformer-current/p new-monad))
           (begin . body)))))))
