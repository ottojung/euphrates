
(define (test1 expected-json alist)
  (define json
    (with-output-stringified
     (display-alist-as-json alist)))
  (define json/mini
    (with-output-stringified
     (display-alist-as-json/minimal alist)))

  (define (compare a b)
    (assert= a b))

  (assert=
   (string-filter
    (negate char-whitespace?)
    expected-json)

   (string-filter
    (negate char-whitespace?)
    json))

  (assert=
   (string-filter
    (negate char-whitespace?)
    expected-json)

   (string-filter
    (negate char-whitespace?)
    json/mini)))


;;;;;
;;
;; Exact start
;;


(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json '(("a" . 42)))))

  (assert= "{
	\"a\": 42
}" json))

(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json '(("a" . 42) ("b" . 7)))))

  (assert= "{
	\"a\": 42,
	\"b\": 7
}" json))


(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json '((a . 42) (b . 7)))))

  (assert= "{
	\"a\": 42,
	\"b\": 7
}" json))


(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json '((a . ((x . 2))) (b . 7)))))

  (assert= "{
	\"a\": {
		\"x\": 2
	},
	\"b\": 7
}" json))


(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json (vector 42 7))))

  (assert= "[42, 7]" json))


(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json (vector 42 '((a . 2) (b . 4)) 7))))

  (assert= "[42, {
	\"a\": 2,
	\"b\": 4
}, 7]" json))


(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json/minimal '(("a" . 42)))))

  (assert= "{\"a\":42}" json))

(let ()
  (define json
    (with-output-stringified
     (display-alist-as-json/minimal
      (vector 42 '((a . 2) (b . 4)) 7))))

  (assert= "[42,{\"a\":2,\"b\":4},7]" json))

;;;;;
;;
;; Comparative start
;;

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

;; Testing whitespace handling
(test1 "{ \"a\" : 1 }"
       '(("a" . 1)))
(test1 "{\t\"a\"\n:\r1 }"
       '(("a" . 1)))
(test1 "{ \"a\" \n\t\r : \t\r\n 1 }"
       '(("a" . 1)))

;; Testing number formats
(test1 "{ \"a\": 3.14 }"
       '(("a" . 3.14)))
(test1 "{ \"a\": -42 }"
       '(("a" . -42)))
(test1 "{ \"a\": 0.123 }"
       '(("a" . 0.123)))

;; Testing empty strings and objects
(test1 "{ \"a\": \"\" }"
       '(("a" . "")))
(test1 "{ \"a\": {} }"
       '(("a" . ())))

;; Testing null, true, false
(test1 "{ \"a\": null, \"b\": true, \"c\": false }"
       '(("a" . null) ("b" . #t) ("c" . #f)))

;; Testing atomic
(test1 "true" #t)
(test1 "  true   " #t)
(test1 "false" #f)
(test1 "  false  " #f)
(test1 "null" 'null)
(test1 "  null   " 'null)
(test1 "\"null\"" "null")
(test1 "  \"null\"   " "null")
(test1 "42" 42)
(test1 "   42    " 42)
(test1 "{}" '())
(test1 "   {}   " '())
(test1 "   {    }   " '())
(test1 "[]" #())
(test1 "   []   " #())
(test1 "   [    ]   " #())
