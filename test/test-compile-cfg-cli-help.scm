
(cond-expand
 (guile
  (define-module (test-compile-cfg-cli-help)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates compile-cfg-cli-help) :select (CFG-AST->CFG-CLI-help))
    :use-module ((euphrates current-program-path-p) :select (current-program-path/p))
    :use-module ((euphrates define-cli) :select (make-cli-with-handler)))))


(define MAX-BASE 90)
(define DEFAULT-BASE 64)
(define ALPHANUM-BASE 62)
(define LOWER-BASE 36)

(define bases
  `((hex . 16)
    (binary . 2)
    (octal . 8)
    (max . ,MAX-BASE)
    (lower . ,LOWER-BASE)
    (alphanum . ,ALPHANUM-BASE)
    (alpha . alpha)
    (default . ,DEFAULT-BASE)
    (base64 . base64)))
(define base-types
  (map car bases))

(define in/out-types '(raw word normal))

(define-syntax-rule (test-bodies cli-decl defaults examples helps types exclusives synonyms bodies)
  ((begin . bodies) (quote cli-decl) defaults examples helps types exclusives synonyms))

(make-cli-with-handler
 test-bodies

 (OPTION*
  OPTION* : --in <input-type>
  /         --out <output-type>
  /         --inbase <inbase-type>
  /         --base <base-type>
  /         --soft
  /         --hard
  /         --finite
  /         --infinite
  )

 :help (<input-type> "type of input bytes that come from stdin")
 :help (<output-type> "type of out bytes that go to stdout")
 :help (<inbase-type> "base of input bytes that come from stdin")
 :help (<base-type> "base of out bytes that go to stdout")

 :type (<input-type> in/out-types)
 :type (<output-type> in/out-types)
 :default (<input-type> 'normal)
 :default (<output-type> 'normal)

 :type (<base-type> 'number base-types)
 :type (<inbase-type> 'number base-types)
 :default (<base-type> 'default)
 :default (<inbase-type> 2)

 :default (--hard #t)
 :exclusive (--hard --soft)

 :default (--finite #t)
 :exclusive (--finite --infinite)

 (lambda (cli-decl defaults examples helps types exclusives synonyms)

   (define compiler
     (CFG-AST->CFG-CLI-help helps types defaults))

   (define result
     (parameterize ((current-program-path/p "my-program"))
       (compiler cli-decl)))

   ;; (display result) (newline))

   (assert (string? result))

   )

 )
