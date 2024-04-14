;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; NOTE: does some outputting!
;; And also runs the thunk two times.


(define with-benchmark/timestamps/p
  (make-parameter #f))


(define-syntax with-benchmark/timestamp
  (syntax-rules ()
    ((_ title)
     (let ()
       (define time (current-jiffy))
       (define current (with-benchmark/timestamps/p))
       (stack-push! current (cons title time))))))


(define (with-benchmark/simple/func name inputs func)
  (define (round-for-humans x)
    (exact->inexact (/ (round (* 100 x)) 100)))

  (define resolution (jiffies-per-second))

  (define (translate-to-time tuple)
    (define title (car tuple))
    (define jiffies (cdr tuple))
    (define time (exact->inexact (/ jiffies resolution)))
    (cons title time))

  (define (translate-to-deltas measurements)
    (let loop ((prev-time (cdr (car measurements)))
               (rest (cdr measurements)))
      (if (null? rest) '()
          (let ()
            (define current-measurement (car rest))
            (define current-title (car current-measurement))
            (define current-time (cdr current-measurement))
            (define current-delta (- current-time prev-time))
            (define current-tuple (cons current-title current-delta))
            (cons current-tuple (loop current-time (cdr rest)))))))

  (define (measure-1 func)
    (define stack (stack-make))
    (parameterize ((with-benchmark/timestamps/p stack))
      (with-benchmark/timestamp "start")
      (func)
      (with-benchmark/timestamp "end"))

    (translate-to-deltas
     (map translate-to-time (reverse (stack->list stack)))))

  (define (get-times func)
    (define deltas (measure-1 func))
    (define overall-time
      (list-fold/semigroup
       + (map cdr deltas)))

    (values overall-time deltas))

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

      (define-values (time0 deltas0) (get-times func))
      (define-values (time deltas) (get-times func))

      (parameterize ((current-output-port (current-error-port)))
        (display "INFO: Run ")
        (write name)
        (display " finished in ")
        (write (round-for-humans time))
        (display " seconds.")
        (newline))

      (define (normalize-key key)
        (string-map
         (lambda (c)
           (cond
            ((equal? #\- c) #\_)
            ((equal? #\? c) #\q)
            ((equal? #\/ c) #\_)
            (else c)))
         (~a key)))
      (define inputs-alist
        (map (fn-cons normalize-key car) inputs))

      (define alltimes (vector time0 time))
      (define avgtime (list-number-average (vector->list alltimes)))

      (define rundate
        (date-get-current-string "~Y-~m-~dT~H:~M:~S-00:00"))

      (display-alist-as-json
       `((name . ,name)
         (time . ,time)
         (alltimes . ,alltimes)
         (avgtime . ,avgtime)
         (deltas . ,(vector deltas0 deltas))
         (inputs . ,inputs-alist)
         (rundate . ,rundate)
         (euphrates_revision_id . ,(get-euphrates-revision-id "?"))
         (euphrates_revision_date . ,(get-euphrates-revision-date "?"))
         (euphrates_revision_title . ,(get-euphrates-revision-title "?")))
       p)

      (newline p))))

(define-syntax with-benchmark/simple
  (syntax-rules (:name :inputs)
    ((_ :name name :inputs inputs . bodies)
     (let ()
       (define inputs* (quote inputs))
       (define func (lambda _ (let* inputs . bodies)))
       (with-benchmark/simple/func name inputs* func)))))
