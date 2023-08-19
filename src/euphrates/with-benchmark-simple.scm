;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; NOTE: does some outputting!
;; And also runs the thunk two times.

(define (with-benchmark/simple/func name inputs func)
  (define (round-for-humans x)
    (exact->inexact (/ (round (* 100 x)) 100)))

  (define filename (string-append name ".json"))
  (call-with-output-file
      filename
    (lambda (p)
      (define _note
        (parameterize ((current-output-port (current-error-port)))
          (display "INFO: Run ")
          (write name)
          (display " started.")
          (newline)))

      (define time0 (with-run-time-estimate (func)))
      (define time (with-run-time-estimate (func)))

      (parameterize ((current-output-port (current-error-port)))
        (display "INFO: Run ")
        (write name)
        (display " finished in ")
        (write (round-for-humans time))
        (display " seconds.")
        (newline))

      (parameterize ((current-output-port p))
        (display "{")
        (newline)
        (display "    ")
        (write "time")
        (display ": ")
        (display time)
        (display ",")
        (newline)
        (display "    ")
        (write "name")
        (display ": ")
        (display name)
        (display ",")
        (newline)
        (display "    ")
        (write "time0")
        (display ": ")
        (display time0)
        (display ",")
        (newline)
        (display "    ")
        (write "inputs")
        (display ": ")
        (display "{")
        (newline)
        (for-each
         (lambda (x)
           (define-tuple (first? last? input) x)
           (define key (car input))
           (define value (cadr input))
           (display "        ")
           (write (~a key))
           (display ": ")
           (write value)
           (unless last? (display ","))
           (newline))
         (list-mark-ends inputs))
        (display "    }")
        (newline)
        (display "}")
        (newline)))))

(define-syntax with-benchmark/simple
  (syntax-rules (:name :inputs)
    ((_ :name name :inputs inputs . bodies)
     (let ()
       (define inputs* (quote inputs))
       (define func (lambda _ (let* inputs . bodies)))
       (with-benchmark/simple/func name inputs* func)))))
