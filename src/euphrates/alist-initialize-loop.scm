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




(define (alist-initialize-loop:all-fields-initialized? names-restriction alist)
  (list-and-map
   (fn-pair
    (name val)
    (or val (not (hashset-has? names-restriction name))))
   alist))

(define (alist-initialize-loop:user-mapper useradvice)
  (lambda (name alist recalculate? thunk)
    (or (and (not recalculate?) (assq-or name alist #f))
        (if useradvice
            (useradvice name alist recalculate? thunk)
            (thunk)))))

(define-syntax alist-initialize-loop:finish
  (syntax-rules ()
    ((_ alist-name useradvice all bindings i-setters a-setters u-setters)
     (let ((alist-name (map (lambda (name) (cons name #f)) (list-deduplicate (quote all)))))
       (let* bindings
         (define default-names
           (list->hashset
            (map car (alist-initialize!:get-setters alist-name . u-setters))))
         (define mapper (alist-initialize-loop:user-mapper useradvice))

         (let loop ()
           (alist-initialize! alist-name :default . i-setters)
           (alist-initialize! alist-name . a-setters)
           (unless (alist-initialize-loop:all-fields-initialized? default-names alist-name)
             (alist-initialize! alist-name :map mapper :once . u-setters)
             (loop)))

         alist-name)))))

(define-syntax alist-initialize-loop:bind-field-names
  (syntax-rules ()
    ((_ all
        ()
        buf
        alist-name
        useradvice
        i-setters a-setters u-setters)
     (alist-initialize-loop:finish alist-name useradvice all buf i-setters a-setters u-setters))

    ((_ all
        (first-field-name . rest-of-the-fields-names)
        buf
        alist-name
        useradvice
        i-setters a-setters u-setters)
     (alist-initialize-loop:bind-field-names
      all
      rest-of-the-fields-names
      ((first-field-name
        (alist-initialize!:makelet/static alist-name first-field-name))
       . buf)
      alist-name
      useradvice
      i-setters a-setters u-setters))))

(define-syntax alist-initialize-loop/cont2
  (syntax-rules ()
    ((_ args all-fields)
     (alist-initialize-loop:bind-field-names
      all-fields all-fields () . args))))

(define-syntax alist-initialize-loop/map1
  (syntax-rules ()
    ((_ (cont contarg) (setter . its-bodies))
     (cont contarg setter))))

(define-syntax alist-initialize-loop/cont1
  (syntax-rules ()
    ((_ args all-setters)
     (syntax-map
      (alist-initialize-loop/cont2 args)
      alist-initialize-loop/map1
      all-setters))))

(define-syntax alist-initialize-loop
  (syntax-rules (:current :initial :invariant :useradvice :user)
    ((_ :current alist-name
        :initial i-setters
        :invariant a-setters
        :useradvice useradvice
        :user u-setters)
     (syntax-append
      (alist-initialize-loop/cont1
       (alist-name
        useradvice
        i-setters a-setters u-setters))
      i-setters a-setters u-setters))

    ((_ :current alist-name
        :initial i-setters
        :invariant a-setters
        :user u-setters)
     (alist-initialize-loop
      :current alist-name
      :initial i-setters
      :invariant a-setters
      :useradvice #f
      :user u-setters))

    ((_ :current alist-name
        :initial i-setters
        :invariant a-setters)
     (alist-initialize-loop
      :current alist-name
      :initial i-setters
      :invariant a-setters
      :useradvice #f
      :user ()))

    ((_ :current alist-name
        :initial i-setters
        :user u-setters)
     (alist-initialize-loop
      :current alist-name
      :initial i-setters
      :invariant ()
      :useradvice #f
      :user u-setters))

    ((_ :current alist-name
        :initial i-setters
        :useradvice useradvice
        :user u-setters)
     (alist-initialize-loop
      :current alist-name
      :initial i-setters
      :invariant ()
      :useradvice useradvice
      :user u-setters))

    ((_ :current alist-name
        :initial i-setters)
     (alist-initialize-loop
      :current alist-name
      :initial i-setters
      :invariant ()
      :useradvice #f
      :user ()))

    ((_ :current alist-name
        :invariant a-setters
        :user u-setters)
     (alist-initialize-loop
      :current alist-name
      :initial ()
      :invariant a-setters
      :useradvice #f
      :user u-setters))

    ((_ :current alist-name
        :invariant a-setters
        :user u-setters
        :useradvice useradvice)
     (alist-initialize-loop
      :current alist-name
      :initial ()
      :invariant a-setters
      :useradvice useradvice
      :user u-setters))

    ((_ :current alist-name
        :invariant a-setters)
     (alist-initialize-loop
      :current alist-name
      :initial ()
      :invariant a-setters
      :useradvice #f
      :user ()))

    ((_ :current alist-name
        :user u-setters)
     (alist-initialize-loop
      :current alist-name
      :initial ()
      :invariant ()
      :useradvice #f
      :user u-setters))

    ((_ :current alist-name
        :user u-setters
        :useradvice useradvice)
     (alist-initialize-loop
      :current alist-name
      :initial ()
      :invariant ()
      :useradvice useradvice
      :user u-setters))

    ))
