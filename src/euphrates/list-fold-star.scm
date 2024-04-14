;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax list-fold*
  (syntax-rules ()
    ((_ (acc-name acc-value)
        (x-name xs-name i-value)
        . bodies)
     (let loop ((acc-name acc-value)
                (i-all i-value))
       (if (null? i-all) acc-name
           (let ((x-name (car i-all))
                 (xs-name (cdr i-all)))
             (define-values (new-acc rest) (begin . bodies))
             (loop new-acc rest)))))))
