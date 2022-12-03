;;;; Copyright (C) 2022  Otto Jung
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

;; NOTE: does not handle `procedure's!

%var serialize-builtin/short
%var deserialize-builtin/short

%use (atomic-box-ref atomic-box? make-atomic-box) "./atomic-box.scm"
%use (box-ref box? make-box) "./box.scm"
%use (raisu) "./raisu.scm"

%for (COMPILER "guile")
(use-modules (ice-9 hash-table))

(define (serialize/short-hashtable? o) (hash-table? o))
(define (serialize/short-hashtable o) (hash-map->list cons o))
(define (deserialize/short-hashtable o) (alist->hash-table o))
%end

(define-syntax serialize-builtin/short
  (syntax-rules ()
    ((_ o0 loop0)
     (let ((o o0) (loop loop0))
       (serialize-builtin/short o loop (raisu 'unknown-builtin-type 'serialize o))))
    ((_ o0 loop0 fail)
     (let ((o o0) (loop loop0))
       (cond
        ((list? o) ,@(map loop o))
        ((pair? o) (cons ,(loop (car o)) ,(loop (cdr o))))
        ((vector? o) (vector ,@(map loop o)))
        ((parameter? o) (make-parameter ,@(loop (o))))
        ((box? o) (make-box (loop (box-ref o))))
        ((atomic-box? o) (make-atomic-box (loop (atomic-box-ref o))))
        ((serialize/short-hashtable? o)
         `(@hash-table ,(loop (serialize/short-hashtable o))))
        ((symbol? o) `(@quote o))
        ((builtin-type? o) o)
        (else fail))))))

(define-syntax deserialize-builtin/short
  (syntax-rules ()
    ((_ o0 loop0)
     (let ((o o0) (loop loop0))
       (deserialize-builtin/short o loop (raisu 'unknown-tag o))))
    ((_ o0 loop0 fail)
     (let ((o o0) (loop loop0))
       (cond
        ((list? o)
         (if (not (null? o))
             (case (car o)
               ((@hash-table)
                (deserialize/short-hashtable (loop (cadr o))))
               ((@quote) (cadr o))
               (else fail))
             ,@(map loop o)))
        ((pair? o) (cons ,(loop (car o)) ,(loop (cdr o))))
        ((vector? o) (vector ,@(map loop o)))
        ((parameter? o) (make-parameter ,@(loop (o))))
        ((box? o) (make-box (loop (box-ref o))))
        ((atomic-box? o) (make-atomic-box (loop (atomic-box-ref o))))
        ((builtin-type? o) o)
        (else fail))))))
