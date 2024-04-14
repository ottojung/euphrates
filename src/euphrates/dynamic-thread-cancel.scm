;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;; Kills the current thread when it calls yield,
;; so does not kill threads right away.


(define (dynamic-thread-cancel th)
  ((or (dynamic-thread-cancel/p)
       (raisu 'threading-system-is-not-parameterized)) th))
