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

%var alist-initialize-loop

%use (alist-initialize! alist-initialize!:get-setters alist-initialize!:makelet/static) "./alist-initialize-bang.scm"
%use (fn-pair) "./fn-pair.scm"
%use (hashset-has? list->hashset) "./hashset.scm"
%use (list-and-map) "./list-and-map.scm"

(define (alist-initialize-loop:all-fields-initialized? names-restriction alist)
  (list-and-map
   (fn-pair
    (name val)
    (or val (not (hashset-has? names-restriction name))))
   alist))

(define-syntax alist-initialize-loop:finish
  (syntax-rules ()
    ((_ alist-name all bindings i-setters a-setters u-setters)
     (let ((alist-name (map (lambda (name) (cons name #f)) (quote all))))
       (let bindings
           (define default-names
             (list->hashset
              (map car (alist-initialize!:get-setters alist-name . u-setters))))

         (let loop ()
           (alist-initialize! alist-name :default . i-setters)
           (alist-initialize! alist-name . a-setters)
           (unless (alist-initialize-loop:all-fields-initialized? default-names alist-name)
             (alist-initialize! alist-name :default :once . u-setters)
             (loop)))

         alist-name)))))

(define-syntax alist-initialize-loop:bind-field-names
  (syntax-rules ()
    ((_ alist-name
        all
        buf
        ()
        i-setters a-setters u-setters)
     (alist-initialize-loop:finish alist-name all buf i-setters a-setters u-setters))

    ((_ alist-name
        all
        buf
        (first-field-name . rest-of-the-fields-names)
        i-setters a-setters u-setters)
     (alist-initialize-loop:bind-field-names
      alist-name
      all
      ((first-field-name
        (alist-initialize!:makelet/static alist-name first-field-name))
       . buf)
      rest-of-the-fields-names
      i-setters a-setters u-setters))))

(define-syntax alist-initialize-loop
  (syntax-rules (:initial :invariant :user)
    ((_ :fields (first-field-name . rest-of-the-fields-names)
        :initial i-setters
        :invariant a-setters
        :user u-setters)
     (alist-initialize-loop:bind-field-names
      alist-name
      (first-field-name . rest-of-the-fields-names)
      ()
      (first-field-name . rest-of-the-fields-names)
      i-setters a-setters u-setters))

    ((_ :fields names
        :initial i-setters
        :invariant a-setters)
     (alist-initialize-loop
      :fields names
      :initial i-setters
      :invariant a-setters
      :user ()))

    ((_ :fields names
        :initial i-setters
        :user u-setters)
     (alist-initialize-loop
      :fields names
      :initial i-setters
      :invariant ()
      :user u-setters))

    ((_ :fields names
        :initial i-setters)
     (alist-initialize-loop
      :fields names
      :initial i-setters
      :invariant ()
      :user ()))

    ((_ :fields names
        :invariant a-setters
        :user u-setters)
     (alist-initialize-loop
      :fields names
      :initial ()
      :invariant a-setters
      :user u-setters))

    ((_ :fields names
        :invariant a-setters)
     (alist-initialize-loop
      :fields names
      :initial ()
      :invariant a-setters
      :user ()))

    ((_ :fields names
        :user u-setters)
     (alist-initialize-loop
      :fields names
      :initial ()
      :invariant ()
      :user u-setters))

    ))
