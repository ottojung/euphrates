;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Zoreslava Serialization Module
;;
;; Overview:
;; The Zoreslava module is designed to provide serialization and deserialization
;; functionalities to facilitate the storage and retrieval of complex data
;; structures. It is useful for persisting state between
;; different sessions or for data transmission.
;; Zoreslava is composable.
;;
;; Features:
;; - Create and initialize a Zoreslava structure.
;; - Serialize a Zoreslava structure to a list form.
;; - Deserialize a list form back into a Zoreslava structure.
;; - Set and retrieve values within the Zoreslava structure.
;;
;; Usage:
;; (with-zoreslava
;;   (zoreslava:set! 'key1 "value1")
;;   (zoreslava:set! 'key2 "value2"))
;;
;; Key functions and macros:
;; - with-zoreslava: Macro for creating and working with a Zoreslava structure.
;; - zoreslava:set!: Set a key-value pair in the current Zoreslava structure.
;; - zoreslava:ref: Retrieve a value by key from a Zoreslava structure.
;; - zoreslava:serialize: Convert a Zoreslava structure to a list.
;; - zoreslava:deserialize: Restore a Zoreslava structure from a list.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define zoreslava/p
  ;; Global parameter to store the current Zoreslava structure.
  ;; This is a parameter object that can be dynamically scoped.
  (make-parameter #f))


(define-type9 zoreslava:struct
  ;; Define the Zoreslava structure with fields order and table.
  ;; - order: A stack that keeps track of insertion order.
  ;; - table: A hashmap for key-value storage.

  (zoreslava:struct:make order table) zoreslava:struct?
  (order zoreslava:struct:order)
  (table zoreslava:struct:table))


(define (zoreslava:equal? left right)
  ;; Compare two Zoreslava structures for equality based on their contents.
  ;; It is order-independent.

  (hashset-equal?
   (list->hashset
    (stack->list
     (zoreslava:struct:order left)))
   (list->hashset
    (stack->list
     (zoreslava:struct:order right)))))


(define (zoreslava:initialize)
  ;; Initialize a new Zoreslava structure.
  ;; Returns a struct with an empty order (stack) and an empty table (hashmap).

  (define order (stack-make))
  (define table (make-hashmap))
  (zoreslava:struct:make order table))


(define (zoreslava:cast-key key)
  ;; Ensure the key is a symbol.
  ;; If the key is already a symbol, return it.
  ;; Otherwise, convert the string to a symbol.

  (if (symbol? key) key (string->symbol key)))


(define (zoreslava:has? struct key)
  ;; Check if a given key exists in the Zoreslava structure.
  ;; Returns a boolean indicating the presence of the key.

  (define table (zoreslava:struct:table struct))
  (define key/symbol (zoreslava:cast-key key))
  (hashmap-has? table key/symbol))


(define-syntax zoreslava:ref
  ;; Macro to retrieve a value by key from a Zoreslava structure.
  ;; Two forms:
  ;; - (zoreslava:ref struct key default): Retrieve the value or return default.
  ;; - (zoreslava:ref struct key): Retrieve the value or raise an error if key is not found.

  (syntax-rules ()
    ((_ struct key default)
     (let ()
       ;; Localize inputs
       (define struct* struct)
       (define key* key)
       (define key/symbol (zoreslava:cast-key key*))
       (define table (zoreslava:struct:table struct*))

       ;; Retrieve value from table or return default value
       (hashmap-ref table key/symbol default)))

    ((_ struct key)
     (let ()
       ;; Localize inputs
       (define struct* struct)
       (define key* key)

       ;; Attempt to retrieve value, raise error if key is not found
       (zoreslava:ref
        struct* key*
        (raisu* :from "zoreslava:ref"
                :type 'key-not-found
                :message "Key not found in the serialized structure."
                :args (list struct* key*)))))))


(define-syntax with-zoreslava
  ;; Macro to create and work within a new Zoreslava context.
  ;; Initializes a new Zoreslava structure and binds it to the global parameter zoreslava/p.
  ;; Executes the bodies of code within this context.

  (syntax-rules ()
    ((_) (with-zoreslava 0))
    ((_ . bodies)
     (let ()
       (define struct
         (or (zoreslava/p)
             (zoreslava:initialize)))
       (parameterize ((zoreslava/p struct))
         (let () . bodies))
       struct))))


(define (zoreslava:set! key value)
  ;; Set a key-value pair in the current Zoreslava structure.
  ;; Ensures valid inputs and no overwriting of existing keys.

  (define struct (zoreslava/p))
  (zoreslava:set!:check struct key value)
  (zoreslava:set!/unsafe struct key value))


(define (zoreslava:set!:check struct key value)
  ;; Check the validity and existence of the key in the given Zoreslava structure.

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
            :args (list struct key value))))


(define (zoreslava:set!/unsafe struct key value)
  ;; Perform the unsafe (no checks) operation to set the key-value pair.
  ;; - Updates the hashmap with the key-value pair.
  ;; - Pushes the (key, value) pair onto the order stack.

  (define order (zoreslava:struct:order struct))
  (define table (zoreslava:struct:table struct))
  (define key/symbol (zoreslava:cast-key key))
  (hashmap-set! table key/symbol value)
  (stack-push! order (cons key/symbol value))
  (values))


(define (zoreslava:serialize struct)
  ;; Serialize the Zoreslava structure into a list of key-value pairs.
  ;; Each key-value pair is represented as a list: (key value).

  (define order (zoreslava:struct:order struct))
  (define lst (reverse (stack->list order)))
  (define elements
    (map
     (lambda (element)
       (define-pair (key value) element)
       (define key/symbol (zoreslava:cast-key key))
       (define value/escaped
         (cond
          ((number? value) value)
          ((string? value) value)
          (else (list 'unquote value))))
       (list key/symbol value/escaped))
     lst))

  (list 'quasiquote elements))


(define (zoreslava:check-element struct element)
  ;; Validate an element during deserialization.
  ;; Ensures the element is a list of length 2 and has a valid key type (symbol or string).

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
            :args (list element))))


(define (zoreslava:decode-element struct element)
  ;; Decode an individual element (key-value pair) and insert it into the Zoreslava structure.
  ;; Performs unsafe insertion since the element has already been validated.
  (define-tuple (key value) element)
  (define key/symbol (zoreslava:cast-key key))
  (zoreslava:set!/unsafe struct key/symbol value))


(define (zoreslava:deserialize/lists lists)
  ;; Deserialize a list of key-value pairs into a new Zoreslava structure.
  ;; Validates the format of the input list and its elements.

  (define struct (zoreslava:initialize))

  (unless (list? lists)
    (raisu* :from "zoreslava:deserialize"
            :type 'serialized-object-is-not-list
            :message "Trying to deserialize something that is not zoreslava."
            :args (list lists)))

  (for-each
   (lambda (element)
     (zoreslava:check-element struct element)
     (zoreslava:decode-element struct element))
   lists)

  struct)


(define (zoreslava:deserialize code)
  ;; Deserialize a list of key-value pairs into a new Zoreslava structure.
  ;; Validates the format of the input list and its elements.

  (define (zoreslava:unwrap value)
    ;; Unwrap a value if it is wrapped with 'unquote.

    (define value* (car value))

    (define ret
      (if (and (pair? value*)
               (equal? (car value*) 'unquote))
          (list (cadr value*))
          value))

    ret)

  ;; Ensure the input is a valid list format
  (unless (and (list? code)
               (eq? (car code) 'quasiquote))
    (raisu* :from "zoreslava:deserialize"
            :type 'serialized-object-bad-format
            :message "Trying to deserialize something that is not valid zoreslava format."
            :args (list code)))

  (let ()
    ;; Extract the actual list of key-value pairs
    (define lists* (cadr code))
    (define lists
      (map (fn-cons identity zoreslava:unwrap) lists*))

    (zoreslava:deserialize/lists lists)))


(define zoreslava:write
  ;; Serialize and write the Zoreslava structure to a port (default: current output port).
  (case-lambda
   ((struct) (zoreslava:write struct (current-output-port)))
   ((struct port)
    (write (zoreslava:serialize struct) port))))


(define zoreslava:read
  ;; Read and deserialize a Zoreslava structure from a port (default: current input port).

  (case-lambda
   (() (zoreslava:read (current-input-port)))
   ((port)
    (define lists (read port))
    (zoreslava:deserialize lists))))
