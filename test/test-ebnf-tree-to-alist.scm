
;;;;;;;;;;;;;;;;;;
;; STANDARD BNF ;;
;;;;;;;;;;;;;;;;;;

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

 (ebnf-tree->alist
  '(run = OPTS* DATE <end-statement>
        OPTS*   = --opts <opts...>*
        /         --param1 <arg1>
        /         --flag1
        DATE    = may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS?    = -p <x>
        JUNE-OPTS*   = -f3 / -f4)))

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

 (ebnf-tree->alist
  '(run OPTS* DATE <end-statement>
        OPTS*   = --opts <opts...>*
        /         --param1 <arg1>
        /         --flag1
        DATE    = may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS?    = -p <x>
        JUNE-OPTS*   = -f3 / -f4)))

(assert=
 '((run (OPTS* DATE <end-statement>))
   (OPTS (--opts <opts...>*)
         (--param1 <arg1>)
         (--flag1))
   (DATE (may <nth> MAY-OPTS?)
         (june <nth> JUNE-OPTS*))
   (MAY-OPTS (-p <x>))
   (JUNE-OPTS (-f3) (-f4)))

 (ebnf-tree->alist
  '(run = OPTS* DATE <end-statement>
        OPTS   = --opts <opts...>*
        /      --param1 <arg1>
        /      --flag1
        DATE    = may  <nth> MAY-OPTS?
        /         june <nth> JUNE-OPTS*
        MAY-OPTS    = -p <x>
        JUNE-OPTS   = -f3 / -f4)))

(assert-throw
 'bnf-must-be-non-empty
 (ebnf-tree->alist '()))

(assert-throw
 'bnf-must-be-a-list
 (ebnf-tree->alist 0))

(assert-throw
 'bnf-must-be-at-least-length-2
 (ebnf-tree->alist '(atom1)))

(assert=
 '((atom1))
 (ebnf-tree->alist '(atom1 =)))

(assert-throw
 'bnf-must-begin-with-production-definition
 (ebnf-tree->alist '(atom1 atom2 = atom3)))

(assert=
 '((s1 (a b c) (g f) (g k)))
 (ebnf-tree->alist '( s1 = a b c / g f
                      s1 = g k)))

(assert=
 '((s1 (a b c) (g f) (g k))
   (s2 (o u)))
 (ebnf-tree->alist '( s1 = a b c / g f
                      s2 = o u
                      s1 = g k)))




;;;;;;;;;;;;;;;
;; Modifiers ;;
;;;;;;;;;;;;;;;

(assert=
 '((s1 (a b* c))
   (b* (b b*) ()))
 (ebnf-tree->alist '( s1 = a (* b) c )))

(assert=
 '((s1 (a b+ c))
   (b+ (b b+) (b)))
 (ebnf-tree->alist '( s1 = a (+ b) c )))

(assert=
 '((s1 (a b? c))
   (b? (b) ()))
 (ebnf-tree->alist '( s1 = a (? b) c )))

(assert=
 '((s1 (a generated-alternative c))
   (generated-alternative (b) (d)))

 (ebnf-tree->alist '( s1 = a (/ b d) c )))




;;;;;;;;;;;;;;;;;;;;;;;
;; Modifiers corners ;;
;;;;;;;;;;;;;;;;;;;;;;;

(assert=
 '((s1 (a b* c))
   (b* (b b*) ()))
 (ebnf-tree->alist '( s1 = a (* b) c )))

(assert=
 '((s1 (a b** c))
   (b** (b* b**) ()))
 (ebnf-tree->alist '( s1 = a (* b*) c )))

(assert=
 '((s1 (a b*_1 b* c)) (b*_1 (b b*_1) ()))
 (ebnf-tree->alist '( s1 = a (* b) b* c )))

(assert=
 '((s1 (a b* c d*))
   (b* (b b*) ())
   (d* (d d*) ()))
 (ebnf-tree->alist '( s1 = a (* b) c (* d))))

(assert=
 '((s1 (a b* c d+))
   (b* (b b*) ())
   (d+ (d d+) (d)))
 (ebnf-tree->alist '( s1 = a (* b) c (+ d))))




;;;;;;;;;;;;;;;;
;; Strictness ;;
;;;;;;;;;;;;;;;;

(assert-throw
 'bad-ebnf-modifier
 (ebnf-tree->alist '( s1 = a (unknown-modifier b) c )))

(assert=
 '((s1 (a (custom unknown-modifier b) c)))
 (ebnf-tree->alist '( s1 = a (custom unknown-modifier b) c )))

(assert=
 '((s1 (a () c)))
 (ebnf-tree->alist '( s1 = a () c )))

(assert-throw
 'bad-ebnf-modifier
 (ebnf-tree->alist '( s1 = a (unknown-modifier) c )))

(assert-throw
 'bad-ebnf-modifier
 (ebnf-tree->alist '( s1 = a (unknown-modifier many different arguments) c )))
