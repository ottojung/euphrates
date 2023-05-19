
(cond-expand
 (guile
  (define-module (test-cfg-remove-dead-code)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates cfg-remove-dead-code) :select (CFG-remove-dead-code))
    )))

(let ()
  (define parsed
   `((MAIN (run? OPT* --? <filename>))
     (RUN (run))
     (BREAK (--))
     (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-remove-dead-code parsed))

  (assert=
   i1
   `((MAIN (run? OPT* --? <filename>))
     (OPT (--trace) (--no-trace)))))

(let ()
  (define parsed
   `((MAIN (RUN? OPT* --? <filename>))
     (RUN (run now))
     (BREAK (--))
     (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-remove-dead-code parsed))

  (assert=
   i1
   `((MAIN (RUN? OPT* --? <filename>))
     (RUN (run now))
     (OPT (--trace) (--no-trace)))))

(let ()
  (define parsed
    `((MAIN (RUN OPT* BREAK? <filename>))
      (RUN (run now))
      (BREAK (--))
      (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-remove-dead-code parsed))

  (assert=
   i1
   `((MAIN (RUN OPT* BREAK? <filename>))
     (RUN (run now))
     (BREAK (--))
     (OPT (--trace) (--no-trace)))))

(let ()
  (define parsed
    `((MAIN (RUN OPT* BREAK? <filename>))
      (RUN (run now))
      (BREAK (--))
      (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-remove-dead-code parsed))

  (assert=
   i1
   `((MAIN (RUN OPT* BREAK? <filename>))
     (RUN (run now))
     (BREAK (--))
     (OPT (--trace) (--no-trace)))))

(let ()
  (define parsed
    `((MAIN (A B C))
      (B (D E F))
      (E (G H K))
      (U (Z W M))))

  (define i1
    (CFG-remove-dead-code parsed))

  (assert=
   i1
   `((MAIN (A B C))
     (B (D E F)))))
