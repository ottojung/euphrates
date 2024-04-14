;;;; Copyright (C) 2020, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; Universal spinlock
;; Works for any thread model
;; Very wasteful
(define-values
    (make-uni-spinlock
     uni-spinlock-lock!
     uni-spinlock-unlock!
     make-uni-spinlock-critical)

  (let* ((make (lambda () (make-atomic-box #f)))

         (lock
          (lambda (o)
            (let ((yield (dynamic-thread-get-yield-procedure)))
              (let lp ()
                (unless (atomic-box-compare-and-set!
                         o #f #t)
                  (yield)
                  (lp))))))

         (unlock
          (lambda (o)
            (atomic-box-set! o #f)))

         (critical
          (lambda ()
            (let ((box (make)))
              (lambda (thunk)
                (dynamic-thread-disable-cancel)
                (lock box)
                (let ((ret (thunk)))
                  (unlock box)
                  (dynamic-thread-enable-cancel)
                  ret))))))
    (values make lock unlock critical)))
