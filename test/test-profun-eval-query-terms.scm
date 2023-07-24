
(define u/small
  '(((parent "Homer" "Lisa"))
    ((parent "Homer" "Bart"))
    ((parent "Homer" "Maggie"))
    ((relative x y) (parent x y))
    ((relative x y) (parent x z) (relative z y))
    ))

(define u/full
  '(((parent "Homer" "Lisa"))
    ((parent "Homer" "Bart"))
    ((parent "Homer" "Maggie"))
    ((parent "Marge" "Lisa"))
    ((parent "Marge" "Bart"))
    ((parent "Marge" "Maggie"))
    ((parent "Abraham" "Homer"))
    ((parent "Mona" "Homer"))
    ((parent "Mr. Olsen" "Mona"))
    ((parent "Mrs. Olsen" "Mona"))
    ((parent "Bart" "Skippy"))
    ((relative x y) (parent x y))
    ((relative x y) (parent x z) (relative z y))
    ))

(define (test definitions query expected)
  (define handler profun-standard-handler)
  (define db (profun-create-database handler definitions))
  (assert= (profun-eval-query/terms db query) expected))

(test u/small '((parent X Y))
      '((parent "Homer" "Lisa") (parent "Homer" "Bart") (parent "Homer" "Maggie")))

(test u/full '((parent X "Lisa"))
      '((parent "Homer" "Lisa") (parent "Marge" "Lisa")))

(test u/full '((relative X "Homer"))
      '((relative "Abraham" "Homer") (relative "Mona" "Homer") (relative "Mr. Olsen" "Homer") (relative "Mrs. Olsen" "Homer")))

(test u/full '((relative X "XXX")) '())

(test u/full '((relative X X)) '())
