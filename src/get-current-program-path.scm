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

%run guile

%var get-current-program-path

%use (current-program-path/p) "./current-program-path-p.scm"

%for (COMPILER "guile")
(define (get-default-current-program-path)
  (let ((cmd (command-line)))
    (if (null? cmd) #f
        (car (command-line)))))
%end
%for (COMPILER "racket")
(define (get-default-current-program-path)
  (find-system-path 'run-file))
%end

(define (get-current-program-path)
  (or (current-program-path/p)
      (get-default-current-program-path)))


