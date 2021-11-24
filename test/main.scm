
%run guile

%use (get-directory-name) "./src/get-directory-name.scm"
%use (get-current-source-file-path) "./src/get-current-source-file-path.scm"
%use (append-posix-path) "./src/append-posix-path.scm"
%use (run-comprocess/p-default) "./src/run-comprocess-p-default.scm"
%use (make-uni-spinlock) "./src/uni-spinlock.scm"
%use (debug) "./src/debug.scm"
%use (debugv) "./src/debugv.scm"
%use (with-ignore-errors!) "./src/with-ignore-errors.scm"
%use (random-choice) "./src/random-choice.scm"
%use (printable/alphabet) "./src/printable-alphabet.scm"
%use (catch-any) "./src/catch-any.scm"
%use (assert) "./src/assert.scm"
%use (assert=) "./src/assert-equal.scm"
%use (make-queue queue-empty? queue-peek queue-push! queue-pop! queue->list) "./src/queue.scm"
%use (with-dynamic) "./src/with-dynamic.scm"
%use (lazy-parameter) "./src/lazy-parameter.scm"
%use (~a) "./src/tilda-a.scm"
%use (~s) "./src/tilda-s.scm"
%use (hash->mdict ahash->mdict mdict mdict-has? mdict-set! mdict->alist mdict-keys) "./src/mdict.scm"
%use (string->words) "./src/string-to-words.scm"
%use (words->string) "./src/words-to-string.scm"
%use (list->tree) "./src/list-to-tree.scm"
%use (list-traverse) "./src/list-traverse.scm"
%use (range) "./src/range.scm"
%use (use-svars with-svars with-package make-package make-static-package) "./src/package.scm"
%use (letin) "./src/letin.scm"
%use (list-intersperse) "./src/list-intersperse.scm"
%use (path-replace-extension) "./src/path-replace-extension.scm"
%use (define-rec define-rec?) "./src/define-rec.scm"
%use (apploop) "./src/apploop.scm"
%use (string-trim-chars) "./src/string-trim-chars.scm"
%use (file-or-directory-exists?) "./src/file-or-directory-exists-q.scm"
%use (get-directory-name) "./src/get-directory-name.scm"
%use (directory-files) "./src/directory-files.scm"
%use (directory-files-rec) "./src/directory-files-rec.scm"
%use (directory-tree) "./src/directory-tree.scm"
%use (hashmap) "./src/hashmap.scm"
%use (hashmap-ref hashmap->alist) "./src/ihashmap.scm"
%use (make-hashset hashset-equal? hashset-difference) "./src/ihashset.scm"
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (list-permutations) "./src/list-permutations.scm"
%use (list-combinations) "./src/list-combinations.scm"
%use (cartesian-product) "./src/cartesian-product.scm"
%use (list-insert-at) "./src/list-insert-at.scm"
%use (list-deduplicate) "./src/list-deduplicate.scm"
%use (list-break) "./src/list-break.scm"
%use (list-tag list-untag) "./src/list-tag.scm"
%use (list-tag/next list-untag/next) "./src/list-tag-next.scm"
%use (comp appcomp) "./src/comp.scm"
%use (make-regex-machine*) "./src/regex-machine.scm"
%use (make-cfg-machine) "./src/cfg-machine.scm"
%use (compile-regex-cli:IR->Regex compile-regex-cli:make-IR) "./src/compile-regex-cli.scm"
%use (make-cli lambda-cli with-cli make-cli-with-handler) "./src/define-cli.scm"
%use (command-line-argumets/p) "./src/command-line-arguments-p.scm"
%use (system-re) "./src/system-re.scm"
%use (number->number-list number-list->number number->number-list) "./src/number-list.scm"
%use (convert-number-base) "./src/convert-number-base.scm"
%use (define-property) "./src/properties.scm"
%use (seconds->time-string) "./src/time-to-string.scm"
%use (time-get-current-unixtime) "./src/time-get-current-unixtime.scm"
%use (time-get-monotonic-nanoseconds-timestamp) "./src/time-get-monotonic-nanoseconds-timestamp.scm"
%use (path-without-extension) "./src/path-without-extension.scm"
%use (path-extension) "./src/path-extension.scm"
%use (shell-quote) "./src/shell-quote.scm"
%use (immutable-hashmap) "./src/immutable-hashmap.scm"
%use (immutable-hashmap-ref immutable-hashmap-set immutable-hashmap->alist) "./src/i-immutable-hashmap.scm"
%use (list-split-on) "./src/list-split-on.scm"
%use (CFG-CLI->CFG-lang) "./src/compile-cfg-cli.scm"
%use (CFG-AST->CFG-CLI-help) "./src/compile-cfg-cli-help.scm"
%use (current-program-path/p) "./src/current-program-path-p.scm"
%use (profun-create-database profun-eval-query) "./src/profun.scm"
%use (profun-make-handler) "./src/profun-make-handler.scm"
%use (profun-handler-lambda) "./src/profun-handler-lambda.scm"
%use (profun-op-unify) "./src/profun-op-unify.scm"
%use (profun-op-separate) "./src/profun-op-separate.scm"
%use (profun-op+) "./src/profun-op-plus.scm"
%use (profun-op*) "./src/profun-op-mult.scm"
%use (profun-op-less) "./src/profun-op-less.scm"
%use (profun-op-divisible) "./src/profun-op-divisible.scm"
%use (profun-make-set) "./src/profun-make-set.scm"
%use (profun-make-tuple-set) "./src/profun-make-tuple-set.scm"
%use (profun-op-apply profun-apply-return! profun-apply-fail!) "./src/profun-op-apply.scm"
%use (profun-op-eval profun-eval-fail!) "./src/profun-op-eval.scm"
%use (list-take-while) "./src/list-take-while.scm"
%use (petri-run petri-push) "./src/petri.scm"
%use (raisu) "./src/raisu.scm"
%use (with-np-thread-env#non-interruptible) "./src/np-thread-parameterize.scm"
%use (dynamic-thread-yield) "./src/dynamic-thread-yield.scm"
%use (dynamic-thread-spawn) "./src/dynamic-thread-spawn.scm"
%use (dynamic-thread-cancel) "./src/dynamic-thread-cancel.scm"
%use (dprintln) "./src/dprintln.scm"
%use (lines->string) "./src/lines-to-string.scm"
%use (petri-lambda-net) "./src/petri-net-parse.scm"
%use (petri-profun-net) "./src/petri-net-parse-profun.scm"
%use (string-drop-n) "./src/string-drop-n.scm"
%use (string-take-n) "./src/string-take-n.scm"
%use (time-get-current-unixtime/values#p) "./src/time-get-current-unixtime-values-p.scm"
%use (date-get-current-string) "./src/date-get-current-string.scm"
%use (date-get-current-time24h-string) "./src/date-get-current-time24h-string.scm"
%use (syntax-flatten*) "./src/syntax-flatten-star.scm"
%use (syntax-append) "./src/syntax-append.scm"
%use (syntax-map) "./src/syntax-map.scm"
%use (fn) "./src/fn.scm"
%use (list-zip) "./src/list-zip.scm"
%use (list-zip-with) "./src/list-zip-with.scm"
%use (fn-tuple) "./src/fn-tuple.scm"
%use (fp) "./src/fp.scm"
%use (compose-under) "./src/compose-under.scm"
%use (list-partition) "./src/list-partition.scm"
%use (string->seconds) "./src/string-to-seconds.scm"
%use (monadic) "./src/monadic.scm"
%use (monadic-id) "./src/monadic-id.scm"
%use (monad-maybe) "./src/monad-maybe.scm"
%use (monadfin?) "./src/monadfin.scm"
%use (monad-log) "./src/monad-log.scm"
%use (with-monadic-left with-monadic-right) "./src/monadic-parameterize.scm"
%use (monad-ret) "./src/monad.scm"
%use (monad-lazy) "./src/monad-lazy.scm"
%use (monad-except) "./src/monad-except.scm"
%use (monad-identity) "./src/monad-identity.scm"
%use (list-fold) "./src/list-fold.scm"
%use (list-blocks) "./src/list-blocks.scm"
%use (list-windows) "./src/list-windows.scm"
%use (list-length=<?) "./src/list-length-geq-q.scm"
%use (compose-under-par) "./src/compose-under-par.scm"

(let ()
  (catch-any
   (lambda _ (assert (= (+ 3 2) (- 10 3))))
   (lambda errors
     (assert
      (equal? errors
              '((assertion-fail (test: (= 5 7)) (original: (= (+ 3 2) (- 10 3))))))))))

(let ()
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable/alphabet))))))

(let ()
  (assert=
   "error:"
   (cadr
    (string->words
     (with-output-to-string
       (lambda ()
         (parameterize ((current-error-port (current-output-port)))
           (with-ignore-errors!
            (raisu 'test "arg1" "arg2")))))))))

;; queue
(let ()
  (define q (make-queue 1))
  (assert= '() (queue->list q))

  (queue-push! q 1)
  (queue-push! q 2)
  (queue-push! q 3)

  (assert= '(1 2 3) (queue->list q))

  (assert= (queue-peek q) 1)
  (assert= '(1 2 3) (queue->list q))

  (assert= (queue-pop! q) 1)
  (assert= '(2 3) (queue->list q))

  (assert= (queue-peek q) 2)
  (assert= '(2 3) (queue->list q))

  (assert= (queue-pop! q) 2)
  (assert= '(3) (queue->list q))

  (assert (not (queue-empty? q)))

  (queue-push! q 9)
  (assert= '(3 9) (queue->list q))

  (assert= (queue-pop! q) 3)
  (assert= '(9) (queue->list q))

  (queue-push! q 8)
  (assert= '(9 8) (queue->list q))

  (assert= (queue-pop! q) 9)
  (assert= '(8) (queue->list q))

  (queue-push! q 7)
  (assert= '(8 7) (queue->list q))

  (assert= (queue-pop! q) 8)
  (assert= '(7) (queue->list q))

  (assert= (queue-pop! q) 7)
  (assert= '() (queue->list q))

  (assert (queue-empty? q)))


;; lazy-parameter, with-dynamic
(let ()
  (define test 1)
  (define x (lazy-parameter (begin (set! test 3) 2)
                            (lambda (z) (string->number (~a z)))))
  (define y (make-parameter 9))

  (assert= test 1)
  (assert= (y) 9)

  (with-dynamic ((x 4) (y 5))
                (assert= (y) 5)
                (assert= (x) 4)
                (assert= test 1))

  (assert= test 1)
  (assert= (x) 2)
  (assert= test 3))

;; mdict
(let ()
  (let ((zz (mdict 1 2
                   3 4)))
    (assert= (zz 3)
                  4)
    (let ((z2 (zz 3 99)))
      (assert= (z2 3)
                    99)
      (assert (mdict-has? z2 3))
      (assert (not (mdict-has? z2 52)))
      (let ((z3 (z2 52 2)))
        (assert (mdict-has? z3 52))
        (mdict-set! z3 52 9)
        (assert= (z3 52) 9)))))

;; string->words / words->string
(let ()
  (assert=
   (string->words "hello \t \t \n world!")
   (list "hello" "world!"))

  (assert=
   (words->string (list "hello" "world!"))
   "hello world!"))

;; list->tree
(let ()
  (define ex
    (map string->symbol
         (string->words "hello < define ex < words x > > bye")))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list x)))
       ((equal? '> x)
        (values 'close (list x)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert=
     r
     '(hello
       (< define ex (< words x >) >)
       bye)))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list)))
       ((equal? '> x)
        (values 'close (list)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert=
     r
     '(hello
       (define ex (words x))
       bye))))

;; list-traverse
(let ()
  (assert=
   6
   (list-traverse
    (range 10)
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t xs)))))

  (assert=
   'custom-default
   (list-traverse
    (range 10)
    'custom-default
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t (list)))))))

;; package
(let ()
  (define already-defined 7)

  (define x
    (with-svars [already-defined]
                (lambda (c) (list already-defined c))))

  (define y
    ((use-svars x (b 2) (already-defined 1)) 4))

  (define z
    ((x) 4))

  (define p
    (make-package [already-defined]
                  [[foo (lambda (c) (list already-defined c))]
                   [bar (lambda (c) (list c already-defined))]
                   [baz 3]]))

  (define p-inst (p (cons 'already-defined 22)))
  (define foo-inst (hashmap-ref p-inst 'foo))

  (assert= y (list 1 4))
  (assert= z (list 7 4))

  (assert=
   (list 22 2)
   (foo-inst 2))

  (assert=
   (list 3 2)
   (with-package
    [p [b 2] [already-defined 3]]
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    p
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    [p]
    [foo bar baz]
    (begin
      (foo 2)))))

;; letin
(let ()
  (letin
   [k (letin
       [i 2]
       [c 3]
       [r (+ i c)])]
   (do (assert= k 5))
   [[c k] (letin
           [i 2]
           [(c k) (values 3 4)]
           [[r m] (values (+ i c k) 0)])]
   (do (assert= c 9))
   (do (assert= k 0))))

;; list-intersperse
(let ()
  (assert= (list 0 'x 1 'x 2)
           (list-intersperse 'x (list 0 1 2)))
  (assert= (list 0)
           (list-intersperse 'x (list 0)))
  (assert= (list)
           (list-intersperse 'x (list)))
  (assert= 199
           (length (list-intersperse 'x (range 100)))))

;; path-replace-extension
(let ()
  (assert=
   "file.b.c"
   (path-replace-extension "file.b.a" ".c")))

;; define-rec
(let ()
  (define-rec rec1 aa bb)

  (let ((rec (rec1 1 2)))

    (assert (define-rec? rec))
    (assert= 1 (rec1-aa rec))
    (set-rec1-aa! rec 10)
    (assert= 10 (rec1-aa rec))))

;; apploop
(let ()
  (assert=
   120
   (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1)))))))

;; string-trim-chars
(let* ((s "xxhellokh")
       (tt "hx"))
  (define (test mode) (string-trim-chars s tt mode))

  (assert= "ellokh" (test 'left))
  (assert= "xxhellok" (test 'right))
  (assert= "ellok" (test 'both)))

;; hashset positive
(let ()
  (assert
   (hashset-equal?
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4)))
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4))))))

;; hashset negative
(let ()
  (assert
   ((negate hashset-equal?)
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4)))
    (make-hashset '((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0) (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1) (1 1 1 0) (1 1 1 1))))))

;; hashset difference
(let ()
  (assert
   (hashset-equal?
    (make-hashset '(1 2 3))
    (hashset-difference
     (make-hashset '(1 2 3 4 5))
     (make-hashset '(4 5 7 8))))))

;; file-or-directory-exists?
(let ()
  (assert (file-or-directory-exists? "/"))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir1" "ab")))
  (assert (file-or-directory-exists? (append-posix-path "test" "filetests" "dir2")))
  (assert (not (file-or-directory-exists? (append-posix-path "test" "filetests" "dir3")))))

;; assert=HS
(let ()
  (assert=HS '(a b c d) '(a b c d))
  (assert=HS '(a b c d) '(b d c a)))

;; ;; Disabled due to guile's API change. TODO: fix
;; ;; directory-files
;; (let ()
;;   (assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
;;              (directory-files "test/filetests"))
;;   (assert=HS '(("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
;;              (directory-files "test/filetests" #f))
;;   (assert=HS '(("test/filetests/dir1" "dir1") ("test/filetests/dir2" "dir2") ("test/filetests/b" "b") ("test/filetests/a" "a") ("test/filetests/cdefg" "cdefg"))
;;              (directory-files "test/filetests" #t)))

;; directory-files-rec
(let ()
  (assert=HS '(("test/filetests/dir2/file1" "file1" "test/filetests/dir2" "test/filetests") ("test/filetests/dir1/dir1/zzz" "zzz" "test/filetests/dir1/dir1" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ccc" "ccc" "test/filetests/dir1" "test/filetests") ("test/filetests/dir1/ab" "ab" "test/filetests/dir1" "test/filetests") ("test/filetests/b" "b" "test/filetests") ("test/filetests/a" "a" "test/filetests") ("test/filetests/cdefg" "cdefg" "test/filetests"))
             (directory-files-rec "test/filetests")))

(let ()
  (assert=HS '((1 2 3 4) (2 1 3 4) (1 3 2 4) (3 1 2 4) (2 3 1 4) (3 2 1 4) (1 2 4 3) (2 1 4 3) (1 4 2 3) (4 1 2 3) (2 4 1 3) (4 2 1 3) (1 3 4 2) (3 1 4 2) (1 4 3 2) (4 1 3 2) (3 4 1 2) (4 3 1 2) (2 3 4 1) (3 2 4 1) (2 4 3 1) (4 2 3 1) (3 4 2 1) (4 3 2 1))
             (list-permutations (list 1 2 3 4))))

(let ()
  (assert=HS '(() (1) (2) (1 2) (3) (1 3) (2 3) (1 2 3) (4) (1 4) (2 4) (1 2 4) (3 4) (1 3 4) (2 3 4) (1 2 3 4))
             (list-combinations (list 1 2 3 4))))

(let ()
  (assert=HS '((1 2) (1 3) (2 3) (1 4) (2 4) (3 4))
             (list-combinations (list 1 2 3 4) 2)))

(let ()
  (assert=HS '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4))
             (list-combinations (list 1 2 3 4) 2 #t)))

(let ()
  (assert=HS '((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0) (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1) (1 1 1 0) (1 1 1 1))
             (list-combinations (list 0 1) 4 #t)))

;; cartesian-product
(let ()
  (assert=HS '((1 . a) (1 . b) (1 . c) (2 . a) (2 . b) (2 . c) (3 . a) (3 . b) (3 . c))
             (cartesian-product '(1 2 3) '(a b c))))

;; list-insert-at
(let ()
  (assert= '(a b c d)
           (list-insert-at '(a b d) 2 'c))

  (assert= '(a b c d)
           (list-insert-at '(b c d) 0 'a))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 3 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 999999 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) +inf.0 'd)))

;; list-deduplicate
(let ()
  (assert=HS '(a b c d)
           (list-deduplicate '(a b c d)))
  (assert=HS '(a b c d)
           (list-deduplicate '(a b c d c)))
  (assert=HS '(a b c d)
           (list-deduplicate '(a b c a a a d a)))
  (assert=HS '()
           (list-deduplicate '())))

;; list-deduplicate
(let ()
  (define-values (a1 a2)
    (list-break even? '(3 5 7 2 1 9)))

  (assert= a1 '(3 5 7))
  (assert= a2 '(2 1 9)))

;; list-tag
(let ()
  (assert= '((2 (5 3 1) 7 9) (6 (9 7) 1 3))
           (list-tag even? '(1 3 5 2 7 9 6 1 3)))
  (assert= '(2 6)
           (map car (list-tag even? '(1 3 5 2 7 9 6 1 3))))

  (assert= '((2 (5 3 1) 7 9) (6 (9 7)))
           (list-tag even? '(1 3 5 2 7 9 6)))
  (assert= '(2 6)
           (map car (list-tag even? '(1 3 5 2 7 9 6))))

  (assert= '((4 () 1 3 5) (2 (5 3 1) 7 9) (6 (9 7) 1 3))
           (list-tag even? '(4 1 3 5 2 7 9 6 1 3)))
  (assert= '(4 2 6)
           (map car (list-tag even? '(4 1 3 5 2 7 9 6 1 3))))

  (assert= '((4 () 1 3 5) (2 (5 3 1) 7 9) (6 (9 7)))
           (list-tag even? '(4 1 3 5 2 7 9 6)))
  (assert= '(4 2 6)
           (map car (list-tag even? '(4 1 3 5 2 7 9 6))))

  (assert= #f
           (list-tag even? '()))

  (assert= #f
           (list-tag even? '(1 3 5 7)))

  (assert= '(1 3 5 2 7 9 6)
           (list-untag (list-tag even? '(1 3 5 2 7 9 6))))

  )

;; list-tag/next
(let ()
  (assert= '((#f 1 3 5) (2 7 9) (6 1 3))
           (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3)))
  (assert= '(#f 2 6)
           (map car (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3))))

  (assert= '((#f 1 3 5) (2 7 9) (6))
           (list-tag/next #f even? '(1 3 5 2 7 9 6)))
  (assert= '(#f 2 6)
           (map car (list-tag/next #f even? '(1 3 5 2 7 9 6))))

  (assert= '((4 1 3 5) (2 7 9) (6 1 3))
           (list-tag/next #f even? '(4 1 3 5 2 7 9 6 1 3)))
  (assert= '(4 2 6)
           (map car (list-tag/next #f even? '(4 1 3 5 2 7 9 6 1 3))))

  (assert= '((4 1 3 5) (2 7 9) (6))
           (list-tag/next #f even? '(4 1 3 5 2 7 9 6)))
  (assert= '(4 2 6)
           (map car (list-tag/next #f even? '(4 1 3 5 2 7 9 6))))

  (assert= '((#f))
           (list-tag/next #f even? '()))

  (assert= '((#f 1 3 5 7))
           (list-tag/next #f even? '(1 3 5 7)))

  (assert= '(1 3 5 2 7 9 6 1 3)
           (list-untag/next (list-tag/next #f even? '(1 3 5 2 7 9 6 1 3))))
  (assert= '()
           (list-untag/next (list-tag/next #f even? '())))

  )

;; appcomp
(let ()
  (define f
    (comp (+ 2)
          ((lambda (x) (expt x 2)))
          (* 2)))

  (assert= 32 (f 2))

  (assert= 32
           (appcomp 2
                    (+ 2)
                    ((lambda (x) (expt x 2)))
                    (* 2))))

;; regex-machine
(let ()
  (define m (make-regex-machine*
             '(and (any x z)
                   (or (= 3) (= 2 m k))
                   (and* (any* i))
                   (any y))))
  (define H (hashmap))
  (assert (m H (list 1 2 3 9 8 7)))

  (assert=HS
   '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
   (hashmap->alist H)))

;; cfg-machine
(let ()
  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (and* (any* i))
                            (any y))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (and* (any* i))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (and (any* i)))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (epsilon))))))
    (define-values (H sucess?) (m (list 1 2 3 9 8 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7) (i 8 9 3))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((main (and (any x z)
                            (or (= 3) (= 2 m k))
                            (call save-i)
                            (any y)))
                 (save-i (or (and (any* i) (call save-i))
                             (epsilon))))))
    (define-values (H sucess?) (m (list 1 2 7)))
    (assert sucess?)

    (assert=HS
     '((k . 2) (x . 1) (z . 1) (m . 2) (y . 7))
     (immutable-hashmap->alist H)))

  (let ()
    (define m (make-cfg-machine
               '((EUPHRATES-CFG-CLI-MAIN
                  (and (or (= "run" run) (= "let" run) (= "go" run))
                       (? (= "--flag1" --flag1?)))))))
    (define-values (H sucess?) (m (list "go")))
    (assert sucess?)

    (assert=HS
     '((run . "go"))
     (immutable-hashmap->alist H))))

;; compile-cfg-cli
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

    (define H (hashmap))
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

;; make-cli
(let ()
  (define M
    (make-cli
     (run OPTS* DATE <end-statement>
          OPTS   : --opts <opts...>*
                 / --param1 <arg1>
                 / --flag1
          DATE   : may  <nth> MAY-OPTS?
                 / june <nth> JUNE-OPTS*
          MAY-OPTS    : -p <x>
          JUNE-OPTS   : -f3 / -f4)
     :synonym (run let go)))

  (define M2
    (make-cli
     (run --flag1?)
     :synonym (run let go)))

  (assert
   (not
    (M (hashmap)
       (list "go" "--param1" "somefile" "june" "5" "the-end"))))

  (assert (not (M2 (hashmap) (list "go"))))
  (assert (not (M2 (hashmap) (list "go" "--flag1"))))

  )

;; lambda-cli
(let ()

  (define f
    (lambda-cli
     (run OPTS* DATE <end-statement>
          OPTS    : --opts <opts...>*
          /         --param1 <arg1>
          /         --flag1
          DATE    : may  <nth> MAY-OPTS?
          /         june <nth> JUNE-OPTS*
          MAY-OPTS    : -p <x>
          JUNE-OPTS   : -f3 / -f4)
     :synonym (run go)
     (string-append run "-suffix")))

  (assert= "go-suffix"
           (f (list "go" "--param1" "somefile" "june" "5" "the-end"))))

;; with-cli
(let ()
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

  )

;; system-re
(let ()
  (assert= (cons "hello\n" 0) (system-re "echo hello"))
  (assert= (cons "hello\n" 0) (system-re "echo ~a" "hello")))

;; number-list
(let ()
  (assert= 9 (number-list->number 2 '(1 0 0 1) '()))
  (assert= 8 (number-list->number 2 '(1 0 0 0) '()))

  (assert= 0.375
           (exact->inexact (number-list->number 2 '(0 0 0 0) '(0 1 1))))
  (assert= 0.375
           (exact->inexact (number-list->number 2 '() '(0 1 1))))
  (assert= 9.375
           (exact->inexact (number-list->number 2 '(1 0 0 1) '(0 1 1))))
  (assert= 8.375
           (exact->inexact (number-list->number 2 '(1 0 0 0) '(0 1 1))))

  (let ()
    (define-values (wp fp) (number->number-list 2 9))
    (assert= wp '(1 0 0 1))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->number-list 2 8))
    (assert= wp '(1 0 0 0))
    (assert= fp '()))
  (let ()
    (define-values (wp fp) (number->number-list 2 0.375))
    (assert= wp '())
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->number-list 2 9.375))
    (assert= wp '(1 0 0 1))
    (assert= fp '(0 1 1)))
  (let ()
    (define-values (wp fp) (number->number-list 2 8.375))
    (assert= wp '(1 0 0 0))
    (assert= fp '(0 1 1)))
  )

;; convert-number-base
(let ()
  (for-each
   (lambda (p)
     (assert= (car p) (convert-number-base 2 10 (cdr p)))
     (assert= (cdr p) (convert-number-base 10 2 (car p))))
   (list
    (cons (list #\9) (list #\1 #\0 #\0 #\1))
    (cons "9" "1001")
    (cons "8" "1000")
    (cons "0.375" "0.011")
    (cons "9.375" "1001.011")
    (cons "8.375" "1000.011")))

  (assert= "f" (convert-number-base 2 16 "1111"))
  (assert= "1111" (convert-number-base 16 2 "f")))

;; properties
(let ()

  (define object1 -3)
  (define-property absolute set-absolute! oRsDeyPCHkSMLSRztojiqnz)

  (assert= (absolute object1 #f) #f)

  (set-absolute! object1 3)

  (assert= (absolute object1 #f) 3))

;; seconds->time-string
(let ()
  (assert= "2:01:10" (seconds->time-string (+ (* 3600 2) 70))))

;; time-get-current-unixtime
(let ()
  (assert (number? (time-get-current-unixtime))))

;; time-get-monotonic-nanoseconds-timestamp
(let ()
  (let ((ret (time-get-monotonic-nanoseconds-timestamp)))
    (assert (number? ret))
    (assert (integer? ret))
    (assert (> ret 0))))

;; path-without-extension
(let ()
  (assert= "hello" (path-without-extension "hello.txt"))
  (assert= "hello.txt" (path-without-extension "hello.txt.tar"))
  (assert= "hello.txt.tar" (path-without-extension "hello.txt.tar.enc"))

  (assert= "/hi/hello" (path-without-extension "/hi/hello.txt"))
  (assert= "/hi/hello.txt" (path-without-extension "/hi/hello.txt.tar"))
  (assert= "/hi/hello.txt.tar" (path-without-extension "/hi/hello.txt.tar.enc"))

  (assert= "hello" (path-without-extension "hello"))
  (assert= "" (path-without-extension ""))
  (assert= "" (path-without-extension "."))
  )

;; path-extension
(let ()
  (assert= ".txt" (path-extension "hello.txt"))
  (assert= ".tar" (path-extension "hello.txt.tar"))
  (assert= ".enc" (path-extension "hello.txt.tar.enc"))

  (assert= ".txt" (path-extension "/hi/hello.txt"))
  (assert= ".tar" (path-extension "/hi/hello.txt.tar"))
  (assert= ".enc" (path-extension "/hi/hello.txt.tar.enc"))

  (assert= "" (path-extension "hello"))
  (assert= "" (path-extension ""))
  (assert= "." (path-extension "."))
  )

;; shell-quote
(let ()
  (assert= "'$b'" (shell-quote "$b"))
  (assert= "'$'\"'\"'b'" (shell-quote "$'b"))
  (assert= "'$ '\"'\"' b'" (shell-quote "$ ' b"))
  )

;; immutable-hashmap
(let ()
  (define H (immutable-hashmap))
  (define H2 (immutable-hashmap-set H 'a 5))
  (define H3 (immutable-hashmap-set H2 'b 9))
  (define H4 (immutable-hashmap-set H3 'a 7))

  (assert= #f (immutable-hashmap-ref H 'a #f))
  (assert= 5 (immutable-hashmap-ref H2 'a #f))
  (assert= 5 (immutable-hashmap-ref H3 'a #f))
  (assert= 9 (immutable-hashmap-ref H3 'b #f))
  (assert= 7 (immutable-hashmap-ref H4 'a #f))
  (assert= 9 (immutable-hashmap-ref H4 'b #f))
  )

;; list-split-on
(let ()
  (assert= '((1) (3) (5) (7))
           (list-split-on even? (list 1 2 3 4 5 6 7)))
  (assert= '((1 3 5 7))
           (list-split-on even? (list 1 3 5 7)))
  (assert= '((1 3) (5 7))
           (list-split-on even? (list 1 3 2 2 5 7)))
  (assert= '()
           (list-split-on even? (list 2 4 6)))
  )

;; ;; compile-cfg-cli-help
;; (let ()

;;   (define MAX-BASE 90)
;;   (define DEFAULT-BASE 64)
;;   (define ALPHANUM-BASE 62)
;;   (define LOWER-BASE 36)

;;   (define bases
;;     `((hex . 16)
;;       (binary . 2)
;;       (octal . 8)
;;       (max . ,MAX-BASE)
;;       (lower . ,LOWER-BASE)
;;       (alphanum . ,ALPHANUM-BASE)
;;       (alpha . alpha)
;;       (default . ,DEFAULT-BASE)
;;       (base64 . base64)))
;;   (define base-types
;;     (map car bases))

;;   (define in/out-types '(raw word normal))

;;   (let ()
;;     (define-syntax-rule (test-bodies cli-decl defaults examples helps types exclusives synonyms bodies)
;;       ((begin . bodies) (quote cli-decl) defaults examples helps types exclusives synonyms))

;;     (make-cli-with-handler
;;      test-bodies

;;      (OPTION*
;;       OPTION* : --in <input-type>
;;       /         --out <output-type>
;;       /         --inbase <inbase-type>
;;       /         --base <base-type>
;;       /         --soft
;;       /         --hard
;;       /         --finite
;;       /         --infinite
;;       )

;;      :help (<input-type> "type of input bytes that come from stdin")
;;      :help (<output-type> "type of out bytes that go to stdout")
;;      :help (<inbase-type> "base of input bytes that come from stdin")
;;      :help (<base-type> "base of out bytes that go to stdout")

;;      :type (<input-type> in/out-types)
;;      :type (<output-type> in/out-types)
;;      :default (<input-type> 'normal)
;;      :default (<output-type> 'normal)

;;      :type (<base-type> 'number base-types)
;;      :type (<inbase-type> 'number base-types)
;;      :default (<base-type> 'default)
;;      :default (<inbase-type> 2)

;;      :default (--hard #t)
;;      :exclusive (--hard --soft)

;;      :default (--finite #t)
;;      :exclusive (--finite --infinite)

;;      (lambda (cli-decl defaults examples helps types exclusives synonyms)

;;        (define compiler
;;          (CFG-AST->CFG-CLI-help helps types defaults))

;;        (define result
;;          (parameterize ((current-program-path/p "my-program"))
;;            (compiler cli-decl)))

;;        ;; (display result) (newline))

;;        (assert (string? result))

;;      )

;;     )
;;   )

;; profun
(let ()
  (define current-handler
    (make-parameter #f))

  (define current-definitions
    (make-parameter #f))

  (define (test query expected-result)
    (define handler (current-handler))
    (define definitions (current-definitions))
    (define db (profun-create-database handler definitions))
    (define result (profun-eval-query db query))
    (assert= expected-result result))

  (define-syntax test-definitions
    (syntax-rules ()
      ((_ title definitions . body)
       (parameterize ((current-definitions definitions))

         (test '((= 1 0)) '())
         (test '((= 1 1)) '(()))
         (test '((bad-op 1 2 3)) '())
         (test '((= 1 2 3)) '()) ;; bad arity

         (begin . body)))))

  ;;;;;;;;;;;
  ;; TESTS ;;
  ;;;;;;;;;;;

  (parameterize
      ((current-handler
        (profun-make-handler
         (= profun-op-unify)
         (!= profun-op-separate)
         (+ profun-op+)
         (* profun-op*)
         (< profun-op-less)
         (divisible profun-op-divisible)
         (apply profun-op-apply)
         (eval profun-op-eval)
         (favorite (profun-make-set (list 777 2 9 3)))
         (favorite2 (cons 2 (profun-make-tuple-set '((777 2) (#t 9) (3 #f)))))
         )))

    (test-definitions
     "SIMPLE REJECTING"
     '(((abc x y) (= x 3) (= x y) (= y 4)))

     (test '((abc 2 3)) '())
     (test '((abc "hello" "bye")) '())
     (test '((abc a b)) '())
     )

    (test-definitions
     "SIMPLE ACCEPTING"
     '(((abc z k) (= 1 1)))

     (test '((abc 2 3)) '(()))
     (test '((abc "hello" "bye")) '(()))
     (test '((abc a b)) '(()))
     )

    (test-definitions
     "NO DATABASE"
     '()

     (test '((abc 2 3)) '())
     (test '((abc "hello" "bye")) '())
     (test '((abc a b)) '())
     )

    (test-definitions
     "COMPLEX DEFINITIONS"
     '(((abc z k) (= z 8) (= p 10))
       ((yyy x) (abc x))
       ((abc x y) (= x 3) (= x y) (= y 3))
       ((abc x y) (= x "kek") (= y 5))
       ((abc z k) (= z 8) (= k 9)))

     (test '((abc 2 3)) '())
     (test '((abc "hello" "bye")) '())
     (test '((abc x y))
           '(((x . 8)) ((x . 3) (y . 3)) ((x . "kek") (y . 5)) ((x . 8) (y . 9))))
     )

    (test-definitions
     "SIMPLE SUGAR"
     '(((abc 8 y) (= y 10)))

     (test '((abc 2 3)) '())
     (test '((abc "hello" "bye")) '())
     (test '((abc a b)) '(((a . 8) (b . 10))))
     (test '((abc 8 b)) '(((b . 10))))
     (test '((abc 8 10)) '(()))
     (test '((abc a 10)) '(((a . 8))))
     )

    (test-definitions
     "ALL ACCEPTING WITH A SPECIAL CASE"
     '(((start k u) (abc k u))
       ((abc 8 y) (= y 10))
       ((abc x y)))

     (test '((start 2 3)) '(()))
     (test '((start "hello" "bye")) '(()))
     (test '((start a b)) '(((a . 8) (b . 10)) ()))
     (test '((start 8 b)) '(((b . 10)) ()))
     (test '((start 8 10)) '(() ()))
     (test '((start a 10)) '(((a . 8)) ()))
     )

    (test-definitions
     "ALL ACCEPTING WITH A SPECIAL CASE 2"
     '(((start k u) (abc k u))
       ((abc 8 y) (= y 10))
       ((abc x y) (= 1 1)))

     (test '((start 2 3)) '(()))
     (test '((start "hello" "bye")) '(()))
     (test '((start a b)) '(((a . 8) (b . 10)) ()))
     (test '((start 8 b)) '(((b . 10)) ()))
     (test '((start 8 10)) '(() ()))
     (test '((start a 10)) '(((a . 8)) ()))
     )

    (test-definitions
     "NOT EQUAL 1"
     '(((abc 8 y) (= k 10) (= y 3) (!= y k)))

     (test '((abc 2 3)) '())
     (test '((abc "hello" "bye")) '())
     (test '((abc a b)) '(((a . 8) (b . 3))))
     )

    (test-definitions
     "NOT EQUAL 2"
     '(((abc k y) (= y 3) (!= y k)))

     (test '((abc 2 3)) '(()))
     (test '((abc 2 8)) '())
     (test '((abc 8 8)) '())
     (test '((abc 3 3)) '())
     (test '((abc "hello" "bye")) '())
     (test '((abc a b)) '()) ;; because 'a ('k) is not instantiated
     )

    (test-definitions
     "NO ARGUMENTS QUERY 1"
     '(((foo) (= 1 0)))

     (test '((foo)) '())
     )

    (test-definitions
     "NO ARGUMENTS QUERY 2"
     '(((foo) (= 1 1)))

     (test '((foo)) '(()))
     )

    (test-definitions
     "NO ARGUMENTS QUERY 3"
     '(((foo) (= 1 0))
       ((foo) (= 1 1)))

     (test '((foo)) '(()))
     )

    (test-definitions
     "UNIQUENESS"
     '(((foo 1))
       ((foo 2)))

     (test '((foo x) (foo y) (!= x y)) '(((x . 1) (y . 2)) ((x . 2) (y . 1))))
     )

    (test-definitions
     "+ CASES"
     '()

     (test '((+ 2 3 5)) '(()))
     (test '((+ 2 3 1)) '())
     (test '((+ 2 1 5)) '())
     (test '((+ 1 3 5)) '())

     (test '((+ 2 3 z)) '(((z . 5))))
     (test '((+ 2 y 5)) '(((y . 3))))
     (test '((+ x 3 5)) '(((x . 2))))
     )

    (test-definitions
     "* CASES"
     '()

     (test '((* 2 3 6)) '(()))
     (test '((* 2 3 1)) '())
     (test '((* 2 1 5)) '())
     (test '((* 1 3 5)) '())

     (test '((* 2 3 z)) '(((z . 6))))
     (test '((* 2 y 6)) '(((y . 3))))
     (test '((* x 3 6)) '(((x . 2))))

     (test '((* 0 3 z)) '(((z . 0))))
     (test '((* 0 y 6)) '())
     (test '((* x 3 6)) '(((x . 2))))
     )

    (test-definitions
     "< CASES"
     '()

     (test '((< 2 3)) '(()))
     (test '((< 2 2)) '())
     (test '((< 2 1)) '())

     (test '((< x 4)) '(((x . 3)) ((x . 2)) ((x . 1)) ((x . 0))))
     (test '((< x 4) (* 2 x a)) '(((a . 6) (x . 3))
                                  ((a . 4) (x . 2))
                                  ((a . 2) (x . 1))
                                  ((a . 0) (x . 0))))
     (test '((< x 4) (< y x)) '(((x . 3) (y . 2))
                                ((x . 3) (y . 1))
                                ((x . 3) (y . 0))
                                ((x . 2) (y . 1))
                                ((x . 2) (y . 0))
                                ((x . 1) (y . 0))))

     )

    (test-definitions
     "divisible CASES"
     '()

     (test '((divisible 10 4)) '())
     (test '((divisible 10 5)) '(()))
     (test '((divisible 10 x)) '(((x . 1)) ((x . 2)) ((x . 5)) ((x . 10))))
     (test '((divisible 12 x)) '(((x . 1)) ((x . 2)) ((x . 3)) ((x . 4)) ((x . 6)) ((x . 12))))
     (test '((< x 12) (divisible 12 x)) '(((x . 6)) ((x . 4)) ((x . 3)) ((x . 2)) ((x . 1))))
     )

    (test-definitions
     "apply CASES"
     '()

     (test `((= x 3) (apply ,(lambda (y) (profun-apply-return! 2)) x)) '(((x . 2))))
     (test `((= x 3) (apply ,(lambda (y) (profun-apply-return! 2)) y)) '(((x . 3) (y . 2))))
     (test `((= x 3) (apply ,(lambda (y) (profun-apply-fail!)) x)) '())
     (test `((= x 3) (apply ,(lambda (y) 9) x)) '(((x . 3))))
     )

    (test-definitions
     "eval CASES"
     '()

     (test `((= x 3) (eval r ,(lambda (y) 2) x)) '(((x . 3) (r . 2))))
     (test `((= x 3) (eval r ,(lambda (y) 2) y)) '(((x . 3) (r . 2))))
     (test `((= x 3) (eval r ,(lambda (y) (profun-eval-fail!)) x)) '())
     (test `((= x 3) (eval r ,(lambda (y) 9) x)) '(((x . 3) (r . 9))))
     )

    (test-definitions
     "make-set CASES"
     '()

     (test '((favorite x)) '(((x . 777)) ((x . 2)) ((x . 9)) ((x . 3))))
     (test '((favorite 9)) '(()))
     (test '((favorite 922)) '())

     )

    (test-definitions
     "make-tuple-set CASES"
     '()

     (test '((favorite2 x y)) '(((x . 777) (y . 2)) ((y . 9)) ((x . 3))))
     (test '((favorite2 x 2)) '(((x . 777))))
     (test '((favorite2 6 9)) '(()))
     (test '((favorite2 7 9)) '(()))
     (test '((favorite2 x 9)) '(()))
     (test '((favorite2 777 y)) '(((y . 2)) ((y . 9))))
     (test '((favorite2 777 2)) '(()))
     (test '((favorite2 777 9)) '(()))
     (test '((favorite2 777 0)) '())
     (test '((favorite2 3 y)) '(((y . 9)) ()))
     (test '((favorite2 3 8)) '())
     (test '((favorite2 x y z)) '())
     (test '((favorite2 x)) '())
     )

    (test-definitions
     "TUPLE IN THE DATABASE 1"
     '(((inputs y) (= y (((abc def))))))

     (test '((inputs x)) '(((x . (((abc def)))))))

     )

    (test-definitions
     "TUPLE IN THE DATABASE 2"
     '(((inputs (((abc def))))))

     (test '((inputs x)) '(((x . (((abc def)))))))

     )

    )
  )

;; list-take-while
(let ()
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '(1 2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '()))
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8)))
  )

;; np-thread
(let ()
  (define println
    (case-lambda
     ((msg)
      (display (string-append msg "\n")))
     ((msg n)
      (println (string-append msg " " (number->string n))))))

  (define (test-body)
    (define [kek]
      (println "in kek"))

    (define cycles 4)

    (define lol-thread #f)

    (define [lol]
      (let loop ((n 0))
        (if (> n cycles)
            (println "lol ended")
            (begin
              (println "lol at" n)
              (dynamic-thread-yield)
              (println "lol after" n)
              (loop (+ 1 n))))))

    (define [zulul]
      (let loop ((n 0))
        (if (> n cycles)
            (println "zulul ended")
            (begin
              (println "zulul at" n)
              (when (= n 3)
                (dynamic-thread-cancel lol-thread))
              (dynamic-thread-yield)
              (println "zulul after" n)
              (loop (+ 1 n))))))

    (println "start")

    (dynamic-thread-yield)

    (dynamic-thread-spawn kek)
    (set! lol-thread (dynamic-thread-spawn lol))
    (dynamic-thread-spawn zulul)

    (println "end"))

  (define parameterized-order
    (list
     "start"
     "end"
     "in kek"
     "lol at 0"
     "zulul at 0"
     "lol after 0"
     "lol at 1"
     "zulul after 0"
     "zulul at 1"
     "lol after 1"
     "lol at 2"
     "zulul after 1"
     "zulul at 2"
     "lol after 2"
     "lol at 3"
     "zulul after 2"
     "zulul at 3"
     "zulul after 3"
     "zulul at 4"
     "zulul after 4"
     "zulul ended"
     ""))

  (define global-order
    (list
     "start"
     "in kek"
     "lol at 0"
     "lol after 0"
     "lol at 1"
     "lol after 1"
     "lol at 2"
     "lol after 2"
     "lol at 3"
     "lol after 3"
     "lol at 4"
     "lol after 4"
     "lol ended"
     "zulul at 0"
     "zulul after 0"
     "zulul at 1"
     "zulul after 1"
     "zulul at 2"
     "zulul after 2"
     "zulul at 3"
     "zulul after 3"
     "zulul at 4"
     "zulul after 4"
     "zulul ended"
     "end"
     ""))

  (assert=
   (lines->string global-order)
   (with-output-to-string
     test-body))

  (assert=
   (lines->string global-order)
   (with-output-to-string
     test-body))

  (assert=
   (lines->string parameterized-order)
   (with-output-to-string
     (lambda ()
       (with-np-thread-env#non-interruptible
        (test-body)))))

  (assert=
   (lines->string parameterized-order)
   (with-output-to-string
     (lambda ()
       (dynamic-thread-spawn
        test-body))))

  (assert=
   (lines->string global-order)
   (with-output-to-string
     test-body))

  )

;; petri
(let ()

  (define (handler type options)
    (case type
      ((network-finished) (display "Finish\n"))
      (else (display "ERRORS: ") (display options))))

  (let () ;; petrin-lambda-net
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-lambda-net
            (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith")))
                  (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
           )
          ))))

    (assert=
     (lines->string
      (list
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-lambda-net
            (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith")))))
           (petri-lambda-net
            (list (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
           )
          ))))

    (assert=
     (lines->string
      (list
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-lambda-net
            (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith") (petri-push 'bye "Bob" "Rogers")))))
           (petri-lambda-net
            (list (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
           )
          ))))

    )


  (let () ;; petri-profun-net

    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-profun-net
            `(((hello) (apply ,display "Hello\n") (push 'bye "Robert" "Smith"))
              ((bye NAME SURNAME)
               (apply ,display "Bye ")
               (apply ,display NAME)
               (apply ,display " the ")
               (apply ,display SURNAME)
               (apply ,display "!\n")))))))))

    ;; NOTE: not a list of networks, just a single one
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (petri-profun-net
           `(((hello) (apply ,display "Hello\n") (push 'bye "Robert" "Smith"))
             ((bye NAME SURNAME)
              (apply ,display "Bye ")
              (apply ,display NAME)
              (apply ,display " the ")
              (apply ,display SURNAME)
              (apply ,display "!\n"))))))))

    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-profun-net
            `(((hello) (apply ,display "Hello\n") (push 'bye "Robert" "Smith"))
              ((bye NAME SURNAME)
               (print "Bye ~a the ~a!" NAME SURNAME)))))))))

    (assert=
     (lines->string
      (list
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-profun-net
            `(((hello) (apply ,display "Hello\n") (push 'bye "Robert" "Smith"))))
           (petri-profun-net
            `(((bye NAME SURNAME)
               (apply ,display "Bye ")
               (apply ,display NAME)
               (apply ,display " the ")
               (apply ,display SURNAME)
               (apply ,display "!\n")))))))))

    ;; NOTE: Robert was pushed twice, so he is duplicated.
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-profun-net
            `(((name "Robert"))
              ((surname "Smith"))
              ((surname "Rogers"))
              ((hello) (apply ,display "Hello\n") (name N) (surname S) (push 'bye N S))
              ((bye NAME SURNAME)
               (apply ,display "Bye ")
               (apply ,display NAME)
               (apply ,display " the ")
               (apply ,display SURNAME)
               (apply ,display "!\n")))))))))

    ;; NOTE: deduplication enabled
    (assert=
     (lines->string
      (list
       "Hello"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello '((deduplicate)) handler
          (list
           (petri-profun-net
            `(((name "Robert"))
              ((surname "Smith"))
              ((surname "Rogers"))
              ((hello) (apply ,display "Hello\n") (name N) (surname S) (push 'bye N S))
              ((bye NAME SURNAME)
               (apply ,display "Bye ")
               (apply ,display NAME)
               (apply ,display " the ")
               (apply ,display SURNAME)
               (apply ,display "!\n")))))))))

    (assert=
     (lines->string
      (list
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-profun-net
            `(((hello)
               (apply ,display "Hello\n")
               (push 'bye "Robert" "Smith")
               (push 'bye "Bob" "Rogers"))))
           (petri-profun-net
            `(((bye NAME SURNAME)
               (apply ,display "Bye ")
               (apply ,display NAME)
               (apply ,display " the ")
               (apply ,display SURNAME)
               (apply ,display "!\n")))))))))
    )

  (let () ;; mix petri-profun-net and petri-lambda-net

    (assert=
     (lines->string
      (list
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-profun-net
            `(((hello)
               (apply ,display "Hello\n")
               (push 'bye "Robert" "Smith")
               (push 'bye "Bob" "Rogers"))))
           (petri-lambda-net
            (list (list '(bye   . 2) (lambda (name surname) (display "Bye ") (display name) (display " the ") (display surname) (display "!\n")))))
           )
          ))))

    (assert=
     (lines->string
      (list
       "Hello"
       "Finish"
       "Bye Robert the Smith!"
       "Bye Robert the Rogers!"
       "Bye Bob the Smith!"
       "Bye Bob the Rogers!"
       "Finish"
       ""))
     (with-output-to-string
       (lambda _
         (petri-run
          'hello handler
          (list
           (petri-lambda-net
            (list (list '(hello . 0) (lambda () (display "Hello\n") (petri-push 'bye "Robert" "Smith") (petri-push 'bye "Bob" "Rogers")))))
           (petri-profun-net
            `(((bye NAME SURNAME)
               (apply ,display "Bye ")
               (apply ,display NAME)
               (apply ,display " the ")
               (apply ,display SURNAME)
               (apply ,display "!\n")))))))))

    )
  )

(let () ;; string-drop-n
  (assert= "hello" (string-drop-n 0 "hello"))
  (assert= "ello" (string-drop-n 1 "hello"))
  (assert= "llo" (string-drop-n 2 "hello"))
  (assert= "lo" (string-drop-n 3 "hello"))
  (assert= "o" (string-drop-n 4 "hello"))
  (assert= "" (string-drop-n 5 "hello"))
  (assert= "" (string-drop-n 6 "hello"))
  (assert= "" (string-drop-n 612381238 "hello"))
  (assert= "hello" (string-drop-n -1 "hello"))
  (assert= "" (string-drop-n 0 ""))
  (assert= "" (string-drop-n 5 "")))

(let () ;; string-take-n
  (assert= "" (string-take-n 0 "hello"))
  (assert= "h" (string-take-n 1 "hello"))
  (assert= "he" (string-take-n 2 "hello"))
  (assert= "hel" (string-take-n 3 "hello"))
  (assert= "hell" (string-take-n 4 "hello"))
  (assert= "hello" (string-take-n 5 "hello"))
  (assert= "hello" (string-take-n 6 "hello"))
  (assert= "hello" (string-take-n 612381238 "hello"))
  (assert= "" (string-take-n -1 "hello"))
  (assert= "" (string-take-n 0 ""))
  (assert= "" (string-take-n 5 "")))

(let () ;; date-get-current-string
  (parameterize ((time-get-current-unixtime/values#p (lambda () (values 567 1234))))
    (assert= "1970/01/01 01:09:27"
             (date-get-current-string "~Y/~m/~d ~H:~M:~S"))))

(let () ;; date-get-current-time24h-string
  (parameterize ((time-get-current-unixtime/values#p (lambda () (values 567 1234))))
    (assert= "01:09:27"
             (date-get-current-time24h-string))))

(let () ;; syntax-flatten*
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg (quote buf)))))

  (assert= (list 'arg '(a b c g h d h e))
           (syntax-flatten* (cont 'arg) ((a b (c (g h) d) (h) e)))))

(let () ;; syntax-append
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 2 3 4 5 6 7)
           (syntax-append (cont 'arg) (2 3) (4 5 6 7))))

(let () ;; syntax-map
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert=
   '(arg (p . 1) (p . 2) (p . 3) (p . 4) (p . 5))
   (syntax-map (cont 'arg) cons 'p (1 2 3 4 5))))

(let () ;; fn
  (assert= (list 1 2 3)
           ((fn list 1 % 3) 2)))

(let () ;; list-zip
  (assert= '((1 . a) (2 . b) (3 . c))
           (list-zip '(1 2 3) '(a b c)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2 3) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b c)))
  (assert= '()
           (list-zip '() '(a b c)))
  )

(let () ;; list-zip-with
  (assert= '((1 a) (2 b) (3 c))
           (list-zip-with list '(1 2 3) '(a b c)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2 3) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b c)))
  (assert= '()
           (list-zip-with list '() '(a b c)))
  )

(let () ;; fn-tuple
  (assert= '((0 2) (2 3) (4 4))
           (map (fn-tuple (lambda (x) (* x 2)) (lambda (x) (+ x 2)))
                (list-zip-with list (range 3) (range 3)))))

(let () ;; fp
  (assert= '((0 2) (2 3) (4 4))
           (map (fp (x y) (list (* x 2) (+ y 2)))
                (list-zip-with list (range 3) (range 3)))))

(let () ;; compose-under
  (assert= (list 10 25 0)
           ((compose-under list + * -) 5 5))
  (assert= (list 0 1 3 5 7 9)
           (filter (compose-under or zero? odd?) (range 10))))

(let () ;; compose-under-par
  (assert= (list 5 5 -5)
           ((compose-under-par list + * -) 5 5 5))
  (assert= '((2 0) (3 2) (4 4))
           (map (compose-under-par
                 list (lambda (x) (+ 2 x)) (lambda (x) (* 2 x)))
                (range 3) (range 3))))

(let () ;; list-partition
  (assert= '((#t 8 6 4 2 0)
             (#f 9 7 5 3 1))
           (list-partition even? (range 10))))

(let () ;; string->seconds
  (assert= 20 (string->seconds "20s"))
  (assert= 80 (string->seconds "1m20s"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds "2h1m20s"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds "2h1m20s"))
  (assert= (+ (* 2 60 60) (* 1 60) (* 20 1))
           (string->seconds "1m2h20s"))
  (assert= (+ (* 5 60 60) (* 1 60) (* 20 1))
           (string->seconds "1m3h2h20s"))
  )

;; monad basics
(let ()

  (define monad-log/to-string
    (lambda _
      (define buffer "")
      (define (add! monad-input)
        (let ((s (with-output-to-string
                   (lambda _ (monad-log monad-input)))))
          (set! buffer (string-append buffer s))))

      (lambda (monad-input)
        (add! monad-input)
        (if (monadfin? monad-input)
            (monad-ret monad-input buffer)
            monad-input))))

  (assert=
   30
   (monadic-id
    (x (+ 2 3))
    (y (* (x) (x)))
    (h (+ (x) (y)) 'tag1)))

  (assert=
   40
   (monadic-id
    (x (+ 2 3))
    ((y m) (values (* (x) (x)) (+ (x) (x))))
    (h (+ (x) (y) (m)) 'tag1)))

  (call-with-values
      (lambda _
        (monadic-id
         (x (+ 2 3))
         ((y m) (values (* (x) (x)) (+ (x) (x))))
         ((h z) (values (+ (x) (y) (m)) 5) 'tag1)))
    (lambda results
      (assert= '(40 5) results)))

  (assert=
   (lines->string
    (list "(x = 5 = (+ 2 3))"
          "((y m) = (25 10) = (values (* (x) (x)) (+ (x) (x))))"
          "(h = 40 = (+ (x) (y) (m)))"
          "(return 40)"
          ""))

   (with-output-to-string
     (lambda _
       (monadic
        monad-log
        (x (+ 2 3))
        ((y m) (values (* (x) (x)) (+ (x) (x))))
        (h (+ (x) (y) (m)) 'tag1)))))

  (assert=
   (lines->string
    (list "(x = 5 = (+ 2 3))"
          "((y m) = (25 10) = (values (* (x) (x)) (+ (x) (x))))"
          "(h = 40 = (+ (x) (y) (m)))"
          "(return 40)"
          ""))
   (monadic
    (monad-log/to-string)
    (x (+ 2 3))
    ((y m) (values (* (x) (x)) (+ (x) (x))))
    (h (+ (x) (y) (m)) 'tag1)))

  (assert=
   26
   (monadic
    (monad-maybe even?)
    (x (+ 2 3))
    (y (+ 1 (* (x) (x))))
    (h (+ (x) (y)) 'tag1)))

  (assert=
   #f
   (monadic
    (monad-maybe not)
    (x (+ 2 3))
    (k #f) ;; causing to exit fast
    (z (raisu "Should not happen"))))

  (assert=
   26
   (with-monadic-left
    monad-identity
    (monadic
     (monad-maybe (compose-under and number? even?))
     (x (+ 2 3))
     (y (+ 1 (* (x) (x))))
     (h (+ (x) (y)) 'tag1))))

  (with-monadic-left
   (monad-log/to-string)
   (assert=
    (lines->string
     (list "(x = 5 = (+ 2 3))"
           "(y = 26 = (+ 1 (* (x) (x))))"
           "(return 26)"
           ""))
    (monadic
     (monad-maybe (compose-under and number? even?))
     (x (+ 2 3))
     (y (+ 1 (* (x) (x))))
     (h (+ (x) (y)) 'tag1))))

  (assert=
   (lines->string
    (list "(x = 5 = (+ 2 3))"
          "(y = 26 = (+ 1 (* (x) (x))))"
          "(return 26)"
          ""))
   (with-monadic-left
    (monad-log/to-string)
    (monadic
     (monad-maybe (compose-under and number? even?))
     (x (+ 2 3))
     (y (+ 1 (* (x) (x))))
     (h (+ (x) (y)) 'tag1))))

  (with-monadic-left
   (monad-log/to-string)
   (assert=
    (lines->string
     (list "(x = 5 = (+ 2 3))"
           "(y = 26 = (+ 1 (* (x) (x))))"
           "(return 26)"
           ""))
    (monadic
     (monad-maybe even?)
     (x (+ 2 3))
     (y (+ 1 (* (x) (x))))
     (h (+ (x) (y)) 'tag1)))
   )

  (with-monadic-right
   (monad-log/to-string)
   (assert=
    (lines->string
     (list "(x = 5 = (+ 2 3))"
           "(y = 26 = (+ 1 (* (x) (x))))"
           "(return 26)"
           ""))
    (monadic
     (monad-maybe (compose-under and number? even?))
     (x (+ 2 3))
     (y (+ 1 (* (x) (x))))
     (h (+ (x) (y)) 'tag1)))
   )

  )

;; monad-lazy
(let ()
  (assert=
   31
   (monadic
    monad-lazy
    (x (+ 2 3))
    (y (+ 1 (* (x) (x))))
    (h (+ (x) (y)) 'tag1)))

  (assert=
   31
   (monadic
    monad-lazy
    (x (+ 2 3) 'async)
    (y (+ 1 (* (x) (x))) 'async)
    (h (+ (x) (y)) 'tag1))))

;; monad-except
(let ((ran-always #f)
      (throwed #t)
      (did-not-ran #t)
      (exception-throwed #f))

  (catch-any
   (lambda _
     (monadic (monad-except)
              [a (+ 2 7)]
              [o (+ (a) (a))]
              [b (raisu 'test-abort)]
              [p "after kek" 'always]
              [q "this should not get a value"]
              [r (set! ran-always #t) 'always]
              [k (set! did-not-ran #f)]
              [c (- (b) (b))]
              [r (+ 100 (c))]
              )
     (set! throwed #f))
   (lambda errs
     (set! exception-throwed #t)))

  (assert exception-throwed)
  (assert ran-always)
  (assert did-not-ran)
  (assert throwed))

;; list-fold
(let ()
  (assert=
   10
   (list-fold
    (acc 0)
    (cur '(1 2 3 4))
    (+ acc cur)))

  (assert=
   '(10 48)
   (call-with-values
       (lambda _
         (list-fold
          ((acc1 acc2) (values 0 2))
          (cur '(1 2 3 4))
          (values (+ acc1 cur) (* acc2 cur))))
     (lambda x x)))

  )

;; list-blocks
(let ()

  (assert=
   '((1 2) (3 4) (5 6))
   (list-blocks 2 '(1 2 3 4 5 6)))

  (assert=
   '((1) (2) (3) (4) (5) (6))
   (list-blocks 1 '(1 2 3 4 5 6)))

  (assert=
   '()
   (list-blocks 2 '()))

  )

;; list-blocks
(let ()

  (assert=
   '((1 2) (3 4) (5 6))
   (list-blocks 2 '(1 2 3 4 5 6)))

  (assert=
   '((1) (2) (3) (4) (5) (6))
   (list-blocks 1 '(1 2 3 4 5 6)))

  (assert=
   '()
   (list-blocks 2 '()))

  )

;; list-windows
(let ()

  (assert=
   '((1 2) (2 3) (3 4) (4 5) (5 6))
   (list-windows 2 '(1 2 3 4 5 6)))

  (assert=
   '((1 2 3) (2 3 4) (3 4 5) (4 5 6))
   (list-windows 3 '(1 2 3 4 5 6)))

  (assert=
   '(6 9 12 15)
   (map (comp (apply +)) (list-windows 3 '(1 2 3 4 5 6))))

  (assert=
   '((1 2 3))
   (list-windows 3 '(1 2 3)))

  (assert=
   '((1) (2) (3))
   (list-windows 1 '(1 2 3)))

  )

;; list-length=<?
(let ()

  (assert (list-length=<? 3 '(1 2 3 4 5 6)))
  (assert (list-length=<? 3 '(1 2 3)))
  (assert (not (list-length=<? 3 '(1 2))))
  (assert (list-length=<? 0 '()))
  (assert (list-length=<? -3 '(1 2)))
  (assert (list-length=<? -3 '()))

  )

(display "All good\n")

