;;;; Copyright (C) 2019, 2020, 2021  Otto Jung
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
  (define-module (euphrates sys-thread)
    :export (sys-thread-cancel sys-thread-current sys-thread-disable-cancel sys-thread-enable-cancel sys-thread-mutex-make sys-thread-mutex-lock! sys-thread-mutex-unlock! sys-thread-spawn sys-thread-sleep)
    :use-module ((euphrates sys-thread-obj) :select (sys-thread-obj sys-thread-obj? sys-thread-obj-handle set-sys-thread-obj-handle! sys-thread-obj-cancel-scheduled? set-sys-thread-obj-cancel-scheduled?! sys-thread-obj-cancel-enabled? set-sys-thread-obj-cancel-enabled?!))
    :use-module ((euphrates sys-usleep) :select (sys-usleep))
    :use-module ((euphrates sys-mutex-make) :select (sys-mutex-make))
    :use-module ((euphrates sys-mutex-lock) :select (sys-mutex-lock!))
    :use-module ((euphrates sys-mutex-unlock) :select (sys-mutex-unlock!))
    :use-module ((euphrates sys-thread-current-p) :select (sys-thread-current#p))
    :use-module ((euphrates sys-thread-current-p-default) :select (sys-thread-current#p-default))
    :use-module ((euphrates dynamic-thread-cancel-tag) :select (dynamic-thread-cancel-tag))
    :use-module ((euphrates raisu) :select (raisu)))))

;; TODO: add sys-thread-parameterize-env





(cond-expand
 (guile
  (use-modules (ice-9 threads))
  ))

(define (sys-thread-cancel th)
  (set-sys-thread-obj-cancel-scheduled?! th #t))

(define (sys-thread-current)
  (or (sys-thread-current#p)
      sys-thread-current#p-default))

(define (sys-thread-disable-cancel)
  (let ((me (sys-thread-current)))
    (set-sys-thread-obj-cancel-enabled?! me #f)))

(define (sys-thread-enable-cancel)
  (let ((me (sys-thread-current)))
    (set-sys-thread-obj-cancel-enabled?! me #t)))

(define (sys-thread-sleep microseconds)
  (sys-usleep microseconds)
  (sys-thread-yield))

(cond-expand
 (guile

  (define (sys-thread-spawn thunk)
    (let ((th (sys-thread-obj #f #f #t)))
      (set-sys-thread-obj-handle!
       th
       (call-with-new-thread thunk))
      th))

  ))
(cond-expand
 (racket

  (define (sys-thread-spawn thunk)
    (let ((th (sys-thread #f #f #t)))
      (set-sys-thread-handle!
       th
       (thread thunk))
      th))

  ))

(define (sys-thread-yield)
  (let ((me (sys-thread-current)))
    (when (and (sys-thread-obj-cancel-scheduled? me)
               (sys-thread-obj-cancel-enabled? me))
      (raisu dynamic-thread-cancel-tag))))

(define sys-thread-mutex-make sys-mutex-make)
(define sys-thread-mutex-lock! sys-mutex-lock!)
(define sys-thread-mutex-unlock! sys-mutex-unlock!)


