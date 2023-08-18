
(define (collect lexer s)
  (with-string-as-input
   s (let loop ()
       (define t (lexer))
       (if (equal? '*eoi* t) '()
           (let ((loc (lexical-token-source t)))
             (cons (vector (lexical-token-category t)
                           (lexical-token-value t)
                           (source-location-line loc)
                           (source-location-column loc)
                           (source-location-offset loc)
                           (source-location-length loc))
                   (loop)))))))

(let ()
  (define tokens-alist
    `((t_0 . "0")
      (t_1 . "1")
      (t_2 . "2")
      (t_3 . "3")
      (t_4 . "4")
      (t_5 . "5")
      (t_6 . "6")
      (t_7 . "7")
      (t_8 . "8")
      (t_9 . "9")))

  (define lexer ((make-lalr-lexer/irregex-factory tokens-alist)))

  (assert=

   '(#(t_1 "1" 0 1 1 1)
     #(t_9 "9" 0 2 2 1)
     #(t_3 "3" 0 3 3 1)
     #(t_7 "7" 0 4 4 1)
     #(t_1 "1" 0 5 5 1)
     #(t_6 "6" 0 6 6 1)
     #(t_3 "3" 0 7 7 1)
     #(t_4 "4" 0 8 8 1))

   (collect lexer "19371634")))





(let ()
  (define tokens-alist
    `((t_0 . "0")
      (t_1 . "1")
      (t_2 . "2")
      (t_3 . "3")
      (t_4 . "4")
      (t_5 . "5")
      (t_6 . "6")
      (t_7 . "7")
      (t_8 . "8")
      (t_9 . "9")
      (t_hello . "foo")
      (t_hello . "barbaz")))

  (define lexer ((make-lalr-lexer/irregex-factory tokens-alist)))

  (assert=

   '(#(t_1 "1" 0 1 1 1)
     #(t_9 "9" 0 2 2 1)
     #(t_3 "3" 0 3 3 1)
     #(t_7 "7" 0 4 4 1)
     #(t_hello "foo" 0 7 7 3)
     #(t_1 "1" 0 8 8 1)
     #(t_6 "6" 0 9 9 1)
     #(t_hello "barbaz" 0 15 15 6)
     #(t_3 "3" 0 16 16 1)
     #(t_4 "4" 0 17 17 1))

   (collect lexer "1937foo16barbaz34")))






(let ()
  (define tokens-alist
    `((t_0 . "0")
      (t_1 . "1")
      (t_2 . "2")
      (t_3 . "3")
      (t_4 . "4")
      (t_5 . "5")
      (t_6 . "6")
      (t_7 . "7")
      (t_8 . "8")
      (t_9 . "9")
      (t_hello . "foobar")
      (t_hello . "foo")
      (t_hello . "barbaz")))

  (define lexer ((make-lalr-lexer/irregex-factory tokens-alist)))

  (assert=

   '(#(t_1 "1" 0 1 1 1)
     #(t_9 "9" 0 2 2 1)
     #(t_3 "3" 0 3 3 1)
     #(t_7 "7" 0 4 4 1)
     #(t_hello "foobar" 0 10 10 6)
     #(t_1 "1" 0 11 11 1)
     #(t_6 "6" 0 12 12 1)
     #(t_hello "barbaz" 0 18 18 6)
     #(t_3 "3" 0 19 19 1)
     #(t_4 "4" 0 20 20 1))

   (collect lexer "1937foobar16barbaz34")))






(let ()
  (define tokens-alist
    `((t_0 . "0")
      (t_1 . "1")
      (t_2 . "2")
      (t_3 . "3")
      (t_4 . "4")
      (t_5 . "5")
      (t_6 . "6")
      (t_7 . "7")
      (t_8 . "8")
      (t_9 . "9")
      (t_hello . "foobar")
      (t_hello . "foo")
      (t_hello . "barbaz")))

  (define lexer ((make-lalr-lexer/irregex-factory tokens-alist)))

  (assert=

   '(#(t_1 "1" 0 1 1 1)
     #(t_9 "9" 0 2 2 1)
     #(t_3 "3" 0 3 3 1)
     #(t_7 "7" 0 4 4 1)
     #(t_hello "foo" 0 7 7 3)
     #(t_hello "foobar" 0 13 13 6)
     #(t_1 "1" 0 14 14 1)
     #(t_6 "6" 0 15 15 1)
     #(t_hello "barbaz" 0 21 21 6)
     #(t_3 "3" 0 22 22 1)
     #(t_4 "4" 0 23 23 1))

   (collect lexer "1937foofoobar16barbaz34")))

(let ()
  (define tokens-alist
    `((t_0 . "0")
      (t_1 . "1")
      (t_2 . "2")
      (t_3 . "3")
      (t_4 . "4")
      (t_5 . "5")
      (t_6 . "6")
      (t_7 . "7")
      (t_8 . "8")
      (t_9 . "9")
      (t_space . " ")
      (t_hello . "foobar")
      (t_hello . "foo")
      (t_hello . "barbaz")))

  (define lexer ((make-lalr-lexer/irregex-factory tokens-alist)))

  (assert=

   '(#(t_space " " 0 1 1 1)
     #(t_space " " 0 2 2 1)
     #(t_space " " 0 3 3 1)
     #(t_1 "1" 0 4 4 1)
     #(t_9 "9" 0 5 5 1)
     #(t_3 "3" 0 6 6 1)
     #(t_7 "7" 0 7 7 1)
     #(t_space " " 0 8 8 1)
     #(t_hello "foo" 0 11 11 3)
     #(t_hello "foobar" 0 17 17 6)
     #(t_space " " 0 18 18 1)
     #(t_space " " 0 19 19 1)
     #(t_space " " 0 20 20 1)
     #(t_1 "1" 0 21 21 1)
     #(t_6 "6" 0 22 22 1)
     #(t_hello "barbaz" 0 28 28 6)
     #(t_3 "3" 0 29 29 1)
     #(t_4 "4" 0 30 30 1)
     #(t_space " " 0 31 31 1))

   (collect lexer "   1937 foofoobar   16barbaz34 ")))
