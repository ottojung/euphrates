;;;; Copyright (C) 2023  Otto Jung
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

%var alist-initialize

%use (assq-set-value) "./assq-set-value.scm"
%use (memconst) "./memconst.scm"
%use (raisu) "./raisu.scm"

(define (alist-initialize:run initial-alist/0 buf/0)
  (let loop ((buf buf/0) (initial-alist initial-alist/0))
    (if (null? buf) initial-alist
        (let* ((first (car buf))
               (name (car first))
               (setter (cdr first))
               (val (setter)))
          (loop
           (cdr buf)
           (assq-set-value
            name val
            initial-alist))))))

(define-syntax alist-initialize:makelet
  (syntax-rules ()
    ((_ initial-alist setter . ())
     (memconst
      (let ((x (assq (quote setter) initial-alist)))
        (unless x
          (raisu 'argument-not-initialized))
        (cdr x))))
    ((_ initial-alist setter . its-bodies)
     (memconst (let () . its-bodies)))))

(define-syntax alist-initialize:iterate
  (syntax-rules ()
    ((_ initial-alist
        buf1
        buf2)
     (letrec buf1
       (alist-initialize:run initial-alist buf2)))

    ((_ initial-alist
        buf1
        buf2
        (setter . its-bodies)
        . rest-setters)
     (alist-initialize:iterate
      initial-alist
      ((setter (alist-initialize:makelet initial-alist setter . its-bodies)) . buf1)
      (cons (cons (quote setter) setter) buf2)
      . rest-setters))))

(define-syntax alist-initialize
  (syntax-rules ()
    ((_ initial-alist/0 . setters)
     (let ((initial-alist initial-alist/0))
       (alist-initialize:iterate
        initial-alist
        ()
        '()
        . setters)))))
