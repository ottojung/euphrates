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

%var loop-ui

%use (alist-set! alist-set!:get-setters alist-set!:run alist-set!:stop) "./alist-set-bang.scm"
%use (assq-or) "./assq-or.scm"
%use (fn-cons) "./fn-cons.scm"
%use (list-and-map) "./list-and-map.scm"

(define-syntax loop-ui:user-set!
  (syntax-rules ()
    ((_ alist-name . u-setters)
     (let ()
       (define user-setters/0
         (alist-set!:get-setters alist-name . u-setters))
       (define user-setters
         (map
          (fn-cons
           (name fun)
           (cons name
                 (lambda _
                   (or (assq-or name alist-name #f)
                       (begin
                         (fun)
                         (alist-set!:stop))))))
          user-setters/0))

       (alist-set!:run alist-name user-setters)))))

(define (loop-ui:all-fields-initialized? alist)
  (list-and-map (fn-cons (name val) val) alist))

(define-syntax loop-ui
  (syntax-rules (:init :auto :user)
    ((_ alist-name
        :init i-setters
        :auto a-setters
        :user u-setters)

     (let ()
       (alist-set! alist-name . i-setters)

       (let loop ()
         (alist-set! alist-name . a-setters)
         (unless (loop-ui:all-fields-initialized? alist-name)
           (loop-ui:user-set! alist-name . u-setters)
           (loop)))

       alist-name))))
