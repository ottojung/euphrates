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




;; Parse a URL into 5 components:
;;    <scheme>://<netloc>/<path>?<query>#<fragment>
;;
;; Returns those 5 values.
;;
;; Inspired from:
;; https://github.com/python/cpython/blob/259dd71c32a42708a2800c72898e2664a33fda9c/Lib/urllib/parse.py#L365
;; this function is the `urlsplit` from the above source code
;; except that we don't care about the encoding
;;
;; The <scheme> is also called "protocol".
;; The <netloc> is hostname+port.

(define (url-decompose str)
  (define-values (protocol0 protocol-sep rest0)
    (string-split-3 "://" str))
  (define protocol
    (if (string-null? protocol-sep) ""
        protocol0))
  (define rest1
    (if (string-null? protocol-sep)
        str
        rest0))

  (define-values (netloc netloc-sep rest2)
    (if (string-null? protocol-sep)
        (values "" "" rest1)
        (string-split-3 "/" rest1)))

  (define first-after-netloc
    (list-find-first
     (lambda (c) (case c ((#\? #\#) #t) (else #f))) #f
     (string->list rest2)))

  (define-values (path path-sep rest3)
    (if first-after-netloc
        (string-split-3 first-after-netloc rest2)
        (values rest2 "" "")))

  (define-values (query query-sep rest4)
    (if (equal? #\? first-after-netloc)
        (string-split-3 #\# rest3)
        (values #f "" rest3)))

  (define fragment
    (if (or (equal? "#" query-sep)
            (equal? "#" path-sep))
        rest4
        #f))

  (values protocol netloc (string-append netloc-sep path) query fragment))
