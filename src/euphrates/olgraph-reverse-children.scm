;;;; Copyright (C) 2024, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (olnode-reverse-children olnode)
  (define copy (olnode-copy/deep olnode))
  (olnode-reverse-children-inplace! copy)
  copy)


(define (olgraph-reverse-children olgraph)
  (define copy (olgraph-copy/deep olgraph))
  (olgraph-reverse-children-inplace! copy)
  copy)
