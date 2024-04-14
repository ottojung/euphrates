;;;; Copyright (C) 2020, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (current-source-info->string info)
  (let* ((linei (assq 'line info))
         (columni (assq 'column info))
         (filenamei (assq 'filename info))
         (cwd (string-append (get-current-directory) "/"))

         (line (or (and linei (string-append (~a (cdr linei)) ":"))
                   ""))
         (column (or (and columni (string-append (~a (cdr columni)) ":"))
                     ""))
         (filename
          (or (and filenamei
                   (string-append
                    (remove-common-prefix (cdr filenamei) cwd) ":"))
              ""))

         (alli (string-append filename line column)))
    (or (and alli (string-append alli " "))
        "")))

