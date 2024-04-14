;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; This is like futures.
;; Use this when need to join a thread.

(define (dynamic-thread-async-thunk thunk)
  (define status #f) ;; \in { #f, 'ok, 'fail }
  (define results #f)
  (define lock (dynamic-thread-mutex-make))
  (define thread
    (begin
      (dynamic-thread-mutex-lock! lock)
      (dynamic-thread-spawn
       (lambda ()
         (catch-any
          (lambda ()
            (call-with-values thunk
              (lambda vals
                (set! results vals)
                (set! status 'ok)
                (dynamic-thread-mutex-unlock! lock))))
          (lambda errors
            (set! results errors)
            (set! status 'fail)
            (dynamic-thread-mutex-unlock! lock)))))))

  (define (wait/no-throw)
    (dynamic-thread-mutex-lock! lock)
    (dynamic-thread-mutex-unlock! lock))

  (define (wait)
    (wait/no-throw)
    (when (eq? 'fail status)
      (raisu 'dynamic-thread-run-async-failed results))
    (apply values results))

  (case-lambda
   (() (wait))
   ((operation)
    (case operation
      ((wait) (wait))
      ((wait/no-throw) (wait/no-throw))
      ((thread) thread)
      ((status) status)
      ((results) results)))))
