
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates call-with-input-string)
           call-with-input-string))
   (import (only (euphrates json-parse) json-parse))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           lambda
           let
           quote))))


(define (test1 json expected-alist)
  (define parsed
    (call-with-input-string
     json (lambda (p) (json-parse p))))
  (assert= expected-alist parsed))



(define (test-error json expected-error)
  (assert-throw
   expected-error
   (call-with-input-string
    json (lambda (p) (json-parse p)))))



;; json-parse

(test1 "{ \"a\": 42 }"
       '(("a" . 42)))

(test1 "{ \"a\": false, \"b\": true }"
       '(("a" . #f) ("b" . #t)))

(test1 "{ \"a\": null }"
       '(("a" . null)))

(test1 "{ \"a\": [10, 20, 30], \"b\": \"text\" }"
       '(("a" . #(10 20 30)) ("b" . "text")))

(test1 "{ \"a\": { \"b\": { \"c\": 3 } } }"
       '(("a" . (("b" . (("c" . 3)))))))

(test1 "{ \"a\": [], \"b\": {} }"
       '(("a" . #()) ("b" . ())))

(test1 "{ \"a\": [1, 2, [3, 4]], \"b\": 5 }"
       '(("a" . #(1 2 #(3 4))) ("b" . 5)))

(test1 "{}" '())

(test1 "{ \"a\": 1, \"b\": 2, \"c\": 3, \"d\": 4 }"
       '(("a" . 1) ("b" . 2) ("c" . 3) ("d" . 4)))

(test1 "{ \"a\": \"\", \"b\": \"text\" }"
       '(("a" . "") ("b" . "text")))

(test1 "{ \"a\": { \"b\": [1, 2, 3] } }"
       '(("a" . (("b" . #(1 2 3))))))

(test1 "{ \"a\": [1, { \"b\": 2 }] }"
       '(("a" . #(1 (("b" . 2))))))

(test1 "{ \"a\": [1, [2, 3]], \"b\": null }"
       '(("a" . #(1 #(2 3))) ("b" . null)))

(test1 "{ \"a\": { \"b\": { \"c\": { \"d\": 4 } } } }"
       '(("a" . (("b" . (("c" . (("d" . 4)))))))))

(test1 "{ \"a\": 1, \"b\": [2, 3, { \"c\": 4 }], \"d\": \"e\" }"
       '(("a" . 1) ("b" . #(2 3 (("c" . 4)))) ("d" . "e")))

(test1 "{ \"a\": [1, 2, 3], \"b\": [4, 5, 6] }"
       '(("a" . #(1 2 3)) ("b" . #(4 5 6))))

(test1 "{ \"a\": { \"b\": 1 }, \"c\": { \"d\": 2 } }"
       '(("a" . (("b" . 1))) ("c" . (("d" . 2)))))

(test1 "{ \"a\": [1, 2, [3, 4, [5, 6]]] }"
       '(("a" . #(1 2 #(3 4 #(5 6))))))

(test-error "{ \"hello\": "
            'json-invalid)

(test-error "{ \"a\": " 'json-invalid)

(test-error "{ \"a\": 1, " 'json-invalid)


;; Testing whitespace handling
(test1 "{ \"a\" : 1 }"
       '(("a" . 1)))
(test1 "{\t\"a\"\n:\r1 }"
       '(("a" . 1)))
(test1 "{ \"a\" \n\t\r : \t\r\n 1 }"
       '(("a" . 1)))

;; Testing number formats
(test1 "{ \"a\": 1e3 }"
       '(("a" . 1000)))
(test1 "{ \"a\": 3.14 }"
       '(("a" . 3.14)))
(test1 "{ \"a\": -42 }"
       '(("a" . -42)))
(test1 "{ \"a\": -3.14E2 }"
       '(("a" . -314)))
(test1 "{ \"a\": 0.123 }"
       '(("a" . 0.123)))
(test1 "{ \"a\": 0.123E3 }"
       '(("a" . 123)))

;; Testing empty strings and objects
(test1 "{ \"a\": \"\" }"
       '(("a" . "")))
(test1 "{ \"a\": {} }"
       '(("a" . ())))

;; Testing null, true, false
(test1 "{ \"a\": null, \"b\": true, \"c\": false }"
       '(("a" . null) ("b" . #t) ("c" . #f)))

;; Testing special characters in strings
(test1 "{ \"a\": \"\\\"\\\\\\/\\b\\f\\n\\r\\t\" }"
       '(("a" . "\"\\/\b\f\n\r\t")))

;; Testing Unicode characters
(test1 "{ \"a\": \"\\u0041\" }"
       '(("a" . "A")))

;; Testing invalid JSON
(test-error "{ \"a\": .1 }"
            'json-invalid)
(test-error "{ \"a\": +1 }"
            'json-invalid)
(test-error "{ \"a\": 01 }"
            'json-invalid)
(test-error "{ \"a\": 1, }"
            'json-invalid)
(test-error "{ \"a\": , \"b\": 2 }"
            'json-invalid)

;; Testing mixed types
(test1 "{ \"a\": [1, \"text\", { \"b\": true }, [2, 3]] }"
       '(("a" . #(1 "text" (("b" . #t)) #(2 3)))))
