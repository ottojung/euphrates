;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; returns set of all files from the directory and their modification times

(define (directory-mtime-state dir)
  (define files (map car (directory-files-rec dir)))

  (define (safe-mtime file)
    (with-ignore-errors!
     (file-mtime file)))
  (define with-mtimes (map cons files (map safe-mtime files)))

  (list->hashset with-mtimes))
