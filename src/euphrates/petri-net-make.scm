;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(cond-expand
 (guile
  (define-module (euphrates petri-net-make)
    :export (petri-net-make)
    :use-module ((euphrates petri-net-obj) :select (petri-net-obj))
    :use-module ((euphrates stack) :select (stack-make))
    :use-module ((euphrates dynamic-thread-critical-make) :select (dynamic-thread-critical-make)))))



(define (petri-net-make transitions-hashmap)
  (petri-net-obj
   transitions-hashmap
   (stack-make) ;; queue is a stack because this way is faster (due to the reversing that is done during todos construction)
   (dynamic-thread-critical-make)
   #f ;; not finished initially
   ))
