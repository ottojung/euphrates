;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:check-structure model)
  (define (fail-tokens-check show args)
    (raisu* :from "labelinglogic:model:check-structure"
            :type 'model-type-error
            :message (stringf "Type error in ~s: ~a." (quote tokens-alist) show)
            :args args))

  (unless (list? tokens-alist)
    (fail-tokens-check "must be a list" (list tokens-alist)))

  (unless (list-and-map pair? tokens-alist)
    (fail-tokens-check "must be an alist" (list tokens-alist)))

  (define keys
    (map car tokens-alist))

  (define (id? key)
    (or symbol? unique-identifier?))

  (unless (list-and-map id? keys)
    (fail-tokens-check
     "every key must be a symbol"
     (list (filter (negate id?) keys))))

  )
