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

(cond-expand
 (guile
  (define-module (euphrates linux-get-memory-stat)
    :export (linux-get-memory-stat linux-get-memory-free%)
    :use-module ((euphrates read-lines) :select (read/lines))
    :use-module ((euphrates string-to-words) :select (string->words))
    :use-module ((euphrates comp) :select (comp))
    :use-module ((euphrates list-last) :select (list-last))
    :use-module ((euphrates raisu) :select (raisu)))))



(define linux-memory-file "/proc/meminfo")
(define linux-memory-total-prefix "MemTotal:")
(define linux-memory-free-prefix "MemAvailable:")

;; Returns alist statistics in kilobytes
(define (linux-get-memory-stat)
  (define lines (read/lines linux-memory-file))
  (define words-list (map string->words lines))
  (define totals (filter (comp car (equal? linux-memory-total-prefix)) words-list))
  (define frees (filter (comp car (equal? linux-memory-free-prefix)) words-list))

  (when (or (null? totals) (null? frees)
            (not (= 3 (length (list-last totals))))
            (not (= 3 (length (list-last frees)))))
    (raisu 'linux-memory-file-is-in-a-bad-shape-today lines))

  (let* ((total-s (cadr (list-last totals)))
         (total (string->number total-s))
         (total-unit (caddr (list-last totals)))
         (free-s (cadr (list-last frees)))
         (free (string->number free-s))
         (free-unit (caddr (list-last frees))))
    (unless (and (integer? total) (integer? free)
                 (member total-unit '("kb" "kB"))
                 (member free-unit '("kb" "kB")))
      (raisu 'linux-memory-file-units-are-in-a-bad-shape-today
             lines total total-unit free free-unit))

    `((total . ,total)
      (free  . ,free))))

(define (linux-get-memory-free%)
  (define stat (linux-get-memory-stat))
  (exact->inexact
   (/ (cdr (assoc 'free stat))
      (cdr (assoc 'total stat)))))
