;;;; Copyright (C) 2022  Otto Jung
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
;; This prints words to a limited `start-x'-`end-x' frame.
;; Useful for displaying text to the console.
;;
;; May be used in conjunction with `words` function,
;; like this `(print-in-frame (list-intersperse #\space (words "...some long text...")))`
;;
;; For printing to the console, use `(getenv "COLUMNS") * 2` as `end-x` coordinate.
;;
;; Note: this does NOT insert newline at the end.
;;
;; `initial-x' is position of the cursor when printing starts, you should know it.
;; `fill-character' is what space is made of. By default should be #\space.
;;

%var print-in-frame

%use (raisu) "./raisu.scm"
%use (replicate) "./replicate.scm"
%use (list-span-n) "./list-span-n.scm"

(define (print-in-frame top? bottom? start-x end-x initial-x fill-character parts-or-string)
  (define (fill-space-x amount char)
    (display (list->string (replicate amount char))))
  (define (fill-space amount)
    (fill-space-x amount fill-character))

  (define horizontal-char
    (car (string->list "─")))

  (define width (- end-x start-x 2))

  (define begin-at
    (+ 1 start-x))

  (define end-x1
    (- end-x 1))

  (unless (> end-x (+ start-x 2))
    (raisu 'second-argument-is-end-coordinate,not-the-width start-x end-x))

  (fill-space (- start-x initial-x))

  (when top?
    (display "┌")
    (fill-space-x width horizontal-char)
    (display "┐")
    (newline)
    (fill-space start-x))

  (cond
   ((string? parts-or-string)
    (let loop ((buf (string->list parts-or-string)))
      (define-values (current next) (list-span-n width buf))
      (display "│")
      (display (list->string current))
      (unless (null? next)
        (display "│")
        (newline)
        (fill-space start-x)
        (loop next))
      (when (null? next)
        (fill-space (- width (length current)))
        (display "│"))))

   ((pair? parts-or-string)
    (display "│")
    (let loop ((current-x begin-at) (parts parts-or-string))
      (if (null? parts)
          (begin
            (fill-space (- end-x1 current-x))
            (display "│"))
          (let* ((word (car parts)))
            (if (equal? word fill-character)
                (if (= current-x initial-x)
                    (loop current-x (cdr parts))
                    (begin
                      (unless (= current-x end-x1)
                        (display word))
                      (loop (+ current-x 1) (cdr parts))))
                (let* ((len (string-length word))
                       (next-x (+ current-x len)))
                  (if (> next-x end-x1)
                      (begin
                        (fill-space (- end-x1 current-x))
                        (display "│")
                        (newline)
                        (fill-space start-x)
                        (display "│")
                        (display word)
                        (loop (+ start-x len 1) (cdr parts)))
                      (begin
                        (display word)
                        (loop (+ current-x len) (cdr parts))))))))))

   (else
    (raisu 'bad-type `(expected list or string but got ,parts-or-string))))

  (when bottom?
    (newline)
    (fill-space start-x)
    (display "└")
    (fill-space-x width horizontal-char)
    (display "┘")))



