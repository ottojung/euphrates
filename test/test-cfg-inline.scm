
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
   `((ROOT (run? OPT* --? <filename>))
     (MAIN (run? OPT* --? <filename>))
     (RUN (run))
     (BREAK (--))
     (OPT (--trace) (--no-trace)))))

(let ()
  (define parsed
    `((ROOT (MAIN))
      (MAIN (RUN? OPT* BREAK? <filename>)
            (debug <filename>))
      (RUN (run))
      (BREAK (--))
      (OPT (--trace) (--no-trace))))

  (define i1
    (CFG-inline parsed))

  (assert=
   i1
   `((ROOT (MAIN))
     (MAIN (run? OPT* --? <filename>)
           (debug <filename>))
     (RUN (run))
     (BREAK (--))
     (OPT (--trace) (--no-trace)))))

(let ()
  (define parsed
    `((ROOT (MAIN))
      (MAIN (ROOT))))

  (define i1
    (CFG-inline parsed))

  (assert=
   i1
   `((ROOT (ROOT))
     (MAIN (MAIN)))))
