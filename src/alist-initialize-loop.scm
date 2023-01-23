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

%use (alist-initialize! alist-initialize!:get-setters alist-initialize!:run alist-initialize!:stop) "./alist-initialize-bang.scm"
%use (assq-or) "./assq-or.scm"
%use (fn-pair) "./fn-pair.scm"
%use (list-and-map) "./list-and-map.scm"
%use (raisu) "./raisu.scm"

(define-syntax alist-initialize-loop:user-set!
  (syntax-rules ()
    ((_ alist-name . u-setters)
     (let ()
       (define user-setters/0
         (alist-initialize!:get-setters alist-name . u-setters))
       (define user-setters
         (map
          (fn-pair
           (name fun)
           (cons name
                 (lambda args
                   (or (assq-or name alist-name #f)
                       (alist-initialize!:stop
                        (apply fun args))))))
          user-setters/0))

       (alist-initialize!:run alist-name user-setters)))))

(define (alist-initialize-loop:all-fields-initialized? alist)
  (list-and-map (fn-pair (name val) val) alist))

(define-syntax alist-initialize-loop:finish
  (syntax-rules ()
    ((_ alist-name all bindings i-setters a-setters u-setters)
     (let ((alist-name (map (lambda (name) (cons name #f)) (quote all))))
       (let bindings
           (alist-initialize! alist-name . i-setters)

         (let loop ()
           (alist-initialize! alist-name . a-setters)
           (unless (alist-initialize-loop:all-fields-initialized? alist-name)
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
        (let ()
          (define self
            (case-lambda
             (() (assq-or (quote first-field-name) alist-name #f))
             ((action . args)
              (case action
                ((current) (self))
                ((or) (or (self) (car args)))
                (else (raisu 'unexpected-operation action))))))
          self))
       . buf)
      rest-of-the-fields-names
      i-setters a-setters u-setters))))

(define-syntax alist-initialize-loop
  (syntax-rules (:initial :invariant :default)
    ((_ (first-field-name . rest-of-the-fields-names)
        :initial i-setters
        :invariant a-setters
        :default u-setters)
     (alist-initialize-loop:bind-field-names
      alist-name
      (first-field-name . rest-of-the-fields-names)
      ()
      (first-field-name . rest-of-the-fields-names)
      i-setters a-setters u-setters))))
