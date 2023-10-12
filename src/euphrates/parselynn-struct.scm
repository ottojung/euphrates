;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <parselynn-struct>
  (make-parselynn-struct
   results driver tokens rules actions code maybefun)

  parselynn-struct?

  (results     parselynn-struct:results)
  (driver      parselynn-struct:driver)
  (tokens      parselynn-struct:tokens)
  (rules       parselynn-struct:rules)
  (actions     parselynn-struct:actions)
  (code        parselynn-struct:code)
  (maybefun    parselynn-struct:maybefun)
  )
