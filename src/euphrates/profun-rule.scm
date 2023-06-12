;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
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




(define-type9 <profun-rule>
  (profun-rule-constructor name index args body) profun-rule?
  (name profun-rule-name) ;; : symbol
  (index profun-rule-index) ;; : number (together with "name" gives a unique index)
  (args profun-rule-args) ;; : list of symbols
  (body profun-rule-body) ;; : list of lists of symbols
  )
