;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 parselynn/simple-struct
  (make-parselynn/simple-struct
   arguments
   lexer
   backend-parser
   hidden-tree-labels
   transformations)

  parselynn/simple-struct?

  (arguments parselynn/simple-struct:arguments)

  (lexer parselynn/simple-struct:lexer)

  (backend-parser parselynn/simple-struct:backend-parser)

  (hidden-tree-labels parselynn/simple-struct:hidden-tree-labels)

  (transformations parselynn/simple-struct:transformations)

  )
