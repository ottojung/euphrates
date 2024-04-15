;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <parselynn:core:struct>
  (make-parselynn:core:struct
   results driver tokens rules actions code maybefun)

  parselynn:core:struct?

  (results     parselynn:core:struct:results)
  (driver      parselynn:core:struct:driver)
  (tokens      parselynn:core:struct:tokens)
  (rules       parselynn:core:struct:rules)
  (actions     parselynn:core:struct:actions)
  (code        parselynn:core:struct:code)
  (maybefun    parselynn:core:struct:maybefun)
  )
