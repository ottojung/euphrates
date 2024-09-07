;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <reduce>
  (parselynn:lr-reduce-action:construct
   production
   callback
   )

  parselynn:lr-reduce-action?

  (production parselynn:lr-reduce-action:production)
  (callback parselynn:lr-reduce-action:callback)

  )


(define (parselynn:lr-reduce-action:make
         production callback)

  (unless (bnf-alist:production? production)
    (raisu* :from "parselynn:lr-reduce-action"
            :type 'expected-a-production
            :message (stringf "Expected a production, got ~s." production)
            :args (list production)))

  (parselynn:compile-callback production callback)

  (parselynn:lr-reduce-action:construct
   production callback))
