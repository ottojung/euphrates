;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:serialize parser)
  (define base

    (with-zoreslava

     (zoreslava:set!
      'l5d989nov8cra7snamcw
      `(quote
        ,(parselynn:simple:struct:arguments parser)))

     (zoreslava:set!
      'h527afc6bh66cls9w1vl
      `(quote
        ,(map
          (fn-cons identity hashset->list)
          (parselynn:simple:struct:transformations parser))))

     ))

  (define backend
    (zoreslava:deserialize
     (parselynn:core:serialize
      (parselynn:simple:struct:backend-parser parser))))

  (define ret
    (zoreslava:serialize
     (zoreslava:union base backend)))

  ret)
