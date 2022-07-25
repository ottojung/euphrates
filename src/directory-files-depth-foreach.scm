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

%var directory-files-depth-foreach

;; Calls `fn' ob objects like this:
;;   (fullname name dirname1 dirname2 dirname3...)
;;   (fullname name ....)
;;
;;  where dirname1 is the parent dir of the file

%for (COMPILER "guile")

(use-modules (ice-9 ftw))

(define (directory-files-depth-foreach depth fn directory)
  ;; Don't skip anything
  (define current '())

  (define (enter? name stat result)
    (< (length current) depth))

  (define (leaf name stat result)
    (fn (cons* name (basename name) current))
    result)

  (define (down name stat result)
    (set! current (cons name current))
    result)
  (define (up name stat result)
    (set! current (cdr current))
    result)

  (define (skip name stat result) result)

  ;; ignore errors
  (define (error name stat errno result) result)

  (file-system-fold enter? leaf down up skip error
                    '()
                    directory))

%end

;; TODO: Port racket version.
;;       See `directory-files-rec.scm' for example.
