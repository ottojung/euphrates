;;;; Copyright (C) 2021, 2022  Otto Jung
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

%run guile

;;
;; This prints words to a limited `start-x'-`end-x' window.
;; Useful for displaying text to the console.
;;
;; May be used in conjunction with `words` function,
;; like this `(print-in-window (list-intersperse #\space (words "...some long text...")))`
;;
;; For printing to the console, use `(getenv "COLUMNS") * 2` as `end-x` coordinate.
;;
;; Note: this does NOT insert newline at the end.
;;
;; `initial-x' is position of the cursor when printing starts, you should know it.
;; `fill-character' is what space is made of. By default should be #\space.
;;

%var print-in-window

%use (raisu) "./raisu.scm"
%use (replicate) "./replicate.scm"
%use (list-span-n) "./list-span-n.scm"

(define (print-in-window start-x end-x initial-x fill-character parts-or-string)
  (define (fill-space amount)
    (display (list->string (replicate amount fill-character))))

  (define width (- end-x start-x))

  (unless (> end-x start-x)
    (raisu 'second-argument-is-end-coordinate,not-the-width start-x end-x))

  (fill-space (- start-x initial-x))

  (cond
   ((string? parts-or-string)
    (let loop ((buf (string->list parts-or-string)))
      (define-values (current next) (list-span-n width buf))
      (display (list->string current))
      (unless (null? next)
        (newline)
        (fill-space start-x)
        (loop next))))

   ((pair? parts-or-string)
    (let loop ((current-x initial-x) (parts parts-or-string))
      (unless (null? parts)
        (let* ((word (car parts)))
          (if (equal? word fill-character)
              (if (= current-x initial-x)
                  (loop current-x (cdr parts))
                  (begin
                    (display word)
                    (loop (+ current-x 1) (cdr parts))))
              (let* ((len (string-length word))
                     (next-x (+ current-x len)))
                (if (> next-x end-x)
                    (begin
                      (newline)
                      (fill-space start-x)
                      (display word)
                      (loop (+ start-x len) (cdr parts)))
                    (begin
                      (display word)
                      (loop (+ current-x len) (cdr parts))))))))))

   (else
    (raisu 'bad-type `(expected list or string but got ,parts-or-string)))))


