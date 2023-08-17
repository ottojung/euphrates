
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
