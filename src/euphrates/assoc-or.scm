;;;; Copyright (C) 2021, 2022, 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define-syntax assoc-or
  (syntax-rules ()
    ((_ key alist default)
     (let ((got (assoc key alist)))
       (if got (cdr got)
           default)))
    ((_ key alist)
     (let ((got (assoc key alist)))
       (if got
           (cdr got)
           (raisu* :from "assoc-or"
                   :type 'key-not-found
                   :message "Key not found in associative list."
                   :args (list key alist)))))))
