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

%run guile

%use (immutable-hashmap) "./immutable-hashmap.scm"
%use (immutable-hashmap-ref immutable-hashmap-set immutable-hashmap-foreach) "./i-immutable-hashmap.scm"
%use (hashmap-set!) "./ihashmap.scm"

%var make-regex-machine/full
%var make-regex-machine
%var make-regex-machine*

(define (match-kleene-star pattern hash buf cont)
  (let loop ((hash hash) (buf buf))
    (if (null? buf)
        (cont hash buf)
        (match1 (car pattern) hash buf
                (lambda (new-hash ret)
                  (if ret
                      (call-with-values
                          (lambda _ (cont new-hash ret))
                        (lambda (h ret2)
                          (if ret2
                              (values h ret2)
                              (loop new-hash ret))))
                      (cont hash buf)))))))

(define (match-and pattern hash buf cont)
  (let loop ((hash hash) (pattern pattern) (buf buf))
    (if (null? pattern) (cont hash buf)
        (match1 (car pattern) hash buf
                (lambda (new-hash ret)
                  (if ret
                      (loop new-hash (cdr pattern) ret)
                      (cont hash #f)))))))

(define (match-or pattern hash buf cont)
  (let loop ((hash hash) (pattern pattern))
    (if (null? pattern) (cont hash #f)
        (match1 (car pattern) hash buf
                (lambda (new-hash ret)
                  (if ret
                      (call-with-values
                          (lambda () (cont new-hash ret))
                        (lambda (h ret2)
                          (if ret2
                              (values h ret2)
                              (loop new-hash (cdr pattern)))))
                      (loop hash (cdr pattern))))))))

(define (match-any pattern hash buf cont)
  (define (get-new-hash)
    (define first (car buf))
    (let loop ((hash hash) (pattern pattern))
      (if (null? pattern) hash
          (let ((name (car pattern)))
            (loop
             (immutable-hashmap-set hash name first)
             (cdr pattern))))))

  (if (not (null? buf))
      (cont (get-new-hash) (cdr buf))
      (cont hash #f)))

(define (match-any* pattern hash buf cont)
  (define (get-new-hash)
    (define first (car buf))
    (let loop ((hash hash) (pattern pattern))
      (if (null? pattern) hash
          (let ((name (car pattern)))
            (loop
             (immutable-hashmap-set
              hash name
              (cons first (immutable-hashmap-ref hash name '())))
             (cdr pattern))))))

  (if (not (null? buf))
      (cont (get-new-hash) (cdr buf))
      (cont hash #f)))

(define (match-equal pattern hash buf cont)
  (define (get-new-hash)
    (define first (car buf))
    (let loop ((hash hash) (pattern (cdr pattern)))
      (if (null? pattern) hash
          (let ((name (car pattern)))
            (loop
             (immutable-hashmap-set hash name first)
             (cdr pattern))))))

  (if (and (not (null? buf))
           (not (null? pattern))
           (equal? (car pattern) (car buf)))
      (cont (get-new-hash) (cdr buf))
      (cont hash #f)))

(define (match-epsilon pattern hash buf cont)
  (cont hash buf))

(define (match1 pattern hash buf cont)
  (define (go func)
    (func (cdr pattern) hash buf cont))
  (case (car pattern)

    ((and) (go match-and))
    ((or) (go match-or))
    ((*) (go match-kleene-star))
    ((epsilon) (go match-epsilon))

    ((=) (go match-equal))
    ((any) (go match-any))
    ((any*) (go match-any*))

    (else (go (car pattern)))))

(define (make-regex-machine/full pattern)
  (lambda (H T cont)
    (match1 pattern H T cont)))

(define (make-regex-machine pattern)
  (define M (make-regex-machine/full pattern))
  (lambda (T)
    (M (immutable-hashmap)
       T
       (lambda (hash buf) (values hash (null? buf))))))

;; Same as `make-regex-machine',
;; but also accepts H0 as hasmap that output will be written to.
(define (make-regex-machine* pattern)
  (define go (make-regex-machine pattern))
  (lambda (H0 T)
    (call-with-values (lambda _ (go T))
      (lambda (hash ret)
        (and ret
             (not
              (not
               (immutable-hashmap-foreach
                (lambda (key value)
                  (hashmap-set! H0 key value))
                hash))))))))



