;;;; Copyright (C) 2021  Otto Jung
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




(define (uni-critical-make)
  (let* ((mut (dynamic-thread-mutex-make))
         (lock! (dynamic-thread-mutex-lock!/p))
         (unlock! (dynamic-thread-mutex-unlock!/p))
         (disable (dynamic-thread-disable-cancel/p))
         (enable (dynamic-thread-enable-cancel/p)))
    (lambda (thunk)
      (disable)
      (lock! mut)
      (call-with-values thunk
        (lambda vals
          (unlock! mut)
          (enable)
          (apply values vals))))))



