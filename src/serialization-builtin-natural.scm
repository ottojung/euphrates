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

%var serialize-builtin/natural
%var deserialize-builtin/natural

%use (atomic-box-ref atomic-box?) "./atomic-box.scm"
%use (box-ref box?) "./box.scm"
%use (raisu) "./raisu.scm"

%for (COMPILER "guile")
(use-modules (ice-9 hash-table))

(define (serialize/human-hashtable? o) (hash-table? o))
(define (serialize/human-hashtable o) (hash-map->list cons o))
%end

(define (serialize-builtin/natural o loop)
  (cond
   ((number? o) o)
   ((string? o) o)
   ((symbol? o) `(quote ,o))
   ((char? o) o)
   ((equal? #t o) o)
   ((equal? #f o) o)
   ((list? o) `(list ,@(map loop o)))
   ((pair? o) `(cons ,(loop (car o)) ,(loop (cdr o))))
   ((vector? o) `(vector ,@(map loop o)))
   ((parameter? o) `(make-parameter ,@(loop (o))))
   ((serialize/human-hashtable? o) `(alist->hash-table ,(loop (serialize/human-hashtable o))))
   ((box? o) `(box ,(loop (box-ref o))))
   ((atomic-box? o) `(box ,(loop (atomic-box-ref o))))
   ((procedure? o) o)
   (else (raisu 'unknown-builtin-type o))))
