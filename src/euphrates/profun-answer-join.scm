;;;; Copyright (C) 2022, 2023  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
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




(define (profun-answer-join-positives a b)
  (let* ((a-alist (profun-accept-alist a))
         (a-ctx (profun-accept-ctx a))
         (a-ctx-changed? (profun-accept-ctx-changed? a))
         (b-alist (profun-accept-alist b))
         (b-ctx (profun-accept-ctx b))
         (b-ctx-changed? (profun-accept-ctx-changed? b))
         (new-alist (hashmap->alist (alist->hashmap (append b-alist a-alist))))
         (new-ctx (if a-ctx-changed? a-ctx b-ctx))
         (new-ctx-changed? (or a-ctx-changed? b-ctx-changed?)))
    (make-profun-accept new-alist new-ctx new-ctx-changed?)))

(define (profun-answer-join/any a b)
  (cond
   ((profun-accept? a) a)
   ((profun-reject? a)
    (unless (or (profun-accept? b)
                (profun-reject? b)
                (profun-abort? b))
      (raisu 'b-is-not-an-answer b))
    b)
   ((profun-abort? a) a)
   (else (raisu 'a-is-not-an-answer a))))

(define (profun-answer-join/or a b)
  (cond
   ((profun-accept? a)
    (cond
     ((profun-accept? b) (profun-answer-join-positives a b))
     ((profun-reject? b) a)
     ((profun-abort? b) b)
     (else (raisu 'b-is-not-an-answer b))))
   ((profun-reject? a)
    (unless (or (profun-accept? b)
                (profun-reject? b)
                (profun-abort? b))
      (raisu 'b-is-not-an-answer b))
    b)
   ((profun-abort? a) a)
   (else (raisu 'a-is-not-an-answer a))))

(define (profun-answer-join/and a b)
  (cond
   ((profun-accept? a)
    (cond
     ((profun-accept? b) (profun-answer-join-positives a b))
     ((profun-reject? b) b)
     ((profun-abort? b) b)
     (else (raisu 'b-is-not-an-answer b))))
   ((profun-reject? a)
    (unless (or (profun-accept? b)
                (profun-reject? b)
                (profun-abort? b))
      (raisu 'b-is-not-an-answer b))
    (if (profun-abort? b) b a))
   ((profun-abort? a) a)
   (else (raisu 'a-is-not-an-answer a))))
