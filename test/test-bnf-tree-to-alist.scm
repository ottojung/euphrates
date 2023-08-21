
(assert=
 '((s1 (a b c) (g f)))
 (ebnf-tree->alist '(s1 = a b c / g f)))

(assert=
 '((s1 (a b c) (g f))
   (s2 (g k)))
 (ebnf-tree->alist '( s1 = a b c / g f
                      s2 = g k)))

(assert=
 '(((s1 s1opt) (a b c) (g f)))
 (ebnf-tree->alist '((s1 s1opt) = a b c / g f)))

(assert=
 '(((s1 s1opt) (a b c) (g f) (u k o))
   ((s2 s2opt) (k g) (m))
   (z (p s2)))
 (ebnf-tree->alist '((s1 s1opt) = a b c / g f
                     (s2 s2opt) = k g / m
                     z = p s2
                     (s1 s1opt) = u k o)))

(assert=
 '((run (OPTS* DATE <end-statement>))
   (OPTS* (--opts <opts...>*)
          (--param1 <arg1>)
          (--flag1))
   (DATE (may <nth> MAY-OPTS?)
         (june <nth> JUNE-OPTS*))
   (MAY-OPTS? (-p <x>))
   (JUNE-OPTS* (-f3) (-f4)))

 (bnf-tree->alist
  '(run ::= OPTS* DATE <end-statement>
        OPTS*   ::= --opts <opts...>*
        /         --param1 <arg1>
        /         --flag1
        DATE    ::= may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS?    ::= -p <x>
        JUNE-OPTS*   ::= -f3 / -f4)))

(assert-throw
 'bnf-must-begin-with-production-definition
 '((EUPHRATES-CFG-CLI-MAIN (run OPTS* DATE <end-statement>))
   (OPTS* (--opts <opts...>*)
          (--param1 <arg1>)
          (--flag1))
   (DATE (may <nth> MAY-OPTS?)
         (june <nth> JUNE-OPTS*))
   (MAY-OPTS? (-p <x>))
   (JUNE-OPTS* (-f3) (-f4)))

 (bnf-tree->alist
  '(run OPTS* DATE <end-statement>
        OPTS*   ::= --opts <opts...>*
        /         --param1 <arg1>
        /         --flag1
        DATE    ::= may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS?    ::= -p <x>
        JUNE-OPTS*   ::= -f3 / -f4)))

(assert=
 '((run (OPTS* DATE <end-statement>))
   (OPTS (--opts <opts...>*)
         (--param1 <arg1>)
         (--flag1))
   (DATE (may <nth> MAY-OPTS?)
         (june <nth> JUNE-OPTS*))
   (MAY-OPTS (-p <x>))
   (JUNE-OPTS (-f3) (-f4)))

 (bnf-tree->alist
  '(run ::= OPTS* DATE <end-statement>
        OPTS   ::= --opts <opts...>*
        /      --param1 <arg1>
        /      --flag1
        DATE    ::= may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS    ::= -p <x>
        JUNE-OPTS   ::= -f3 / -f4)))

(assert-throw
 'bnf-must-be-non-empty
 (bnf-tree->alist '()))

(assert-throw
 'bnf-must-be-a-list
 (bnf-tree->alist 0))

(assert-throw
 'bnf-must-be-at-least-length-2
 (bnf-tree->alist '(atom1)))

(assert=
 '((atom1))
 (bnf-tree->alist '(atom1 ::=)))

(assert-throw
 'bnf-must-begin-with-production-definition
 (bnf-tree->alist '(atom1 atom2 ::= atom3)))

(assert=
 '((s1 (a b c) (g f) (g k)))
 (bnf-tree->alist '( s1 ::= a b c / g f
                     s1 ::= g k)))

(assert=
 '((s1 (a b c) (g f) (g k)) (s2 (o u)))
 (bnf-tree->alist '( s1 ::= a b c / g f
                     s2 ::= o u
                     s1 ::= g k)))

(assert=
 '((s1 (a b c) (g f) (g "::=" k)) (s2 (o u)))
 (bnf-tree->alist '( s1 ::= a b c / g f
                     s2 ::= o u
                     s1 ::= g "::=" k)))
