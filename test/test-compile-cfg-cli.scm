
%run guile

;; compile-cfg-cli
%use (assert=) "./euphrates/assert-equal.scm"
%use (CFG-CLI->CFG-lang) "./euphrates/compile-cfg-cli.scm"

(let ()
  (define input
    '(run OPTS* DATE <end-statement>
          OPTS    : --opts <opts...>*
                  / --param1 <arg1>
                  / --flag1
          DATE    : may  <nth> MAY-OPTS?
                  / june <nth> JUNE-OPTS*
          MAY-OPTS     : -p <x>
          JUNE-OPTS    : -f3 / -f4))

  (define synonyms '())

  (define compiler (CFG-CLI->CFG-lang synonyms))

  (define result (compiler input))

  (assert= result
           '((EUPHRATES-CFG-CLI-MAIN (and (= "run" "run")
                                          (* (call OPTS))
                                          (call DATE)
                                          (any "<end-statement>")))
             (OPTS (or (and (= "--opts" "--opts") (* (any* "<opts...>*")))
                        (and (= "--param1" "--param1") (any "<arg1>"))
                        (and (= "--flag1" "--flag1"))))
             (DATE (or (and (= "may" "may")
                            (any "<nth>")
                            (? (call MAY-OPTS)))
                       (and (= "june" "june")
                            (any "<nth>")
                            (* (call JUNE-OPTS)))))
             (MAY-OPTS (and (= "-p" "-p") (any "<x>")))
             (JUNE-OPTS
              (or (and (= "-f3" "-f3")) (and (= "-f4" "-f4")))))))
