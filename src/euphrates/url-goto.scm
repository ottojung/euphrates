;;;; Copyright (C) 2022, 2023  Otto Jung
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
  (define-module (euphrates url-goto)
    :export (url-goto)
    :use-module ((euphrates url-get-hostname-and-port) :select (url-get-hostname-and-port))
    :use-module ((euphrates url-get-path) :select (url-get-path))
    :use-module ((euphrates url-get-protocol) :select (url-get-protocol)))))



(define (url-goto base relative)
  (cond
   ((string-prefix? "//" relative)
    (string-append (url-get-protocol base) ":" relative))
   ((string-prefix? "/" relative)
    (string-append (url-get-protocol base)
                   "://"
                   (url-get-hostname-and-port base)
                   relative))
   ((not (string-null? (url-get-protocol relative))) relative)
   (else
    (let* ((path (url-get-path base)))
      (string-append (url-get-protocol base)
                     "://"
                     (url-get-hostname-and-port base)
                     (if (string-suffix? "/" path)
                         path
                         (string-append (dirname path) "/"))
                     relative)))))
