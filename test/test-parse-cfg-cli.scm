
(assert=
 '((EUPHRATES-CFG-CLI-MAIN (run OPTS* DATE <end-statement>))
   (OPTS* (--opts <opts...>*)
          (--param1 <arg1>)
          (--flag1))
   (DATE (may <nth> MAY-OPTS?)
         (june <nth> JUNE-OPTS*))
   (MAY-OPTS? (-p <x>))
   (JUNE-OPTS* (-f3) (-f4)))

 (CFG-CLI->CFG-AST
  '(run OPTS* DATE <end-statement>
        OPTS*   : --opts <opts...>*
        /         --param1 <arg1>
        /         --flag1
        DATE    : may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS?    : -p <x>
        JUNE-OPTS*   : -f3 / -f4)))

(assert=
 '((EUPHRATES-CFG-CLI-MAIN (run OPTS* DATE <end-statement>))
   (OPTS (--opts <opts...>*)
         (--param1 <arg1>)
         (--flag1))
   (DATE (may <nth> MAY-OPTS?)
         (june <nth> JUNE-OPTS*))
   (MAY-OPTS (-p <x>))
   (JUNE-OPTS (-f3) (-f4)))

 (CFG-CLI->CFG-AST
  '(run OPTS* DATE <end-statement>
        OPTS   : --opts <opts...>*
        /      --param1 <arg1>
        /      --flag1
        DATE    : may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS    : -p <x>
        JUNE-OPTS   : -f3 / -f4)))

(assert-throw
 'cfg-cli-must-be-non-empty
 (CFG-CLI->CFG-AST '()))

(assert=
 '((EUPHRATES-CFG-CLI-MAIN (atom1)))

 (CFG-CLI->CFG-AST
  '(atom1)))

(assert-throw
 'cfg-cli-must-be-a-list
 (CFG-CLI->CFG-AST 0))
