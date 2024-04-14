;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; depends on uni-spinlock
(define printf/threadsafe
  (let ((critical (make-uni-spinlock-critical)))
    (lambda (fmt args)
      (let ((err #f))
        (critical
         (lambda ()
           (catch-any
            (lambda _
              (display (apply stringf (cons fmt args))))
            (lambda argv
              (set! err argv)))))
        (when err (apply raisu err))))))
