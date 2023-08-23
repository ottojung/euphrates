
(define (test1 input expected)
  (assert= expected (semis-ebnf-tree->ebnf-tree input)))

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

(test1
 '( s1 ::= a b* c / g b* f )
 '( s1 ::= a (* b) c / g (* b) f ))

(assert-throw
 'terminal-with-multiple-modifiers
 (semis-ebnf-tree->ebnf-tree
  '( s1 ::= a !b* c / g f )))

(assert-throw
 'terminal-with-multiple-modifiers
 (semis-ebnf-tree->ebnf-tree
  '( s1 ::= a b?* c / g f
     s2 ::= o u
     s1 ::= g k)))

(assert-throw
 'terminal-with-multiple-modifiers
 (semis-ebnf-tree->ebnf-tree
  '( s1 ::= a b** c / g f
     s2 ::= o u
     s1 ::= g k)))

(assert-throw
 'terminal-named-as-modifier
 (semis-ebnf-tree->ebnf-tree
  '( s1 ::= a * c / g f
     s2 ::= o u
     s1 ::= g k)))
