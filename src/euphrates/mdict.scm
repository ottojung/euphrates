;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define [hash->mdict h]
  (let [[unique (make-unique)]]
    (case-lambda
     [[] h]
     [[key]
      (let [[g (hashmap-ref h key unique)]]
        (if (unique g)
            (raisu 'mdict-key-not-found key h)
            g))]
     [[key value]
      (let* [[new (make-hashmap)]]
        (hashmap-foreach
         (lambda (key value)
           (hashmap-set! new key value))
         h)
        (hashmap-set! new key value)
        (hash->mdict new))])))

(define [alist->mdict alist]
  (hash->mdict (alist->hashmap alist)))

(define-syntax mdict-c
  (syntax-rules ()
    [(mdict-c carry) (alist->mdict carry)]
    [(mdict-c carry key value . rest)
     (mdict-c (cons (cons key value) carry) . rest)]))

(define-syntax mdict
  (syntax-rules ()
    ((_ . entries)
     (mdict-c '() . entries))))

(define [mdict-has? h-func key]
  (let [[h (h-func)]]
    (hashmap-has? h key)))

(define [mdict-set! h-func key value]
  (let [[h (h-func)]]
    (hashmap-set! h key value)))

(define [mdict->alist h-func]
  (let [[h (h-func)]]
    (hashmap->alist h)))

(define [mdict-keys h-func]
  (map car (mdict->alist h-func)))
