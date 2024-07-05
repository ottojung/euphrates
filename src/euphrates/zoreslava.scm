;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This is a module that does serialization.
;;
;;;;;;;;;;;;;;;;;;;;;;;;


(define zoreslava/p
  (make-parameter #f))


(define-type9 zoreslava:struct
  (zoreslava:struct:make order table) zoreslava:struct?
  (order zoreslava:struct:order)
  (table zoreslava:struct:table)
  )



(define (zoreslava:equal? left right)
  (hashset-equal?
   (list->hashset
    (stack->list
     (zoreslava:struct:order left)))
   (list->hashset
    (stack->list
     (zoreslava:struct:order right)))))


(define (zoreslava:initialize)
  (define order (stack-make))
  (define table (make-hashmap))
  (zoreslava:struct:make order table))


(define (zoreslava:cast-key key)
  (if (symbol? key) key (string->symbol key)))


(define (zoreslava:has? struct key)
  (define table (zoreslava:struct:table struct))
  (define key/symbol (zoreslava:cast-key key))
  (hashmap-has? table key/symbol))


(define-syntax zoreslava:ref
  (syntax-rules ()
    ((_ struct key default)
     (let ()
       (define struct* struct)
       (define key* key)
       (define key/symbol (zoreslava:cast-key key*))
       (define table (zoreslava:struct:table struct*))
       (hashmap-ref table key/symbol default)))

    ((_ struct key)
     (let ()
       (define struct* struct)
       (define key* key)

       (zoreslava:ref
        struct* key*
        (raisu* :from "zoreslava:ref"
                :type 'key-not-found
                :message "Key not found in the serialized structure."
                :args (list struct* key*)))))

    ))


(define-syntax with-zoreslava
  (syntax-rules ()
    ((_ . bodies)
     (let ()
       (define struct (zoreslava:initialize))
       (parameterize ((zoreslava/p struct))
         (let () . bodies))
       struct))))


(define (zoreslava:set! key value)
  (define struct (zoreslava/p))
  (zoreslava:set!:check struct key value)
  (zoreslava:set!/unsafe struct key value))


(define (zoreslava:set!:check struct key value)
  (unless struct
    (raisu* :from "zoreslava:set!"
            :type 'parameter-not-initialized
            :message (stringf "Zoreslava has not been initialized, use ~s first."
                              "with-zoreslava")
            :args (list key value)))

  (unless (or (symbol? key) (string? key))
    (raisu* :from "zoreslava:set!"
            :type 'set-key-bad-type
            :message (stringf "Key to ~s must be either a string or a symbol."
                              "zoreslava:set!")
            :args (list key value)))

  (when (zoreslava:has? struct key)
    (raisu* :from "zoreslava:set!"
            :type 'already-defined
            :message "Trying to add a value with the save key multiple times."
            :args (list struct key value)))

  )


(define (zoreslava:set!/unsafe struct key value)
  (define order (zoreslava:struct:order struct))
  (define table (zoreslava:struct:table struct))
  (define key/symbol (zoreslava:cast-key key))
  (hashmap-set! table key/symbol value)
  (stack-push! order (cons key/symbol value))
  (values))


(define (zoreslava:serialize struct)
  (define order (zoreslava:struct:order struct))
  (define lst (stack->list order))
  (map
   (lambda (element)
     (define-pair (key value) element)
     (define key/symbol (zoreslava:cast-key key))
     (list key/symbol value))
   lst))


(define (zoreslava:check-element struct element)
  (unless (list? element)
    (raisu* :from "zoreslava:deserialize"
            :type 'serialized-object-bad-element-type
            :message "Trying to deserialize something that is not zoreslava."
            :args (list element)))

  (unless (list-length= 2 element)
    (raisu* :from "zoreslava:deserialize"
            :type 'serialized-object-bad-element-length
            :message "Trying to deserialize something that is not zoreslava."
            :args (list (length element) element)))


  (unless (or (symbol? (car element))
              (string? (car element)))

    (raisu* :from "zoreslava:deserialize"
            :type 'serialized-object-bad-key-type
            :message "Trying to deserialize something that is not zoreslava."
            :args (list element)))

  )


(define (zoreslava:decode-element struct element)
  (define-tuple (key value) element)
  (define key/symbol (zoreslava:cast-key key))
  (zoreslava:set!/unsafe struct key/symbol value))


(define (zoreslava:deserialize lists)
  (define struct (zoreslava:initialize))

  (unless (list? lists)
    (raisu* :from "zoreslava:deserialize"
            :type 'serialized-object-is-not-list
            :message "Trying to deserialize something that is not zoreslava."
            :args (list lists)))

  (for-each
   (lambda (element)
     (zoreslava:decode-element struct element))
   lists)

  struct)


(define zoreslava:write
  (case-lambda
   ((struct) (zoreslava:write struct (current-output-port)))
   ((struct port)
    (define lists (zoreslava:serialize struct))
    (for-each
     (lambda (element)
       (define-tuple (key value) element)
       (write (list key value) port)
       (newline port))
     lists))))


(define zoreslava:read
  (case-lambda
   (() (zoreslava:read (current-input-port)))
   ((port)
    (define lists (read-list port))
    (zoreslava:deserialize lists))))
