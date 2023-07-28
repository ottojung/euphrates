;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (seconds->string-columned seconds)
  (define second 1)
  (define minute (* 60 second))
  (define hour (* 60 minute))
  (define day (* 24 hour))

  (define (get size current)
    (define div (/ current size))
    (define quot (exact (floor div)))
    (define rem (- current (* size quot)))
    (values quot rem))

  (define-values (ndays after-days) (get day seconds))
  (define-values (nhours after-hours) (get hour after-days))
  (define-values (nminutes after-minutes) (get minute after-hours))
  (define-values (nseconds after-seconds) (get second after-minutes))

  (define (pad s)
    (if (string-null? s) s
        (string-pad-L s 2 #\0)))
  (define (stringify n)
    (number->string
     (if (integer? n) (exact n) (inexact n))))
  (define (connect s)
    (if (string-null? s) s
        (string-append s ":")))

  (define large
    (list-drop-while
     (comp (= 0))
     (list ndays nhours nminutes)))

  (if (equal? 0 seconds) "0"
      (apply
       string-append
       (append
        (appcomp
         large
         reverse (list-drop-n 2) reverse
         (map (comp stringify connect)))
        (appcomp
         large
         reverse (list-take-n 2) reverse
         (map (comp stringify pad connect)))
        (appcomp
         (list nseconds)
         (map (comp stringify pad)))
        (appcomp
         (list after-seconds)
         (filter (negate (comp (equal? 0))))
         (map (comp
               inexact
               number->string
               string->list cdr list->string)))))))
