;;;; Copyright (C) 2019, 2020, 2021, 2022, 2023  Otto Jung
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





;; Disables critical zones because in non-interruptible mode
;; user can assure atomicity by just not calling yield during its evalution.
;; Locks still work as previusly,
;; but implementation must be changed,
;; because system mutexes will not allow to do yield
;; while waiting on mutex.
(define (make-no-critical . args)
  (lambda (fn) (fn)))

(define (np-thread-parameterize-env make-critical thunk)
  (define-values
      (np-thread-run!
       np-thread-fork
       np-thread-cancel!
       np-thread-disable-cancel
       np-thread-enable-cancel
       np-thread-yield
       universal-usleep
       make-unique
       universal-lockr!
       universal-unlockr!
       np-thread-make-critical)
    (np-thread-make-env make-critical))
  (parameterize ((dynamic-thread-spawn/p np-thread-fork)
                 (dynamic-thread-cancel/p np-thread-cancel!)
                 (dynamic-thread-disable-cancel/p np-thread-disable-cancel)
                 (dynamic-thread-enable-cancel/p np-thread-enable-cancel)
                 (dynamic-thread-yield/p np-thread-yield)
                 (dynamic-thread-sleep/p universal-usleep)
                 (dynamic-thread-mutex-make/p make-unique)
                 (dynamic-thread-mutex-lock!/p universal-lockr!)
                 (dynamic-thread-mutex-unlock!/p universal-unlockr!)
                 (dynamic-thread-critical-make/p np-thread-make-critical))
    (np-thread-run! thunk)))

(define-syntax with-np-thread-env/non-interruptible
  (syntax-rules ()
    ((_ . bodies)
     (np-thread-parameterize-env
      make-no-critical
      (lambda () . bodies)))))
