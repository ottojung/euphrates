
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-equal-hs) assert=HS))
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates compile-regex-cli)
           compile-regex-cli:IR->Regex
           compile-regex-cli:make-IR))
   (import (only (euphrates const) const))
   (import
     (only (euphrates hashmap)
           hashmap->alist
           make-hashmap))
   (import
     (only (euphrates regex-machine)
           make-regex-machine*))
   (import
     (only (scheme base)
           *
           =
           and
           begin
           cond-expand
           define
           let
           list
           or
           quote))))


;; compile-regex-cli

(let ()
  (let ()
    (define cli-decl
      '(run --opts <opts*> --param1 <arg1> --flag1? --no-flag1? <file>
            (may <nth> -p <x>)
            (june <nth> -f3? -f4?)
            (<kek*>)
            <end-statement>))
    (define IR
      (compile-regex-cli:make-IR cli-decl))
    (define Regex
      ((compile-regex-cli:IR->Regex '((run let go))) IR))
    (define M
      (make-regex-machine* Regex))

    (define H (make-hashmap))
    (define R (M H (list "go" "--flag1" "somefile" "june" "5" "the-end")))

    (assert=
     '((const . "run") (fg (param "--opts" word* . "<opts*>") (param "--param1" word . "<arg1>") (flag . "--flag1") (flag . "--no-flag1")) (word . "<file>") (or ((const . "may") (word . "<nth>") (fg (param "-p" word . "<x>"))) ((const . "june") (word . "<nth>") (fg (flag . "-f3") (flag . "-f4"))) ((word* . "<kek*>"))) (word . "<end-statement>"))
     IR "Bad IR")

    (assert=
     '(and (or (= "run" "run") (= "let" "run") (= "go" "run")) (* (or (and (= "--opts" "--opts") (* (any* "<opts*>"))) (and (= "--param1" "--param1") (any "<arg1>")) (= "--flag1" "--flag1") (= "--no-flag1" "--no-flag1"))) (any "<file>") (or (and (= "may" "may") (any "<nth>") (* (or (and (= "-p" "-p") (any "<x>"))))) (and (= "june" "june") (any "<nth>") (* (or (= "-f3" "-f3") (= "-f4" "-f4")))) (and (* (any* "<kek*>")))) (any "<end-statement>"))
     Regex "Bad Regex")

    (assert R)
    (assert=HS
     (hashmap->alist H)
     '(("<file>" . "somefile") ("<end-statement>" . "the-end") ("--flag1" . "--flag1") ("run" . "go") ("<nth>" . "5") ("june" . "june")))))
