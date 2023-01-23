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

%use (alist-initialize! alist-initialize!:get-setters alist-initialize!:makelet/static alist-initialize!:run alist-initialize!:stop) "./alist-initialize-bang.scm"
%use (assq-or) "./assq-or.scm"
%use (fn-pair) "./fn-pair.scm"
%use (hashset-has? list->hashset) "./hashset.scm"
%use (list-and-map) "./list-and-map.scm"

(define-syntax alist-initialize-loop:defaulted-set!
  (syntax-rules ()
    ((_ alist-name setters/0 modifier/0)
     (let ()
       (define modifier modifier/0)
       (define setters/1
         (alist-initialize!:get-setters alist-name . setters/0))
       (define setters
         (map
          (fn-pair
           (name fun/0)
           (define (fun . args)
             (if (and (not (null? args))
                      (equal? 'recalculate (car args)))
                 (apply fun/0 args)
                 (or (assq-or name alist-name #f)
                     (modifier name fun/0 args))))

           (cons name fun))
          setters/1))

       (alist-initialize!:run alist-name setters)))))

(define-syntax alist-initialize-loop:initial-set!
  (syntax-rules ()
    ((_ alist-name . u-setters)
     (alist-initialize-loop:defaulted-set!
      alist-name u-setters
      (lambda (name fun args)
        (apply fun args))))))

(define-syntax alist-initialize-loop:user-set!
  (syntax-rules ()
    ((_ alist-name . u-setters)
     (alist-initialize-loop:defaulted-set!
      alist-name u-setters
      (lambda (name fun args)
        (alist-initialize!:stop
         (apply fun args)))))))

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
           (alist-initialize-loop:initial-set! alist-name . i-setters)
           (alist-initialize! alist-name . a-setters)
           (unless (alist-initialize-loop:all-fields-initialized? default-names alist-name)
             (alist-initialize-loop:user-set! alist-name . u-setters)
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
  (syntax-rules (:initial :invariant :default)
    ((_ :fields (first-field-name . rest-of-the-fields-names)
        :initial i-setters
        :invariant a-setters
        :default u-setters)
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
      :default ()))

    ((_ :fields names
        :initial i-setters
        :default u-setters)
     (alist-initialize-loop
      :fields names
      :initial i-setters
      :invariant ()
      :default u-setters))

    ((_ :fields names
        :initial i-setters)
     (alist-initialize-loop
      :fields names
      :initial i-setters
      :invariant ()
      :default ()))

    ((_ :fields names
        :invariant a-setters
        :default u-setters)
     (alist-initialize-loop
      :fields names
      :initial ()
      :invariant a-setters
      :default u-setters))

    ((_ :fields names
        :invariant a-setters)
     (alist-initialize-loop
      :fields names
      :initial ()
      :invariant a-setters
      :default ()))

    ((_ :fields names
        :default u-setters)
     (alist-initialize-loop
      :fields names
      :initial ()
      :invariant ()
      :default u-setters))

    ))
