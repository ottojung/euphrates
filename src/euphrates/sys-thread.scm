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


;; TODO: add sys-thread-parameterize-env



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
      th)))

 (racket

  (define (sys-thread-spawn thunk)
    (let ((th (sys-thread-obj #f #f #t)))
      (set-sys-thread-obj-handle!
       th
       (thread thunk))
      th))))

(define (sys-thread-yield)
  (let ((me (sys-thread-current)))
    (when (and (sys-thread-obj-cancel-scheduled? me)
               (sys-thread-obj-cancel-enabled? me))
      (raisu dynamic-thread-cancel-tag))))

(define sys-thread-mutex-make sys-mutex-make)
(define sys-thread-mutex-lock! sys-mutex-lock!)
(define sys-thread-mutex-unlock! sys-mutex-unlock!)


