
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates cfg-inline) CFG-inline))
   (import (only (euphrates debug) debug))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           let
           quasiquote))))


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
   `((ROOT (run? OPT* --? <filename>)
           (debug <filename>))
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
