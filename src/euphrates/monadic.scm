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
  (define-module (euphrates monadic)
    :export (monadic-bare monadic)
    :use-module ((euphrates identity-star) :select (identity*))
    :use-module ((euphrates monad-current-p) :select (monad-current/p))
    :use-module ((euphrates monad-do) :select (monad-do/generic))
    :use-module ((euphrates with-monad) :select (with-monad)))))



;; This is something like "do syntax" from Haskell
(define-syntax monadic-bare-helper
  (syntax-rules ()

    ((_ f ((x . xs) y . tags) . ())
     (monad-do/generic
      (f (x . xs) y (list . tags))
      identity*))

    ((_ f ((x . xs) y . tags) . bodies)
     (monad-do/generic
      (f (x . xs) y (list . tags))
      (lambda (x . xs) (monadic-bare-helper f . bodies))))

    ((_ f (x y . tags) . ())
     (monad-do/generic
      (f x y (list . tags))
      identity))

    ((_ f (x y . tags) . bodies)
     (monad-do/generic
      (f x y (list . tags))
      (lambda (x) (monadic-bare-helper f . bodies))))))

(define-syntax monadic
  (syntax-rules ()
    ((_ fexpr . argv)
     (with-monad
      fexpr
      (let ((m (monad-current/p)))
        (call-with-values
            (lambda _
              (monadic-bare-helper m . argv))
          (lambda results
            (apply values (map (lambda (f) (f)) results)))))))))
