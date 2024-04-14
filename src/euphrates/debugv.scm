;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (debug-vars->string vars/symbols)
  (define count (length vars/symbols))
  (define mapped (map (const "~s = ~s") (range count)))
  (apply string-append (list-intersperse ", " mapped)))

(define-syntax debug-vars-helper
  (syntax-rules ()
    ((_ vars buf ())
     (debug (debug-vars->string (reverse (quote vars))) . buf))
    ((_ vars buf (x . xs))
     (debug-vars-helper vars ((quote x) x . buf) xs))))

(define-syntax debugv
  (syntax-rules ()
    ((_ . vars)
     (debug-vars-helper vars () vars))))
