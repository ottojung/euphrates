;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Labelled Edges Node Implementation
;;
;;
;; A LENode (Labelled Edge Node) is an OLNode with an additional 'edges-map' in the meta,
;; keeping track of outgoing edges labeled with respective labels.
;;
;; A LENode is OLNode, so all OLNode functions work on it.
;;

;;
;; This `edges-map` is stored in the `meta` field of each `olnode` object.
;;
(define edges-map-key
  (make-unique))

;; Check if an OLNode is a LENode by verifying the existence of the edges-map in its meta.
(define (lenode? object)
  (and (olnode? object)
       (olnode:meta:get-value object edges-map-key #f)))

;; Create a new LENode with a value, initializing the edges-map in the meta.
(define (lenode:make value)
  (define ret (make-olnode value))
  (olnode:meta:set-value! ret edges-map-key (make-hashmap))
  ret)

;; Add a labeled child to a LENode.
(define (lenode:add-child! node label child)
  (define hash (olnode:meta:get-value node edges-map-key))
  (hashmap-set! hash label child))

;; Retrieve a child of a LENode by its label.
(define-syntax lenode:get-child
  (syntax-rules ()
    ((_ node label)
     (let ()
       (define hash (olnode:meta:get-value node edges-map-key))
       (hashmap-ref hash label)))

    ((_ node label default)
     (let ()
       (define hash (olnode:meta:get-value node edges-map-key))
       (hashmap-ref hash label default)))))

;; Retrieve all labels of a LENode as a list.
(define (lenode:labels node)
  (define hash (olnode:meta:get-value node edges-map-key))
  (euphrates:list-sort
   (map car (hashmap->alist hash))
   (lambda (a b)
     (string<? (~s a) (~s b)))))
