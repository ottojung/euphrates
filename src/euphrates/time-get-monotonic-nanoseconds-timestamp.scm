;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;; NOTE: this time is not parameterized because of performance penalty that would introduce.
;; Therefore, this timestamp should only be used for non-deterministic stuff, or the stuff that noone cares to test.

(cond-expand
 (guile

  (define time-get-monotonic-nanoseconds-timestamp
    (let [[time-to-nanoseconds
           (lambda [time]
             (+ (time-nanosecond time)
                (* 1000000000 (time-second time))))]]
      (lambda _
        (time-to-nanoseconds
         (current-time time-monotonic)))))

  )

 (racket

  (define [time-get-monotonic-nanoseconds-timestamp]
    (ceiling
     (* 1000000
    (current-inexact-milliseconds))))

  ))
