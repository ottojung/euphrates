;;;; Copyright (C) 2023  Otto Jung
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
  (define-module (euphrates with-singlethread-env)
    :export (with-singlethread-env)
    :use-module ((euphrates dynamic-thread-cancel-p) :select (dynamic-thread-cancel#p))
    :use-module ((euphrates dynamic-thread-critical-make-p) :select (dynamic-thread-critical-make#p))
    :use-module ((euphrates dynamic-thread-disable-cancel-p) :select (dynamic-thread-disable-cancel#p))
    :use-module ((euphrates dynamic-thread-enable-cancel-p) :select (dynamic-thread-enable-cancel#p))
    :use-module ((euphrates dynamic-thread-mutex-lock-p) :select (dynamic-thread-mutex-lock!#p))
    :use-module ((euphrates dynamic-thread-mutex-make-p) :select (dynamic-thread-mutex-make#p))
    :use-module ((euphrates dynamic-thread-mutex-unlock-p) :select (dynamic-thread-mutex-unlock!#p))
    :use-module ((euphrates dynamic-thread-sleep-p) :select (dynamic-thread-sleep#p))
    :use-module ((euphrates dynamic-thread-spawn-p) :select (dynamic-thread-spawn#p))
    :use-module ((euphrates dynamic-thread-yield-p) :select (dynamic-thread-yield#p))
    :use-module ((euphrates sys-usleep) :select (sys-usleep))
    )))

(define-syntax with-singlethread-env
  (syntax-rules ()
    ((_ . bodies)
     (parameterize ((dynamic-thread-spawn#p (lambda (thunk) (thunk)))
                    (dynamic-thread-sleep#p sys-usleep)

                    (dynamic-thread-cancel#p (lambda _ #f))
                    (dynamic-thread-disable-cancel#p (lambda _ #f))
                    (dynamic-thread-enable-cancel#p (lambda _ #f))
                    (dynamic-thread-yield#p (lambda _ #f))
                    (dynamic-thread-mutex-make#p (lambda _ #f))
                    (dynamic-thread-mutex-lock!#p (lambda _ #f))
                    (dynamic-thread-mutex-unlock!#p (lambda _ #f))
                    (dynamic-thread-critical-make#p (lambda _ #f)))
       (let () . bodies)))))
