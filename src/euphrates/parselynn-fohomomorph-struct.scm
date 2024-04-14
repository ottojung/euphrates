;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; This structure represents a homomorpism from input set "X" into the set of subsets of parser tokens "2^T".
;; The `base-model` is the "base" homomorphism from "X" to "T".
;; The `additional-grammar-rules` are rules for the parser that allow single input to be accepted by multiple production rules (hence the "2^T" instead of "T" in the function singnature).
;; This should be used as a parselynn lexer, or as a layer on top of the lexer.
;; The base homomorpism is defined in terms of First Order logical formulas, hence "fo" in the name.
;;

(define-type9 parselynn:fohomomorph-struct
  (make-parselynn:fohomomorph-struct
   additional-grammar-rules
   base-model
   )

  parselynn:fohomomorph?

  (additional-grammar-rules
   parselynn:fohomomorph:additional-grammar-rules)

  (base-model
   parselynn:fohomomorph:base-model)

  )
