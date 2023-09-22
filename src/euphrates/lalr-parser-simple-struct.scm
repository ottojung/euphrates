;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 lalr-parser/simple-struct
  (make-lalr-parser/simple-struct
   arguments
   lexer
   backend-parser
   transformations)

  lalr-parser/simple-struct?

  (arguments lalr-parser/simple-struct:arguments)

  (lexer lalr-parser/simple-struct:lexer)

  (backend-parser lalr-parser/simple-struct:backend-parser)

  (transformations lalr-parser/simple-struct:transformations)

  )
