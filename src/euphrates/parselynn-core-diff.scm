;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:core:diff struct1 struct2)
  (apply
   append

   (list

    (if (equal?
         (parselynn:core:struct:results struct1)
         (parselynn:core:struct:results struct2))
        '()
        (list
         (list
          'results
          (parselynn:core:struct:results struct1)
          (parselynn:core:struct:results struct2))))

    (if (equal?
         (parselynn:core:struct:driver struct1)
         (parselynn:core:struct:driver struct2))
        '()
        (list
         (list
          'driver
          (parselynn:core:struct:driver struct1)
          (parselynn:core:struct:driver struct2))))

    (if (equal?
         (parselynn:core:struct:tokens struct1)
         (parselynn:core:struct:tokens struct2))
        '()
        (list
         (list
          'tokens
          (parselynn:core:struct:tokens struct1)
          (parselynn:core:struct:tokens struct2))))

    (if (equal?
         (parselynn:core:struct:rules struct1)
         (parselynn:core:struct:rules struct2))
        '()
        (list
         (list
          'rules
          (parselynn:core:struct:rules struct1)
          (parselynn:core:struct:rules struct2))))

    (if (equal?
         (parselynn:core:struct:actions struct1)
         (parselynn:core:struct:actions struct2))
        '()
        (list
         (list
          'actions
          (parselynn:core:struct:actions struct1)
          (parselynn:core:struct:actions struct2))))

    (if (equal?
         (parselynn:core:struct:code struct1)
         (parselynn:core:struct:code struct2))
        '()
        (list
         (list
          'code
          (parselynn:core:struct:code struct1)
          (parselynn:core:struct:code struct2))))

    (if (equal?
         (parselynn:core:struct:maybefun struct1)
         (parselynn:core:struct:maybefun struct2))
        '()
        (list
         (list
          'maybefun
          (parselynn:core:struct:maybefun struct1)
          (parselynn:core:struct:maybefun struct2))))

   )))
