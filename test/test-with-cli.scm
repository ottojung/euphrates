
%run guile

;; with-cli
%use (assert=HS) "./euphrates/assert-equal-hs.scm"
%use (assert=) "./euphrates/assert-equal.scm"
%use (assert) "./euphrates/assert.scm"
%use (command-line-argumets/p) "./euphrates/command-line-arguments-p.scm"
%use (with-cli) "./euphrates/define-cli.scm"

(let ()
  (parameterize
      ((command-line-argumets/p
        (list "--opt1" "cmdarg1")))
    (with-cli
     (OPT
      OPT : --opt1 <arg1>
      /     --opt2 <arg2>
      /     --opt3 <arg3>
      )

     (assert (procedure? /))
     (assert (string? <arg1>))
     (assert --opt1)
     (assert= #f --opt2)
     (assert= #f --opt3)
     (assert= #f <arg2>)
     (assert= #f <arg3>)

     )))

(let ()
  (parameterize
      ((command-line-argumets/p
        (list "a" "b" "c" "d" "e")))
    (with-cli
     (OPT
      OPT : GROUP1* GROUP2*
      GROUP1 : <group1...>
      GROUP2 : <group2...>
      )

     (assert= <group1...> '("e" "d" "c" "b" "a"))

     )))

(let ()

  (define ret
    (parameterize
        ((command-line-argumets/p
          (list "go" "--flag1" "-o" "fast" "-O1!" "june" "5" "the-end")))

      (with-cli
       (run OPTS* DATE <end-statement>
            OPTS   : --opts <opts...>+
            /        --param1 <arg1>
            /        --flag1
            /        --no-flag1
            DATE   : may  <nth> MAY-OPTS?
            /        june <nth> JUNE-OPTS*
            MAY-OPTS    : -p <x>
            JUNE-OPTS   : -f3 / -f4)

       ;; :exclusive (--flag1 --no-flag1)
       :synonym (--opts --options -o)
       :synonym (run let go)
       :type (<opts...>+ '("fast" -O0! -O1! -O2! -O3!))
       :type (<nth> 'number)
       :help (<nth> "day of month")
       :default (<arg1> 'defaultarg1)

       :help "general help here"
       :help (june "is a cool month")
       ;; :example (run --opts fast -O3! --flag1 some/fi.le june 30 goodbye))

       (assert= <arg1> "defaultarg1")
       (assert=HS <opts...>+ '("fast" -O1!)) ;; note the different types

       (string-append "prefix-" run "-"
                      (number->string (+ <nth> <nth>))))))

  (assert= ret "prefix-go-10"))

(let ()
  (define in/out-types '(raw word normal))

  (parameterize
      ((command-line-argumets/p
        (list "--base" "10" "--soft")))

    (with-cli
     (OPTS*
      OPTS : --in <input-type>
      /      --soft
      /      --out <output-type>
      /      --base <base-raw>
      /      --inbase <inbase-raw>
      /      --infinite
      )

     :type (<input-type> in/out-types)
     :type (<output-type> in/out-types)
     :default (<input-type> 'normal)
     :default (<output-type> 'normal)

     :type (<base-raw> in/out-types 'number)
     :type (<inbase-raw> in/out-types 'number)
     :default (<base-raw> 'default)
     :default (<inbase-raw> 2)

     (assert= 10 <base-raw>)
     (assert --soft))))

(let ()
  (define in/out-types '(raw word normal))

  (parameterize
      ((command-line-argumets/p
        (list "--base" "10" "--soft" "--base" "13")))

    (with-cli
     (OPTS*
      OPTS : --in <input-type>
      /      --soft
      /      --out <output-type>
      /      --base <base-raw>
      /      --inbase <inbase-raw>
      /      --infinite
      )

     :type (<input-type> in/out-types)
     :type (<output-type> in/out-types)
     :default (<input-type> 'normal)
     :default (<output-type> 'normal)

     :type (<base-raw> in/out-types 'number)
     :type (<inbase-raw> in/out-types 'number)
     :default (<base-raw> 'default)
     :default (<inbase-raw> 2)

     (assert= 13 <base-raw>)
     (assert --soft))))

(let ()
  (define in/out-types '(raw word normal))

  (parameterize
      ((command-line-argumets/p
        (list "--base" "10" "--soft" "--base" "13" "--in" "raw" "--in" "word")))

    (with-cli
     (OPTS*
      OPTS : --in <input-type>
      /      --soft
      /      --out <output-type>
      /      --base <base-raw>
      /      --inbase <inbase-raw>
      /      --infinite
      )

     :type (<input-type> in/out-types)
     :type (<output-type> in/out-types)
     :default (<input-type> 'normal)
     :default (<output-type> 'normal)

     :type (<base-raw> in/out-types 'number)
     :type (<inbase-raw> in/out-types 'number)
     :default (<base-raw> 'default)
     :default (<inbase-raw> 2)

     (assert= 13 <base-raw>)
     (assert= 'word <input-type>)
     (assert --soft))))

(let ()
  (define in/out-types '(raw word normal))

  (parameterize
      ((command-line-argumets/p
        (list "--base" "10" "--soft" "--base" "13" "--hard" "--in" "raw" "--in" "word")))

    (with-cli
     (OPTS*
      OPTS : --in <input-type>
      /      --soft
      /      --hard
      /      --out <output-type>
      /      --base <base-raw>
      /      --inbase <inbase-raw>
      /      --infinite
      )

     :type (<input-type> in/out-types)
     :type (<output-type> in/out-types)
     :default (<input-type> 'normal)
     :default (<output-type> 'normal)

     :type (<base-raw> in/out-types 'number)
     :type (<inbase-raw> in/out-types 'number)
     :default (<base-raw> 'default)
     :default (<inbase-raw> 2)

     :exclusive (--soft --hard)

     (assert= 13 <base-raw>)
     (assert= 'word <input-type>)
     (assert --hard)
     (assert (not --soft)))))
