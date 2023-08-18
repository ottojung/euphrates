
(define translator (semis-ebnf-tree->ebnf-tree '::= '/))

(define (test1 input expected)
  (assert= expected (translator input)))

;;;;;;;;
;;
;; Trivial cases
;;

(test1
 '( s1 ::= a b c / g f )

 '( s1 ::= a b c / g f ))

(test1
 '( s1 ::= a b* c / g f )

 '( s1 ::= a (* b) c / g f ))

(test1
 '( s1 ::= a b+ c / g f )

 '( s1 ::= a (+ b) c / g f ))

(test1
 '( s1 ::= a b? c / g f )

 '( s1 ::= a (? b) c / g f ))

(test1
 '( s1 ::= a !b c / g f )

 '( s1 ::= a (! b) c / g f ))

(test1
 '( s1 ::= a b c / g f
    s2 ::= o u
    s1 ::= g k)

 '( s1 ::= a b c / g f
    s2 ::= o u
    s1 ::= g k))

;;;;;;;;
;;
;; Corners
;;

(test1
 '( s1 ::= a b c / g f
    s2 ::= o u*
    s1 ::= g k)
 '( s1 ::= a b c / g f
    s2 ::= o (* u)
    s1 ::= g k))

(test1
 '( s1 ::= a *b c / g f )
 '( s1 ::= a *b c / g f ))

(test1
 '( s1 ::= a +b c / g f )
 '( s1 ::= a +b c / g f ))

(test1
 '( s1 ::= a ?b c / g f )
 '( s1 ::= a ?b c / g f ))

(test1
 '( s1 ::= a b! c / g f )
 '( s1 ::= a b! c / g f ))

(test1
 '( s1 ::= a ?*b c / g f )
 '( s1 ::= a ?*b c / g f ))

(assert-throw
 'terminal-with-multiple-modifiers
 (translator
  '( s1 ::= a !b* c / g f )))

(assert-throw
 'terminal-with-multiple-modifiers
 (translator
  '( s1 ::= a b?* c / g f
     s2 ::= o u
     s1 ::= g k)))

(assert-throw
 'terminal-with-multiple-modifiers
 (translator
  '( s1 ::= a b** c / g f
     s2 ::= o u
     s1 ::= g k)))
