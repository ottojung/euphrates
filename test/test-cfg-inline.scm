
(cond-expand
 (guile
  (define-module (test-cfg-inline)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates cfg-inline) :select (CFG-inline))
    )))

(let ()
  (define parsed
    `((MAIN (RUN? OPT* BREAK? <filename>))
      (RUN (run))
      (BREAK (--))
      (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-inline parsed))

  (assert=
   i1
   `((MAIN (run? OPT* --? <filename>))
     (RUN (run))
     (BREAK (--))
     (OPT (--trace) (--no-trace)))))

(let ()

  (define parsed
    `((MAIN (RUN? OPT* BREAK? <filename>))
      (RUN (run now))
      (BREAK (--))
      (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-inline parsed))

  (assert=
   i1
   `((MAIN (RUN? OPT* --? <filename>))
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
    (CFG-inline parsed))

  (assert=
   i1
   `((MAIN (run now OPT* --? <filename>))
     (RUN (run now))
     (BREAK (--))
     (OPT (--trace) (--no-trace)))))

(let ()
  (define parsed
    `((ROOT (MAIN))
      (MAIN (RUN? OPT* BREAK? <filename>))
      (RUN (run))
      (BREAK (--))
      (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-inline parsed))

  (assert=
   i1
   `((ROOT (RUN? OPT* BREAK? <filename>))
     (MAIN (run? OPT* --? <filename>))
     (RUN (run))
     (BREAK (--))
     (OPT (--trace) (--no-trace)))))
