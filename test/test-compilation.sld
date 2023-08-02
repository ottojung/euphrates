
(define-library
  (test-compilation)
  (import
    (only (euphrates absolute-posix-path-q)
          absolute-posix-path?))
  (import
    (only (euphrates
            alist-initialize-bang-current-setter-p)
          alist-initialize!:current-setter/p))
  (import
    (only (euphrates alist-initialize-bang-p)
          alist-initialize!/p))
  (import
    (only (euphrates alist-initialize-bang)
          alist-initialize!
          alist-initialize!:current-setters
          alist-initialize!:get-setters
          alist-initialize!:makelet/static
          alist-initialize!:return-multiple
          alist-initialize!:run
          alist-initialize!:stop))
  (import
    (only (euphrates alist-initialize-loop)
          alist-initialize-loop))
  (import
    (only (euphrates alpha-alphabet) alpha/alphabet))
  (import
    (only (euphrates alpha-lowercase-alphabet)
          alpha-lowercase/alphabet))
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet
          alphanum/alphabet/index))
  (import
    (only (euphrates alphanum-lowercase-alphabet)
          alphanum-lowercase/alphabet))
  (import
    (only (euphrates append-posix-path)
          append-posix-path))
  (import
    (only (euphrates append-string-file)
          append-string-file))
  (import
    (only (euphrates assert-called-once)
          assert-called-once
          with-called-once-extent))
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert-raw) assert/raw))
  (import (only (euphrates assert) assert))
  (import (only (euphrates assoc-any) assoc/any))
  (import (only (euphrates assoc-find) assoc/find))
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates assoc-set-default)
          assoc-set-default))
  (import
    (only (euphrates assoc-set-value)
          assoc-set-value))
  (import (only (euphrates assq-or-star) assq-or*))
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-default)
          assq-set-default))
  (import
    (only (euphrates assq-set-value-star)
          assq-set-value*))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates asyncproc-input-text-p)
          asyncproc-input-text/p))
  (import
    (only (euphrates asyncproc-stderr)
          asyncproc-stderr))
  (import
    (only (euphrates asyncproc-stdout)
          asyncproc-stdout))
  (import
    (only (euphrates asyncproc)
          asyncproc
          asyncproc-args
          asyncproc-command
          asyncproc-exited?
          asyncproc-pid
          asyncproc-pipe
          asyncproc-status
          asyncproc?
          set-asyncproc-exited?!
          set-asyncproc-pid!
          set-asyncproc-pipe!
          set-asyncproc-status!))
  (import
    (only (euphrates atomic-box)
          atomic-box-compare-and-set!
          atomic-box-ref
          atomic-box-set!
          atomic-box?
          make-atomic-box))
  (import
    (only (euphrates base64-alphabet-minusunderscore)
          base64/alphabet/minusunderscore))
  (import
    (only (euphrates base64-alphabet-pluscomma)
          base64/alphabet/pluscomma))
  (import
    (only (euphrates base64-alphabet)
          base64/alphabet))
  (import
    (only (euphrates big-random-int) big-random-int))
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result))
  (import
    (only (euphrates box)
          box-ref
          box-set!
          box?
          make-box))
  (import
    (only (euphrates builtin-descriptors)
          builtin-descriptors))
  (import
    (only (euphrates builtin-type-huh) builtin-type?))
  (import
    (only (euphrates call-with-finally)
          call-with-finally))
  (import
    (only (euphrates call-with-input-string)
          call-with-input-string))
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import
    (only (euphrates cartesian-any-q) cartesian-any?))
  (import
    (only (euphrates cartesian-each) cartesian-each))
  (import
    (only (euphrates cartesian-map) cartesian-map))
  (import
    (only (euphrates cartesian-product-g)
          cartesian-product/g
          cartesian-product/g/reversed))
  (import
    (only (euphrates cartesian-product)
          cartesian-product))
  (import (only (euphrates caseq) caseq))
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates catch-specific) catch-specific))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import (only (euphrates cfg-inline) CFG-inline))
  (import
    (only (euphrates cfg-machine)
          make-cfg-machine
          make-cfg-machine*
          make-cfg-machine/full))
  (import
    (only (euphrates cfg-parse-modifiers)
          CFG-parse-modifiers))
  (import
    (only (euphrates cfg-remove-dead-code)
          CFG-remove-dead-code))
  (import
    (only (euphrates cfg-strip-modifiers)
          CFG-strip-modifiers))
  (import
    (only (euphrates chibi-parser)
          char-hex-digit?
          char-octal-digit?
          define-grammar
          parse
          parse-binary-op
          parse-c-integer
          parse-common-domain
          parse-complex
          parse-delimited
          parse-domain
          parse-email
          parse-fully
          parse-identifier
          parse-integer
          parse-ip-address
          parse-ipv4-address
          parse-ipv6-address
          parse-real
          parse-records
          parse-separated
          parse-space
          parse-unsigned-integer
          parse-uri))
  (import (only (euphrates clamp) clamp))
  (import
    (only (euphrates command-line-arguments-p)
          command-line-argumets/p))
  (import (only (euphrates comp) appcomp comp))
  (import
    (only (euphrates compile-cfg-cli-help)
          CFG-AST->CFG-CLI-help))
  (import
    (only (euphrates compile-cfg-cli)
          CFG-AST->CFG-lang
          CFG-CLI->CFG-lang
          CFG-lang-modifier-char?))
  (import
    (only (euphrates compile-regex-cli)
          compile-regex-cli:IR->Regex
          compile-regex-cli:make-IR))
  (import
    (only (euphrates compose-under-par)
          compose-under-par))
  (import
    (only (euphrates compose-under-seq)
          compose-under-seq))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates compose) compose))
  (import (only (euphrates cons-bang) cons!))
  (import (only (euphrates conss) conss))
  (import (only (euphrates const) const))
  (import
    (only (euphrates convert-number-base)
          convert-number-base
          convert-number-base/generic
          convert-number-base:default-max-base))
  (import
    (only (euphrates current-directory-p)
          current-directory/p))
  (import
    (only (euphrates current-program-path-p)
          current-program-path/p))
  (import
    (only (euphrates current-random-source-p)
          current-random-source/p))
  (import
    (only (euphrates current-source-info-to-string)
          current-source-info->string))
  (import (only (euphrates curry-if) curry-if))
  (import
    (only (euphrates date-get-current-string)
          date-get-current-string))
  (import
    (only (euphrates date-get-current-time24h-string)
          date-get-current-time24h-string))
  (import (only (euphrates debug) debug))
  (import (only (euphrates debugs) debugs))
  (import (only (euphrates debugv) debugv))
  (import
    (only (euphrates define-cli)
          define-cli:raisu/default-exit
          define-cli:raisu/p
          define-cli:show-help
          lambda-cli
          make-cli
          make-cli-with-handler
          make-cli/f
          make-cli/f/basic
          with-cli))
  (import
    (only (euphrates define-dumb-record)
          define-dumb-record))
  (import
    (only (euphrates define-newtype) define-newtype))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates define-type9)
          define-type9
          define-type9/nobind-descriptor
          type9-get-descriptor-by-name
          type9-get-record-descriptor))
  (import
    (only (euphrates descriptors-registry)
          descriptors-registry-add!
          descriptors-registry-decolisify-name
          descriptors-registry-get))
  (import
    (only (euphrates directory-files-depth-foreach)
          directory-files-depth-foreach))
  (import
    (only (euphrates directory-files-depth-iter)
          directory-files-depth-iter))
  (import
    (only (euphrates directory-files-rec)
          directory-files-rec))
  (import
    (only (euphrates directory-files)
          directory-files))
  (import
    (only (euphrates directory-mtime-state)
          directory-mtime-state))
  (import
    (only (euphrates directory-tree) directory-tree))
  (import
    (only (euphrates dprint-p-default)
          dprint/p-default))
  (import (only (euphrates dprint-p) dprint/p))
  (import (only (euphrates dprint) dprint))
  (import (only (euphrates dprintln) dprintln))
  (import
    (only (euphrates dynamic-load) dynamic-load))
  (import
    (only (euphrates dynamic-thread-async-thunk)
          dynamic-thread-async-thunk))
  (import
    (only (euphrates dynamic-thread-async)
          dynamic-thread-async))
  (import
    (only (euphrates dynamic-thread-cancel-p)
          dynamic-thread-cancel/p))
  (import
    (only (euphrates dynamic-thread-cancel-tag)
          dynamic-thread-cancel-tag))
  (import
    (only (euphrates dynamic-thread-cancel)
          dynamic-thread-cancel))
  (import
    (only (euphrates
            dynamic-thread-critical-make-p-default)
          dynamic-thread-critical-make/p-default))
  (import
    (only (euphrates dynamic-thread-critical-make-p)
          dynamic-thread-critical-make/p))
  (import
    (only (euphrates dynamic-thread-critical-make)
          dynamic-thread-critical-make))
  (import
    (only (euphrates
            dynamic-thread-disable-cancel-p-default)
          dynamic-thread-disable-cancel/p-default))
  (import
    (only (euphrates dynamic-thread-disable-cancel-p)
          dynamic-thread-disable-cancel/p))
  (import
    (only (euphrates dynamic-thread-disable-cancel)
          dynamic-thread-disable-cancel))
  (import
    (only (euphrates
            dynamic-thread-enable-cancel-p-default)
          dynamic-thread-enable-cancel/p-default))
  (import
    (only (euphrates dynamic-thread-enable-cancel-p)
          dynamic-thread-enable-cancel/p))
  (import
    (only (euphrates dynamic-thread-enable-cancel)
          dynamic-thread-enable-cancel))
  (import
    (only (euphrates
            dynamic-thread-get-delay-procedure-p-default)
          dynamic-thread-get-delay-procedure/p-default))
  (import
    (only (euphrates dynamic-thread-get-delay-procedure-p)
          dynamic-thread-get-delay-procedure/p))
  (import
    (only (euphrates dynamic-thread-get-delay-procedure)
          dynamic-thread-get-delay-procedure))
  (import
    (only (euphrates dynamic-thread-get-wait-delay)
          dynamic-thread-get-wait-delay))
  (import
    (only (euphrates dynamic-thread-get-yield-procedure)
          dynamic-thread-get-yield-procedure))
  (import
    (only (euphrates dynamic-thread-mutex-lock-p-default)
          dynamic-thread-mutex-lock!/p-default))
  (import
    (only (euphrates dynamic-thread-mutex-lock-p)
          dynamic-thread-mutex-lock!/p))
  (import
    (only (euphrates dynamic-thread-mutex-lock)
          dynamic-thread-mutex-lock!))
  (import
    (only (euphrates dynamic-thread-mutex-make-p-default)
          dynamic-thread-mutex-make/p-default))
  (import
    (only (euphrates dynamic-thread-mutex-make-p)
          dynamic-thread-mutex-make/p))
  (import
    (only (euphrates dynamic-thread-mutex-make)
          dynamic-thread-mutex-make))
  (import
    (only (euphrates dynamic-thread-mutex-unlock-p-default)
          dynamic-thread-mutex-unlock!/p-default))
  (import
    (only (euphrates dynamic-thread-mutex-unlock-p)
          dynamic-thread-mutex-unlock!/p))
  (import
    (only (euphrates dynamic-thread-mutex-unlock)
          dynamic-thread-mutex-unlock!))
  (import
    (only (euphrates dynamic-thread-sleep-p-default)
          dynamic-thread-sleep/p-default))
  (import
    (only (euphrates dynamic-thread-sleep-p)
          dynamic-thread-sleep/p))
  (import
    (only (euphrates dynamic-thread-sleep)
          dynamic-thread-sleep))
  (import
    (only (euphrates dynamic-thread-spawn-p)
          dynamic-thread-spawn/p))
  (import
    (only (euphrates dynamic-thread-spawn)
          dynamic-thread-spawn))
  (import
    (only (euphrates dynamic-thread-wait-delay-p-default)
          dynamic-thread-wait-delay/us/p-default))
  (import
    (only (euphrates dynamic-thread-wait-delay-p)
          dynamic-thread-wait-delay/us/p))
  (import
    (only (euphrates dynamic-thread-yield-p-default)
          dynamic-thread-yield/p-default))
  (import
    (only (euphrates dynamic-thread-yield-p)
          dynamic-thread-yield/p))
  (import
    (only (euphrates dynamic-thread-yield)
          dynamic-thread-yield))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates eval-in-current-namespace)
          eval-in-current-namespace))
  (import
    (only (euphrates exception-monad)
          exception-monad))
  (import
    (only (euphrates fast-parameterizeable-timestamp-p)
          fast-parameterizeable-timestamp/p))
  (import
    (only (euphrates file-delete) file-delete))
  (import
    (only (euphrates file-is-directory-q-no-readlink)
          file-is-directory?/no-readlink))
  (import
    (only (euphrates file-is-regular-file-q-no-readlink)
          file-is-regular-file?/no-readlink))
  (import (only (euphrates file-mtime) file-mtime))
  (import
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?))
  (import (only (euphrates file-size) file-size))
  (import
    (only (euphrates filter-monad) filter-monad))
  (import (only (euphrates fn-alist) fn-alist))
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates fn-pair) fn-pair))
  (import (only (euphrates fn-tuple) fn-tuple))
  (import (only (euphrates fn) fn))
  (import (only (euphrates fp) fp))
  (import
    (only (euphrates general-table) general-table))
  (import
    (only (euphrates get-command-line-arguments)
          get-command-line-arguments))
  (import
    (only (euphrates get-current-directory)
          get-current-directory))
  (import
    (only (euphrates get-current-program-path)
          get-current-program-path))
  (import
    (only (euphrates get-current-random-source)
          get-current-random-source))
  (import
    (only (euphrates get-current-source-file-path)
          get-current-source-file-path))
  (import
    (only (euphrates get-current-source-info)
          get-current-source-info))
  (import
    (only (euphrates get-directory-name)
          get-directory-name))
  (import
    (only (euphrates get-object-descriptor)
          get-object-descriptor))
  (import
    (only (euphrates global-debug-mode-filter)
          global-debug-mode-filter))
  (import
    (only (euphrates group-by-sequential)
          group-by/sequential
          group-by/sequential*))
  (import
    (only (euphrates hashmap-obj)
          hashmap-constructor
          hashmap-predicate))
  (import
    (only (euphrates hashmap)
          alist->hashmap
          hashmap->alist
          hashmap-clear!
          hashmap-copy
          hashmap-count
          hashmap-delete!
          hashmap-foreach
          hashmap-has?
          hashmap-map
          hashmap-merge
          hashmap-merge!
          hashmap-ref
          hashmap-set!
          hashmap?
          make-hashmap
          multi-alist->hashmap))
  (import
    (only (euphrates hashset-obj)
          hashset-constructor
          hashset-predicate
          hashset-value))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-clear!
          hashset-delete!
          hashset-difference
          hashset-equal?
          hashset-foreach
          hashset-has?
          hashset-intersection
          hashset-length
          hashset-map
          hashset-ref
          hashset-union
          list->hashset
          make-hashset
          vector->hashset))
  (import
    (only (euphrates identity-monad) identity-monad))
  (import
    (only (euphrates identity-star) identity*))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates immutable-hashmap-obj)
          immutable-hashmap-constructor
          immutable-hashmap-predicate
          immutable-hashmap-value))
  (import
    (only (euphrates immutable-hashmap)
          alist->immutable-hashmap
          immutable-hashmap->alist
          immutable-hashmap-clear
          immutable-hashmap-copy
          immutable-hashmap-count
          immutable-hashmap-foreach
          immutable-hashmap-fromlist
          immutable-hashmap-map
          immutable-hashmap-ref
          immutable-hashmap-ref/first
          immutable-hashmap-set
          immutable-hashmap?
          make-immutable-hashmap))
  (import
    (only (euphrates irregex)
          irregex
          irregex-dfa
          irregex-dfa/search
          irregex-extract
          irregex-flags
          irregex-fold
          irregex-lengths
          irregex-match
          irregex-match-data?
          irregex-match-end-chunk
          irregex-match-end-index
          irregex-match-names
          irregex-match-num-submatches
          irregex-match-start-chunk
          irregex-match-start-index
          irregex-match-subchunk
          irregex-match-substring
          irregex-match-valid-index?
          irregex-match/chunked
          irregex-names
          irregex-new-matches
          irregex-nfa
          irregex-num-submatches
          irregex-replace
          irregex-replace/all
          irregex-reset-matches!
          irregex-search
          irregex-search/chunked
          irregex-search/matches
          irregex-split
          irregex?
          make-irregex-chunker
          maybe-string->sre
          sre->irregex
          string->irregex
          string->sre))
  (import (only (euphrates json-parse) json-parse))
  (import
    (only (euphrates key-value-map)
          key-value-map
          key-value-map/list))
  (import (only (euphrates lazy-monad) lazy-monad))
  (import
    (only (euphrates lazy-parameter) lazy-parameter))
  (import (only (euphrates letin) letin))
  (import
    (only (euphrates lexical-scope-obj)
          lexical-scope-unwrap
          lexical-scope-wrap
          lexical-scope?))
  (import
    (only (euphrates lexical-scope)
          lexical-scope-make
          lexical-scope-namespace
          lexical-scope-ref
          lexical-scope-set!
          lexical-scope-stage!
          lexical-scope-unstage!))
  (import
    (only (euphrates linear-interpolation)
          linear-interpolate-1d
          linear-interpolate-2d))
  (import
    (only (euphrates linear-regression)
          linear-regression))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import
    (only (euphrates linux-get-memory-stat)
          linux-get-memory-free%
          linux-get-memory-stat))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import (only (euphrates list-break) list-break))
  (import
    (only (euphrates list-chunks) list-chunks))
  (import
    (only (euphrates list-combinations)
          list-combinations))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate
          list-deduplicate/reverse))
  (import
    (only (euphrates list-drop-n) list-drop-n))
  (import
    (only (euphrates list-drop-while)
          list-drop-while))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (euphrates list-fold-star) list-fold*))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (euphrates list-get-duplicates)
          list-get-duplicates))
  (import
    (only (euphrates list-group-by) list-group-by))
  (import (only (euphrates list-init) list-init))
  (import
    (only (euphrates list-insert-at) list-insert-at))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import (only (euphrates list-last) list-last))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-length-geq-q)
          list-length=<?))
  (import
    (only (euphrates list-levenshtein-distance)
          list-levenshtein-distance))
  (import
    (only (euphrates list-map-first) list-map-first))
  (import
    (only (euphrates list-map-flatten)
          list-map/flatten))
  (import
    (only (euphrates list-maximal-element-or-proj)
          list-maximal-element-or/proj))
  (import
    (only (euphrates list-maximal-element-or)
          list-maximal-element-or))
  (import
    (only (euphrates list-minimal-element-or-proj)
          list-minimal-element-or/proj))
  (import
    (only (euphrates list-minimal-element-or)
          list-minimal-element-or))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates list-partition) list-partition))
  (import
    (only (euphrates list-permutations)
          list-permutations))
  (import
    (only (euphrates list-prefix-q) list-prefix?))
  (import
    (only (euphrates list-random-element)
          list-random-element))
  (import
    (only (euphrates list-random-shuffle)
          list-random-shuffle))
  (import
    (only (euphrates list-ref-or) list-ref-or))
  (import
    (only (euphrates list-remove-common-prefix)
          list-remove-common-prefix))
  (import
    (only (euphrates list-replace-last)
          list-replace-last))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (euphrates list-span-n) list-span-n))
  (import
    (only (euphrates list-span-while)
          list-span-while))
  (import (only (euphrates list-span) list-span))
  (import
    (only (euphrates list-split-on) list-split-on))
  (import
    (only (euphrates list-tag-next)
          list-tag/next
          list-tag/next/rev
          list-untag/next))
  (import
    (only (euphrates list-tag-prev)
          list-tag/prev
          list-tag/prev/rev))
  (import
    (only (euphrates list-tag) list-tag list-untag))
  (import
    (only (euphrates list-take-n) list-take-n))
  (import
    (only (euphrates list-take-while)
          list-take-while))
  (import
    (only (euphrates list-to-tree) list->tree))
  (import
    (only (euphrates list-traverse) list-traverse))
  (import
    (only (euphrates list-windows) list-windows))
  (import
    (only (euphrates list-zip-longest)
          list-zip-longest))
  (import
    (only (euphrates list-zip-with-longest)
          list-zip-with-longest))
  (import
    (only (euphrates list-zip-with) list-zip-with))
  (import (only (euphrates list-zip) list-zip))
  (import (only (euphrates log-monad) log-monad))
  (import
    (only (euphrates make-directories)
          make-directories))
  (import
    (only (euphrates make-temporary-filename)
          make-temporary-filename))
  (import
    (only (euphrates make-temporary-fileport)
          make-temporary-fileport))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (euphrates maybe-monad) maybe-monad))
  (import (only (euphrates md5) md5-digest))
  (import
    (only (euphrates mdict)
          ahash->mdict
          hash->mdict
          mdict
          mdict->alist
          mdict-has?
          mdict-keys
          mdict-set!))
  (import (only (euphrates memconst) memconst))
  (import
    (only (euphrates mimetype-extensions)
          mimetype/extensions))
  (import
    (only (euphrates monad-apply) monad-apply))
  (import (only (euphrates monad-ask) monad-ask))
  (import (only (euphrates monad-bind) monad-bind))
  (import
    (only (euphrates monad-compose) monad-compose))
  (import
    (only (euphrates monad-current-p)
          monad-current/p))
  (import
    (only (euphrates monad-do)
          monad-do
          monad-do/generic))
  (import
    (only (euphrates monad-make-hook)
          monad-make/hook))
  (import
    (only (euphrates monad-make-no-cont-no-fin)
          monad-make/no-cont/no-fin))
  (import
    (only (euphrates monad-make-no-cont)
          monad-make/no-cont))
  (import
    (only (euphrates monad-make-no-fin)
          monad-make/no-fin))
  (import (only (euphrates monad-make) monad-make))
  (import
    (only (euphrates monad-parameterize)
          monad-parameterize
          with-monad-left
          with-monad-right))
  (import
    (only (euphrates monad-transformer-current-p)
          monad-transformer-current/p))
  (import
    (only (euphrates monadfinobj)
          monadfinobj
          monadfinobj-lval
          monadfinobj?))
  (import (only (euphrates monadic-id) monadic-id))
  (import
    (only (euphrates monadic) monadic monadic-bare))
  (import
    (only (euphrates monadobj)
          monadobj-constructor
          monadobj-handles-fin?
          monadobj-procedure
          monadobj-uses-continuations?
          monadobj?))
  (import
    (only (euphrates monadstate-current-p)
          monadstate-current/p))
  (import
    (only (euphrates monadstate)
          monadstate-arg
          monadstate-args
          monadstate-cret
          monadstate-cret/thunk
          monadstate-handle-multiple
          monadstate-lval
          monadstate-make-empty
          monadstate-qtags
          monadstate-qval
          monadstate-qvar
          monadstate-replicate-multiple
          monadstate-ret
          monadstate-ret/thunk
          monadstate?))
  (import
    (only (euphrates monadstateobj)
          monadstateobj
          monadstateobj-cont
          monadstateobj-lval
          monadstateobj-qtags
          monadstateobj-qval
          monadstateobj-qvar
          monadstateobj?))
  (import
    (only (euphrates multiset-obj)
          multiset-constructor
          multiset-predicate
          multiset-value))
  (import
    (only (euphrates multiset)
          list->multiset
          make-multiset
          multiset->list
          multiset-add!
          multiset-equal?
          multiset-filter
          multiset-ref
          multiset?
          vector->multiset))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates node-directed-obj)
          node/directed
          node/directed-children
          node/directed-label
          node/directed?
          set-node/directed-children!
          set-node/directed-label!))
  (import
    (only (euphrates node-directed)
          make-node/directed))
  (import
    (only (euphrates np-thread-obj)
          np-thread-obj
          np-thread-obj-cancel-enabled?
          np-thread-obj-cancel-scheduled?
          np-thread-obj-continuation
          np-thread-obj?
          set-np-thread-obj-cancel-enabled?!
          set-np-thread-obj-cancel-scheduled?!
          set-np-thread-obj-continuation!))
  (import
    (only (euphrates np-thread-parameterize)
          np-thread-parameterize-env
          with-np-thread-env/non-interruptible))
  (import
    (only (euphrates np-thread)
          np-thread-global-cancel
          np-thread-global-critical-make
          np-thread-global-disable-cancel
          np-thread-global-enable-cancel
          np-thread-global-mutex-lock!
          np-thread-global-mutex-make
          np-thread-global-mutex-unlock!
          np-thread-global-sleep
          np-thread-global-spawn
          np-thread-global-yield
          np-thread-make-env))
  (import
    (only (euphrates number-list)
          number->number-list
          number->number-list:precision/p
          number-list->number
          number-list->number-list))
  (import
    (only (euphrates open-cond-obj)
          open-cond-constructor
          open-cond-predicate
          open-cond-value
          set-open-cond-value!))
  (import
    (only (euphrates open-cond)
          define-open-cond
          define-open-cond-instance
          open-cond-lambda
          open-cond?))
  (import
    (only (euphrates open-file-port) open-file-port))
  (import
    (only (euphrates package)
          make-package
          make-static-package
          use-svars
          with-package
          with-svars))
  (import
    (only (euphrates parse-cfg-cli) CFG-CLI->CFG-AST))
  (import
    (only (euphrates partial-apply) partial-apply))
  (import
    (only (euphrates partial-apply1) partial-apply1))
  (import
    (only (euphrates path-extension) path-extension))
  (import
    (only (euphrates path-extensions)
          path-extensions))
  (import
    (only (euphrates path-get-basename)
          path-get-basename))
  (import
    (only (euphrates path-get-dirname)
          path-get-dirname))
  (import
    (only (euphrates path-normalize) path-normalize))
  (import
    (only (euphrates path-replace-extension)
          path-replace-extension))
  (import
    (only (euphrates path-without-extension)
          path-without-extension))
  (import
    (only (euphrates path-without-extensions)
          path-without-extensions))
  (import
    (only (euphrates petri-error-handling)
          patri-handle-make-callback
          petri-handle-get))
  (import
    (only (euphrates petri-net-make) petri-net-make))
  (import
    (only (euphrates petri-net-obj)
          petri-net-obj
          petri-net-obj-critical
          petri-net-obj-finished?
          petri-net-obj-queue
          petri-net-obj-transitions
          petri-net-obj?
          set-petri-net-obj-finished?!))
  (import
    (only (euphrates petri-net-parse-profun)
          petri-profun-net))
  (import
    (only (euphrates petri-net-parse)
          petri-lambda-net
          petri-net-parse))
  (import
    (only (euphrates petri) petri-push petri-run))
  (import
    (only (euphrates prefixtree-obj)
          prefixtree
          prefixtree-children
          prefixtree-value
          prefixtree?
          set-prefixtree-children!
          set-prefixtree-value!))
  (import
    (only (euphrates prefixtree)
          make-prefixtree
          prefixtree->tree
          prefixtree-ref
          prefixtree-ref-closest
          prefixtree-ref-furthest
          prefixtree-set!))
  (import
    (only (euphrates print-in-frame) print-in-frame))
  (import
    (only (euphrates print-in-window)
          print-in-window))
  (import
    (only (euphrates printable-alphabet)
          printable/alphabet))
  (import
    (only (euphrates printable-stable-alphabet)
          printable/stable/alphabet))
  (import
    (only (euphrates printf-threadsafe)
          printf/threadsafe))
  (import (only (euphrates printf) printf))
  (import
    (only (euphrates profun-CR)
          make-profun-CR
          profun-CR-what
          profun-CR?))
  (import
    (only (euphrates profun-IDR)
          make-profun-IDR
          profun-IDR-arity
          profun-IDR-name
          profun-IDR?))
  (import
    (only (euphrates profun-RFC)
          make-profun-RFC
          profun-RFC-add-info
          profun-RFC-insert
          profun-RFC-modify-iter
          profun-RFC-reset
          profun-RFC-set-iter
          profun-RFC-what
          profun-RFC?))
  (import
    (only (euphrates profun-abort)
          make-profun-abort
          profun-abort-add-info
          profun-abort-additional
          profun-abort-iter
          profun-abort-modify-iter
          profun-abort-set-iter
          profun-abort-type
          profun-abort-what
          profun-abort?))
  (import
    (only (euphrates profun-accept)
          make-profun-accept
          profun-accept
          profun-accept-alist
          profun-accept-ctx
          profun-accept-ctx-changed?
          profun-accept?
          profun-ctx-set
          profun-set
          profun-set-meta
          profun-set-parameter))
  (import
    (only (euphrates profun-answer-huh)
          profun-answer?))
  (import
    (only (euphrates profun-answer-join)
          profun-answer-join/and
          profun-answer-join/any
          profun-answer-join/or))
  (import
    (only (euphrates profun-current-env-p)
          profun-current-env/p))
  (import
    (only (euphrates profun-database)
          make-falsy-profun-database
          make-profun-database
          profun-database-copy
          profun-database-extend
          profun-database-falsy?
          profun-database-get
          profun-database-get-all
          profun-database-handle
          profun-database-handler
          profun-database-rules
          profun-database?))
  (import
    (only (euphrates profun-default) profun-default))
  (import
    (only (euphrates profun-env)
          make-profun-env
          profun-env-copy
          profun-env-get
          profun-env-set!
          profun-env-unset!))
  (import
    (only (euphrates profun-error)
          make-profun-error
          profun-error-args
          profun-error?))
  (import
    (only (euphrates profun-eval-query-terms)
          profun-eval-query/terms))
  (import
    (only (euphrates profun-handler)
          profun-handler-extend
          profun-handler-get
          profun-make-handler))
  (import
    (only (euphrates profun-instruction)
          profun-instruction-args
          profun-instruction-arity
          profun-instruction-body
          profun-instruction-build
          profun-instruction-build/next
          profun-instruction-constructor
          profun-instruction-context
          profun-instruction-name
          profun-instruction-next
          profun-instruction?))
  (import
    (only (euphrates profun-iterator)
          profun-abort-insert
          profun-abort-reset
          profun-iterator-constructor
          profun-iterator-copy
          profun-iterator-db
          profun-iterator-env
          profun-iterator-insert!
          profun-iterator-query
          profun-iterator-reset!
          profun-iterator-state
          set-profun-iterator-query!
          set-profun-iterator-state!))
  (import
    (only (euphrates profun-make-instantiation-test)
          profun-make-instantiation-check))
  (import
    (only (euphrates profun-make-set)
          profun-make-set))
  (import
    (only (euphrates profun-make-tuple-set)
          profun-make-tuple-set))
  (import
    (only (euphrates profun-meta-key)
          profun-meta-key))
  (import
    (only (euphrates profun-next-term-group)
          profun-next/term-group))
  (import
    (only (euphrates profun-op-apply-result-p)
          profun-op-apply/result/p))
  (import
    (only (euphrates profun-op-apply)
          profun-apply-fail!
          profun-apply-return!
          profun-op-apply))
  (import
    (only (euphrates profun-op-binary)
          profun-op-binary))
  (import
    (only (euphrates profun-op-divisible)
          profun-op-divisible))
  (import
    (only (euphrates profun-op-envlambda)
          profun-op-envlambda))
  (import
    (only (euphrates profun-op-equals)
          profun-op-equals))
  (import
    (only (euphrates profun-op-eval-result-p)
          profun-op-eval/result/p))
  (import
    (only (euphrates profun-op-eval)
          profun-eval-fail!
          profun-eval-return!
          profun-op-eval))
  (import
    (only (euphrates profun-op-false)
          profun-op-false))
  (import
    (only (euphrates profun-op-function)
          profun-op-function))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-op-less) profun-op-less))
  (import
    (only (euphrates profun-op-modulo)
          profun-op-modulo))
  (import
    (only (euphrates profun-op-mult) profun-op*))
  (import
    (only (euphrates profun-op-obj)
          profun-op-arity
          profun-op-constructor
          profun-op-procedure
          profun-op?))
  (import
    (only (euphrates profun-op-parameter)
          instantiate-profun-parameter
          make-profun-parameter))
  (import
    (only (euphrates profun-op-plus) profun-op+))
  (import
    (only (euphrates profun-op-print)
          profun-op-print))
  (import
    (only (euphrates profun-op-separate)
          profun-op-separate))
  (import
    (only (euphrates profun-op-sqrt) profun-op-sqrt))
  (import
    (only (euphrates profun-op-true) profun-op-true))
  (import
    (only (euphrates profun-op-unary)
          profun-op-unary))
  (import
    (only (euphrates profun-op-unify)
          profun-op-unify))
  (import
    (only (euphrates profun-op-value)
          profun-op-value))
  (import
    (only (euphrates profun-op) make-profun-op))
  (import
    (only (euphrates profun-query-get-free-variables)
          profun-query-get-free-variables))
  (import
    (only (euphrates profun-query-handle-underscores)
          profun-query-handle-underscores))
  (import
    (only (euphrates profun-reject)
          profun-reject
          profun-reject?))
  (import
    (only (euphrates profun-request-value)
          profun-request-value))
  (import
    (only (euphrates profun-rule)
          profun-rule-args
          profun-rule-body
          profun-rule-constructor
          profun-rule-index
          profun-rule-name
          profun-rule?))
  (import
    (only (euphrates profun-standard-handler)
          profun-standard-handler))
  (import
    (only (euphrates profun-state)
          profun-state-build
          profun-state-constructor
          profun-state-current
          profun-state-failstate
          profun-state-final?
          profun-state-finish
          profun-state-make
          profun-state-stack
          profun-state-undo
          profun-state?
          set-profun-state-current))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-make-constant
          profun-make-unbound-var
          profun-make-var
          profun-unbound-value?
          profun-value-name
          profun-value-unwrap
          profun-value?))
  (import
    (only (euphrates profun-variable-arity-op-huh)
          profun-variable-arity-op?))
  (import
    (only (euphrates profun-variable-arity-op-keyword)
          profun-variable-arity-op-keyword))
  (import
    (only (euphrates profun-variable-arity-op)
          profun-variable-arity-op))
  (import
    (only (euphrates profun-variable-equal-q)
          profun-variable-equal?))
  (import
    (only (euphrates profun-varname-q)
          profun-varname?))
  (import
    (only (euphrates profun)
          profun-create-database
          profun-create-falsy-database
          profun-eval-from
          profun-eval-from/generic
          profun-eval-query
          profun-eval-query/boolean
          profun-iterate
          profun-next
          profun-next/boolean))
  (import
    (only (euphrates profune-communications-hook-p)
          profune-communications-hook/p))
  (import
    (only (euphrates profune-communications)
          profune-communications))
  (import
    (only (euphrates profune-communicator)
          make-profune-communicator
          profune-communicator-db
          profune-communicator-handle
          profune-communicator?))
  (import
    (only (euphrates properties)
          define-property
          define-provider
          get-property
          make-property
          make-provider
          make-provider/general
          outdate-property!
          property-evaluatable?
          set-property!
          unset-property!
          with-properties))
  (import
    (only (euphrates queue-obj)
          queue-constructor
          queue-first
          queue-last
          queue-predicate
          queue-vector
          set-queue-first!
          set-queue-last!
          set-queue-vector!))
  (import
    (only (euphrates queue)
          list->queue
          make-queue
          queue->list
          queue-empty?
          queue-peek
          queue-peek-rotate!
          queue-pop!
          queue-push!
          queue-rotate!
          queue-unload!
          queue?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates random-choice) random-choice))
  (import
    (only (euphrates random-variable-name)
          random-variable-name))
  (import (only (euphrates range) range))
  (import
    (only (euphrates read-all-port) read-all-port))
  (import (only (euphrates read-lines) read/lines))
  (import (only (euphrates read-list) read-list))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import
    (only (euphrates read-string-line)
          read-string-line))
  (import
    (only (euphrates regex-machine)
          make-regex-machine
          make-regex-machine*
          make-regex-machine/full))
  (import
    (only (euphrates remove-common-prefix)
          remove-common-prefix))
  (import
    (only (euphrates replacement-monad)
          replacement-monad))
  (import (only (euphrates replicate) replicate))
  (import
    (only (euphrates reversed-args-f)
          reversed-args-f))
  (import
    (only (euphrates reversed-args) reversed-args))
  (import
    (only (euphrates rtree)
          rtree
          rtree-children
          rtree-ref
          rtree-value
          rtree?
          set-rtree-children!
          set-rtree-ref!))
  (import
    (only (euphrates run-asyncproc-p-default)
          run-asyncproc/p-default))
  (import
    (only (euphrates run-asyncproc-p)
          run-asyncproc/p))
  (import
    (only (euphrates run-asyncproc) run-asyncproc))
  (import
    (only (euphrates run-syncproc-re-star)
          run-syncproc/re*))
  (import
    (only (euphrates run-syncproc-re)
          run-syncproc/re))
  (import
    (only (euphrates run-syncproc-star)
          run-syncproc*))
  (import
    (only (euphrates run-syncproc) run-syncproc))
  (import
    (only (euphrates seconds-to-string-columned)
          seconds->string-columned))
  (import
    (only (euphrates serialization-builtin-natural)
          deserialize-builtin/natural
          serialize-builtin/natural))
  (import
    (only (euphrates serialization-builtin-short)
          deserialize-builtin/short
          serialize-builtin/short))
  (import
    (only (euphrates serialization-human)
          deserialize/human
          serialize/human))
  (import
    (only (euphrates serialization-runnable)
          deserialize/runnable
          serialize/runnable))
  (import
    (only (euphrates serialization-sexp-generic)
          deserialize/sexp/generic
          serialize/sexp/generic))
  (import
    (only (euphrates serialization-sexp-natural)
          deserialize/sexp/natural
          serialize/sexp/natural))
  (import
    (only (euphrates serialization-sexp-short)
          deserialize/sexp/short
          serialize/sexp/short))
  (import
    (only (euphrates serialization-short)
          deserialize/short
          serialize/short))
  (import
    (only (euphrates shell-nondisrupt-alphabet)
          shell-nondisrupt/alphabet
          shell-nondisrupt/alphabet/index))
  (import
    (only (euphrates shell-quote-permissive)
          shell-quote/permissive))
  (import
    (only (euphrates shell-quote)
          shell-quote
          shell-quote/always/list))
  (import
    (only (euphrates shell-safe-alphabet)
          shell-safe/alphabet
          shell-safe/alphabet/index))
  (import
    (only (euphrates sleep-until) sleep-until))
  (import
    (only (euphrates srfi-27-backbone-generator)
          mrg32k3a-pack-state
          mrg32k3a-random-integer
          mrg32k3a-random-range
          mrg32k3a-random-real
          mrg32k3a-unpack-state))
  (import
    (only (euphrates srfi-27-generic)
          default-random-source
          make-random-source
          random-source-make-integers
          random-source-make-reals
          random-source-pseudo-randomize!
          random-source-randomize!
          random-source-state-ref
          random-source-state-set!
          random-source?))
  (import
    (only (euphrates srfi-27-random-source-obj)
          :random-source-current-time
          :random-source-make
          :random-source-make-integers
          :random-source-make-reals
          :random-source-pseudo-randomize!
          :random-source-randomize!
          :random-source-state-ref
          :random-source-state-set!
          :random-source?))
  (import
    (only (euphrates stack-obj)
          set-stack-lst!
          stack-constructor
          stack-lst
          stack-predicate))
  (import
    (only (euphrates stack)
          list->stack
          stack->list
          stack-discard!
          stack-empty?
          stack-make
          stack-peek
          stack-pop!
          stack-push!
          stack-unload!
          stack?))
  (import
    (only (euphrates string-drop-n) string-drop-n))
  (import
    (only (euphrates string-null-or-whitespace-p)
          string-null-or-whitespace?))
  (import
    (only (euphrates string-pad)
          string-pad-L
          string-pad-R))
  (import
    (only (euphrates string-plus-encode)
          string-plus-encode
          string-plus-encode/generic
          string-plus-encoding-make))
  (import
    (only (euphrates string-split-3) string-split-3))
  (import
    (only (euphrates string-split-simple)
          string-split/simple))
  (import
    (only (euphrates string-strip) string-strip))
  (import
    (only (euphrates string-take-n) string-take-n))
  (import
    (only (euphrates string-to-lines) string->lines))
  (import
    (only (euphrates string-to-numstring)
          string->numstring))
  (import
    (only (euphrates string-to-seconds-columned)
          string->seconds/columned))
  (import
    (only (euphrates string-to-seconds)
          string->seconds))
  (import
    (only (euphrates string-to-words) string->words))
  (import
    (only (euphrates string-trim-chars)
          string-trim-chars))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates syntax-append) syntax-append))
  (import
    (only (euphrates syntax-flatten-star)
          syntax-flatten*))
  (import
    (only (euphrates syntax-identity)
          syntax-identity))
  (import
    (only (euphrates syntax-map-noeval)
          syntax-map/noeval))
  (import (only (euphrates syntax-map) syntax-map))
  (import
    (only (euphrates syntax-reverse) syntax-reverse))
  (import
    (only (euphrates syntax-tree-foreach)
          syntax-tree-foreach))
  (import
    (only (euphrates sys-mutex-lock) sys-mutex-lock!))
  (import
    (only (euphrates sys-mutex-make) sys-mutex-make))
  (import
    (only (euphrates sys-mutex-unlock)
          sys-mutex-unlock!))
  (import
    (only (euphrates sys-thread-current-p-default)
          sys-thread-current/p-default))
  (import
    (only (euphrates sys-thread-current-p)
          sys-thread-current/p))
  (import
    (only (euphrates sys-thread-obj)
          set-sys-thread-obj-cancel-enabled?!
          set-sys-thread-obj-cancel-scheduled?!
          set-sys-thread-obj-handle!
          sys-thread-obj
          sys-thread-obj-cancel-enabled?
          sys-thread-obj-cancel-scheduled?
          sys-thread-obj-handle
          sys-thread-obj?))
  (import
    (only (euphrates sys-thread)
          sys-thread-cancel
          sys-thread-current
          sys-thread-disable-cancel
          sys-thread-enable-cancel
          sys-thread-mutex-lock!
          sys-thread-mutex-make
          sys-thread-mutex-unlock!
          sys-thread-sleep
          sys-thread-spawn))
  (import (only (euphrates sys-usleep) sys-usleep))
  (import
    (only (euphrates system-environment-get-all)
          system-environment-get-all))
  (import
    (only (euphrates system-environment)
          system-environment-get
          system-environment-set!))
  (import (only (euphrates system-fmt) system-fmt))
  (import (only (euphrates system-re) system-re))
  (import
    (only (euphrates system-star-exit-code)
          system*/exit-code))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates
            time-get-current-unixtime-values-p-default)
          time-get-current-unixtime/values/p-default))
  (import
    (only (euphrates time-get-current-unixtime-values-p)
          time-get-current-unixtime/values/p))
  (import
    (only (euphrates time-get-current-unixtime)
          time-get-current-unixtime
          time-get-current-unixtime/values))
  (import
    (only (euphrates
            time-get-fast-parameterizeable-timestamp)
          time-get-fast-parameterizeable-timestamp))
  (import
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp))
  (import
    (only (euphrates time-to-string)
          seconds->H/M/s
          seconds->M/s
          seconds->time-string))
  (import
    (only (euphrates tree-map-leafs) tree-map-leafs))
  (import (only (euphrates un-tilda-s) un~s))
  (import
    (only (euphrates uni-critical) uni-critical-make))
  (import
    (only (euphrates uni-spinlock)
          make-uni-spinlock
          make-uni-spinlock-critical
          uni-spinlock-lock!
          uni-spinlock-unlock!))
  (import
    (only (euphrates unit-conversions)
          centi->centi/unit
          centi->day/unit
          centi->deci/unit
          centi->deka/unit
          centi->gibi/unit
          centi->giga/unit
          centi->hecto/unit
          centi->hour/unit
          centi->kibi/unit
          centi->kilo/unit
          centi->mebi/unit
          centi->mega/unit
          centi->micro/unit
          centi->milli/unit
          centi->minute/unit
          centi->nano/unit
          centi->normal/unit
          centi->pebi/unit
          centi->peta/unit
          centi->pico/unit
          centi->week/unit
          day->centi/unit
          day->day/unit
          day->deci/unit
          day->deka/unit
          day->gibi/unit
          day->giga/unit
          day->hecto/unit
          day->hour/unit
          day->kibi/unit
          day->kilo/unit
          day->mebi/unit
          day->mega/unit
          day->micro/unit
          day->milli/unit
          day->minute/unit
          day->nano/unit
          day->normal/unit
          day->pebi/unit
          day->peta/unit
          day->pico/unit
          day->week/unit
          deci->centi/unit
          deci->day/unit
          deci->deci/unit
          deci->deka/unit
          deci->gibi/unit
          deci->giga/unit
          deci->hecto/unit
          deci->hour/unit
          deci->kibi/unit
          deci->kilo/unit
          deci->mebi/unit
          deci->mega/unit
          deci->micro/unit
          deci->milli/unit
          deci->minute/unit
          deci->nano/unit
          deci->normal/unit
          deci->pebi/unit
          deci->peta/unit
          deci->pico/unit
          deci->week/unit
          deka->centi/unit
          deka->day/unit
          deka->deci/unit
          deka->deka/unit
          deka->gibi/unit
          deka->giga/unit
          deka->hecto/unit
          deka->hour/unit
          deka->kibi/unit
          deka->kilo/unit
          deka->mebi/unit
          deka->mega/unit
          deka->micro/unit
          deka->milli/unit
          deka->minute/unit
          deka->nano/unit
          deka->normal/unit
          deka->pebi/unit
          deka->peta/unit
          deka->pico/unit
          deka->week/unit
          gibi->centi/unit
          gibi->day/unit
          gibi->deci/unit
          gibi->deka/unit
          gibi->gibi/unit
          gibi->giga/unit
          gibi->hecto/unit
          gibi->hour/unit
          gibi->kibi/unit
          gibi->kilo/unit
          gibi->mebi/unit
          gibi->mega/unit
          gibi->micro/unit
          gibi->milli/unit
          gibi->minute/unit
          gibi->nano/unit
          gibi->normal/unit
          gibi->pebi/unit
          gibi->peta/unit
          gibi->pico/unit
          gibi->week/unit
          giga->centi/unit
          giga->day/unit
          giga->deci/unit
          giga->deka/unit
          giga->gibi/unit
          giga->giga/unit
          giga->hecto/unit
          giga->hour/unit
          giga->kibi/unit
          giga->kilo/unit
          giga->mebi/unit
          giga->mega/unit
          giga->micro/unit
          giga->milli/unit
          giga->minute/unit
          giga->nano/unit
          giga->normal/unit
          giga->pebi/unit
          giga->peta/unit
          giga->pico/unit
          giga->week/unit
          hecto->centi/unit
          hecto->day/unit
          hecto->deci/unit
          hecto->deka/unit
          hecto->gibi/unit
          hecto->giga/unit
          hecto->hecto/unit
          hecto->hour/unit
          hecto->kibi/unit
          hecto->kilo/unit
          hecto->mebi/unit
          hecto->mega/unit
          hecto->micro/unit
          hecto->milli/unit
          hecto->minute/unit
          hecto->nano/unit
          hecto->normal/unit
          hecto->pebi/unit
          hecto->peta/unit
          hecto->pico/unit
          hecto->week/unit
          hour->centi/unit
          hour->day/unit
          hour->deci/unit
          hour->deka/unit
          hour->gibi/unit
          hour->giga/unit
          hour->hecto/unit
          hour->hour/unit
          hour->kibi/unit
          hour->kilo/unit
          hour->mebi/unit
          hour->mega/unit
          hour->micro/unit
          hour->milli/unit
          hour->minute/unit
          hour->nano/unit
          hour->normal/unit
          hour->pebi/unit
          hour->peta/unit
          hour->pico/unit
          hour->week/unit
          kibi->centi/unit
          kibi->day/unit
          kibi->deci/unit
          kibi->deka/unit
          kibi->gibi/unit
          kibi->giga/unit
          kibi->hecto/unit
          kibi->hour/unit
          kibi->kibi/unit
          kibi->kilo/unit
          kibi->mebi/unit
          kibi->mega/unit
          kibi->micro/unit
          kibi->milli/unit
          kibi->minute/unit
          kibi->nano/unit
          kibi->normal/unit
          kibi->pebi/unit
          kibi->peta/unit
          kibi->pico/unit
          kibi->week/unit
          kilo->centi/unit
          kilo->day/unit
          kilo->deci/unit
          kilo->deka/unit
          kilo->gibi/unit
          kilo->giga/unit
          kilo->hecto/unit
          kilo->hour/unit
          kilo->kibi/unit
          kilo->kilo/unit
          kilo->mebi/unit
          kilo->mega/unit
          kilo->micro/unit
          kilo->milli/unit
          kilo->minute/unit
          kilo->nano/unit
          kilo->normal/unit
          kilo->pebi/unit
          kilo->peta/unit
          kilo->pico/unit
          kilo->week/unit
          mebi->centi/unit
          mebi->day/unit
          mebi->deci/unit
          mebi->deka/unit
          mebi->gibi/unit
          mebi->giga/unit
          mebi->hecto/unit
          mebi->hour/unit
          mebi->kibi/unit
          mebi->kilo/unit
          mebi->mebi/unit
          mebi->mega/unit
          mebi->micro/unit
          mebi->milli/unit
          mebi->minute/unit
          mebi->nano/unit
          mebi->normal/unit
          mebi->pebi/unit
          mebi->peta/unit
          mebi->pico/unit
          mebi->week/unit
          mega->centi/unit
          mega->day/unit
          mega->deci/unit
          mega->deka/unit
          mega->gibi/unit
          mega->giga/unit
          mega->hecto/unit
          mega->hour/unit
          mega->kibi/unit
          mega->kilo/unit
          mega->mebi/unit
          mega->mega/unit
          mega->micro/unit
          mega->milli/unit
          mega->minute/unit
          mega->nano/unit
          mega->normal/unit
          mega->pebi/unit
          mega->peta/unit
          mega->pico/unit
          mega->week/unit
          micro->centi/unit
          micro->day/unit
          micro->deci/unit
          micro->deka/unit
          micro->gibi/unit
          micro->giga/unit
          micro->hecto/unit
          micro->hour/unit
          micro->kibi/unit
          micro->kilo/unit
          micro->mebi/unit
          micro->mega/unit
          micro->micro/unit
          micro->milli/unit
          micro->minute/unit
          micro->nano/unit
          micro->normal/unit
          micro->pebi/unit
          micro->peta/unit
          micro->pico/unit
          micro->week/unit
          milli->centi/unit
          milli->day/unit
          milli->deci/unit
          milli->deka/unit
          milli->gibi/unit
          milli->giga/unit
          milli->hecto/unit
          milli->hour/unit
          milli->kibi/unit
          milli->kilo/unit
          milli->mebi/unit
          milli->mega/unit
          milli->micro/unit
          milli->milli/unit
          milli->minute/unit
          milli->nano/unit
          milli->normal/unit
          milli->pebi/unit
          milli->peta/unit
          milli->pico/unit
          milli->week/unit
          minute->centi/unit
          minute->day/unit
          minute->deci/unit
          minute->deka/unit
          minute->gibi/unit
          minute->giga/unit
          minute->hecto/unit
          minute->hour/unit
          minute->kibi/unit
          minute->kilo/unit
          minute->mebi/unit
          minute->mega/unit
          minute->micro/unit
          minute->milli/unit
          minute->minute/unit
          minute->nano/unit
          minute->normal/unit
          minute->pebi/unit
          minute->peta/unit
          minute->pico/unit
          minute->week/unit
          nano->centi/unit
          nano->day/unit
          nano->deci/unit
          nano->deka/unit
          nano->gibi/unit
          nano->giga/unit
          nano->hecto/unit
          nano->hour/unit
          nano->kibi/unit
          nano->kilo/unit
          nano->mebi/unit
          nano->mega/unit
          nano->micro/unit
          nano->milli/unit
          nano->minute/unit
          nano->nano/unit
          nano->normal/unit
          nano->pebi/unit
          nano->peta/unit
          nano->pico/unit
          nano->week/unit
          normal->centi/unit
          normal->day/unit
          normal->deci/unit
          normal->deka/unit
          normal->gibi/unit
          normal->giga/unit
          normal->hecto/unit
          normal->hour/unit
          normal->kibi/unit
          normal->kilo/unit
          normal->mebi/unit
          normal->mega/unit
          normal->micro/unit
          normal->milli/unit
          normal->minute/unit
          normal->nano/unit
          normal->normal/unit
          normal->pebi/unit
          normal->peta/unit
          normal->pico/unit
          normal->week/unit
          pebi->centi/unit
          pebi->day/unit
          pebi->deci/unit
          pebi->deka/unit
          pebi->gibi/unit
          pebi->giga/unit
          pebi->hecto/unit
          pebi->hour/unit
          pebi->kibi/unit
          pebi->kilo/unit
          pebi->mebi/unit
          pebi->mega/unit
          pebi->micro/unit
          pebi->milli/unit
          pebi->minute/unit
          pebi->nano/unit
          pebi->normal/unit
          pebi->pebi/unit
          pebi->peta/unit
          pebi->pico/unit
          pebi->week/unit
          peta->centi/unit
          peta->day/unit
          peta->deci/unit
          peta->deka/unit
          peta->gibi/unit
          peta->giga/unit
          peta->hecto/unit
          peta->hour/unit
          peta->kibi/unit
          peta->kilo/unit
          peta->mebi/unit
          peta->mega/unit
          peta->micro/unit
          peta->milli/unit
          peta->minute/unit
          peta->nano/unit
          peta->normal/unit
          peta->pebi/unit
          peta->peta/unit
          peta->pico/unit
          peta->week/unit
          pico->centi/unit
          pico->day/unit
          pico->deci/unit
          pico->deka/unit
          pico->gibi/unit
          pico->giga/unit
          pico->hecto/unit
          pico->hour/unit
          pico->kibi/unit
          pico->kilo/unit
          pico->mebi/unit
          pico->mega/unit
          pico->micro/unit
          pico->milli/unit
          pico->minute/unit
          pico->nano/unit
          pico->normal/unit
          pico->pebi/unit
          pico->peta/unit
          pico->pico/unit
          pico->week/unit
          week->centi/unit
          week->day/unit
          week->deci/unit
          week->deka/unit
          week->gibi/unit
          week->giga/unit
          week->hecto/unit
          week->hour/unit
          week->kibi/unit
          week->kilo/unit
          week->mebi/unit
          week->mega/unit
          week->micro/unit
          week->milli/unit
          week->minute/unit
          week->nano/unit
          week->normal/unit
          week->pebi/unit
          week->peta/unit
          week->pico/unit
          week->week/unit))
  (import
    (only (euphrates universal-lockr-unlockr)
          universal-lockr!
          universal-unlockr!))
  (import
    (only (euphrates universal-usleep)
          universal-usleep))
  (import (only (euphrates uri-encode) uri-encode))
  (import
    (only (euphrates uri-safe-alphabet)
          uri-safe/alphabet
          uri-safe/alphabet/index))
  (import
    (only (euphrates url-decompose) url-decompose))
  (import
    (only (euphrates url-get-fragment)
          url-get-fragment))
  (import
    (only (euphrates url-get-hostname-and-port)
          url-get-hostname-and-port))
  (import
    (only (euphrates url-get-path) url-get-path))
  (import
    (only (euphrates url-get-protocol)
          url-get-protocol))
  (import
    (only (euphrates url-get-query) url-get-query))
  (import (only (euphrates url-goto) url-goto))
  (import
    (only (euphrates usymbol)
          make-usymbol
          usymbol-name
          usymbol-qualifier
          usymbol?))
  (import
    (only (euphrates vector-random-shuffle-bang)
          vector-random-shuffle!))
  (import
    (only (euphrates with-critical) with-critical))
  (import
    (only (euphrates with-dynamic-set)
          with-dynamic-set!))
  (import
    (only (euphrates with-dynamic) with-dynamic))
  (import
    (only (euphrates with-ignore-errors)
          with-ignore-errors!))
  (import (only (euphrates with-monad) with-monad))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates with-randomizer-seed)
          with-randomizer-seed))
  (import
    (only (euphrates with-singlethread-env)
          with-singlethread-env))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (euphrates write-string-file)
          write-string-file))
  (import
    (only (scheme base)
          *
          +
          -
          ...
          /
          <
          <=
          =
          =>
          >
          >=
          _
          abs
          and
          append
          apply
          assoc
          assq
          assv
          begin
          binary-port?
          boolean=?
          boolean?
          bytevector
          bytevector-append
          bytevector-copy
          bytevector-copy!
          bytevector-length
          bytevector-u8-ref
          bytevector-u8-set!
          bytevector?
          caar
          cadr
          call-with-current-continuation
          call-with-port
          call-with-values
          call/cc
          car
          case
          cdar
          cddr
          cdr
          ceiling
          char->integer
          char-ready?
          char<=?
          char<?
          char=?
          char>=?
          char>?
          char?
          close-input-port
          close-output-port
          close-port
          complex?
          cond
          cond-expand
          cons
          current-error-port
          current-input-port
          current-output-port
          define
          define-record-type
          define-syntax
          define-values
          denominator
          do
          dynamic-wind
          else
          eof-object
          eof-object?
          eq?
          equal?
          eqv?
          error
          error-object-irritants
          error-object-message
          error-object?
          even?
          exact
          exact-integer-sqrt
          exact-integer?
          exact?
          expt
          features
          file-error?
          floor
          floor-quotient
          floor-remainder
          floor/
          flush-output-port
          for-each
          gcd
          get-output-bytevector
          get-output-string
          guard
          if
          include
          include-ci
          inexact
          inexact?
          input-port-open?
          input-port?
          integer->char
          integer?
          lambda
          lcm
          length
          let
          let*
          let*-values
          let-syntax
          let-values
          letrec
          letrec*
          letrec-syntax
          list
          list->string
          list->vector
          list-copy
          list-ref
          list-set!
          list-tail
          list?
          make-bytevector
          make-list
          make-parameter
          make-string
          make-vector
          map
          max
          member
          memq
          memv
          min
          modulo
          negative?
          newline
          not
          null?
          number->string
          number?
          numerator
          odd?
          open-input-bytevector
          open-input-string
          open-output-bytevector
          open-output-string
          or
          output-port-open?
          output-port?
          pair?
          parameterize
          peek-char
          peek-u8
          port?
          positive?
          procedure?
          quasiquote
          quote
          quotient
          raise
          raise-continuable
          rational?
          rationalize
          read-bytevector
          read-bytevector!
          read-char
          read-error?
          read-line
          read-string
          read-u8
          real?
          remainder
          reverse
          round
          set!
          set-car!
          set-cdr!
          square
          string
          string->list
          string->number
          string->symbol
          string->utf8
          string->vector
          string-append
          string-copy
          string-copy!
          string-fill!
          string-for-each
          string-length
          string-map
          string-ref
          string-set!
          string<=?
          string<?
          string=?
          string>=?
          string>?
          string?
          substring
          symbol->string
          symbol=?
          symbol?
          syntax-error
          syntax-rules
          textual-port?
          truncate
          truncate-quotient
          truncate-remainder
          truncate/
          u8-ready?
          unless
          unquote
          unquote-splicing
          utf8->string
          values
          vector
          vector->list
          vector->string
          vector-append
          vector-copy
          vector-copy!
          vector-fill!
          vector-for-each
          vector-length
          vector-map
          vector-ref
          vector-set!
          vector?
          when
          with-exception-handler
          write-bytevector
          write-char
          write-string
          write-u8
          zero?))
  (import (only (scheme case-lambda) case-lambda))
  (import
    (only (scheme char)
          char-alphabetic?
          char-ci<=?
          char-ci<?
          char-ci=?
          char-ci>=?
          char-ci>?
          char-downcase
          char-foldcase
          char-lower-case?
          char-numeric?
          char-upcase
          char-upper-case?
          char-whitespace?
          digit-value
          string-ci<=?
          string-ci<?
          string-ci=?
          string-ci>=?
          string-ci>?
          string-downcase
          string-foldcase
          string-upcase))
  (import
    (only (scheme complex)
          angle
          imag-part
          magnitude
          make-polar
          make-rectangular
          real-part))
  (import
    (only (scheme cxr)
          caaaar
          caaadr
          caaar
          caadar
          caaddr
          caadr
          cadaar
          cadadr
          cadar
          caddar
          cadddr
          caddr
          cdaaar
          cdaadr
          cdaar
          cdadar
          cdaddr
          cdadr
          cddaar
          cddadr
          cddar
          cdddar
          cddddr
          cdddr))
  (import (only (scheme eval) environment eval))
  (import
    (only (scheme file)
          call-with-input-file
          call-with-output-file
          delete-file
          file-exists?
          open-binary-input-file
          open-binary-output-file
          open-input-file
          open-output-file
          with-input-from-file
          with-output-to-file))
  (import
    (only (scheme inexact)
          acos
          asin
          atan
          cos
          exp
          finite?
          infinite?
          log
          nan?
          sin
          sqrt
          tan))
  (import
    (only (scheme lazy)
          delay
          delay-force
          force
          make-promise
          promise?))
  (import (only (scheme load) load))
  (import
    (only (scheme process-context)
          command-line
          emergency-exit
          exit
          get-environment-variable
          get-environment-variables))
  (import
    (only (scheme r5rs)
          exact->inexact
          inexact->exact
          null-environment
          scheme-report-environment))
  (import (only (scheme read) read))
  (import
    (only (scheme repl) interaction-environment))
  (import
    (only (scheme time)
          current-jiffy
          current-second
          jiffies-per-second))
  (import
    (only (scheme write)
          display
          write
          write-shared
          write-simple))
  (cond-expand
    (guile (import
             (only (srfi srfi-1)
                   alist-cons
                   alist-copy
                   alist-delete
                   alist-delete!
                   any
                   append!
                   append-map
                   append-map!
                   append-reverse
                   append-reverse!
                   break
                   break!
                   car+cdr
                   circular-list
                   circular-list?
                   concatenate
                   concatenate!
                   cons*
                   count
                   delete
                   delete!
                   delete-duplicates
                   delete-duplicates!
                   dotted-list?
                   drop
                   drop-right
                   drop-right!
                   drop-while
                   eighth
                   every
                   fifth
                   filter
                   filter!
                   filter-map
                   find
                   find-tail
                   first
                   fold
                   fold-right
                   fourth
                   iota
                   last
                   last-pair
                   length+
                   list-index
                   list-tabulate
                   list=
                   lset-adjoin
                   lset-diff+intersection
                   lset-diff+intersection!
                   lset-difference
                   lset-difference!
                   lset-intersection
                   lset-intersection!
                   lset-union
                   lset-union!
                   lset-xor
                   lset-xor!
                   lset<=
                   lset=
                   map!
                   map-in-order
                   ninth
                   not-pair?
                   null-list?
                   pair-fold
                   pair-fold-right
                   pair-for-each
                   partition
                   partition!
                   proper-list?
                   reduce
                   reduce-right
                   remove
                   remove!
                   reverse!
                   second
                   seventh
                   sixth
                   span
                   span!
                   split-at
                   split-at!
                   take
                   take!
                   take-right
                   take-while
                   take-while!
                   tenth
                   third
                   unfold
                   unfold-right
                   unzip1
                   unzip2
                   unzip3
                   unzip4
                   unzip5
                   xcons
                   zip)))
    (else (import
            (only (srfi 1)
                  alist-cons
                  alist-copy
                  alist-delete
                  alist-delete!
                  any
                  append!
                  append-map
                  append-map!
                  append-reverse
                  append-reverse!
                  break
                  break!
                  car+cdr
                  circular-list
                  circular-list?
                  concatenate
                  concatenate!
                  cons*
                  count
                  delete
                  delete!
                  delete-duplicates
                  delete-duplicates!
                  dotted-list?
                  drop
                  drop-right
                  drop-right!
                  drop-while
                  eighth
                  every
                  fifth
                  filter
                  filter!
                  filter-map
                  find
                  find-tail
                  first
                  fold
                  fold-right
                  fourth
                  iota
                  last
                  last-pair
                  length+
                  list-index
                  list-tabulate
                  list=
                  lset-adjoin
                  lset-diff+intersection
                  lset-diff+intersection!
                  lset-difference
                  lset-difference!
                  lset-intersection
                  lset-intersection!
                  lset-union
                  lset-union!
                  lset-xor
                  lset-xor!
                  lset<=
                  lset=
                  map!
                  map-in-order
                  ninth
                  not-pair?
                  null-list?
                  pair-fold
                  pair-fold-right
                  pair-for-each
                  partition
                  partition!
                  proper-list?
                  reduce
                  reduce-right
                  remove
                  remove!
                  reverse!
                  second
                  seventh
                  sixth
                  span
                  span!
                  split-at
                  split-at!
                  take
                  take!
                  take-right
                  take-while
                  take-while!
                  tenth
                  third
                  unfold
                  unfold-right
                  unzip1
                  unzip2
                  unzip3
                  unzip4
                  unzip5
                  xcons
                  zip))))
  (cond-expand
    (guile (import (only (srfi srfi-10) define-reader-ctor)))
    (else (import (only (srfi 10) define-reader-ctor))))
  (cond-expand
    (guile (import
             (only (srfi srfi-13)
                   reverse-list->string
                   string-any
                   string-append/shared
                   string-ci<
                   string-ci<=
                   string-ci<>
                   string-ci=
                   string-ci>
                   string-ci>=
                   string-concatenate
                   string-concatenate-reverse
                   string-concatenate-reverse/shared
                   string-concatenate/shared
                   string-contains
                   string-contains-ci
                   string-count
                   string-delete
                   string-downcase!
                   string-drop
                   string-drop-right
                   string-every
                   string-filter
                   string-fold
                   string-fold-right
                   string-for-each-index
                   string-hash
                   string-hash-ci
                   string-index
                   string-index-right
                   string-join
                   string-map!
                   string-null?
                   string-pad
                   string-pad-right
                   string-prefix-ci?
                   string-prefix-length
                   string-prefix-length-ci
                   string-prefix?
                   string-replace
                   string-reverse
                   string-reverse!
                   string-skip
                   string-skip-right
                   string-suffix-ci?
                   string-suffix-length
                   string-suffix-length-ci
                   string-suffix?
                   string-tabulate
                   string-take
                   string-take-right
                   string-titlecase
                   string-titlecase!
                   string-tokenize
                   string-trim
                   string-trim-both
                   string-trim-right
                   string-unfold
                   string-unfold-right
                   string-upcase!
                   string-xcopy!
                   string<
                   string<=
                   string<>
                   string=
                   string>
                   string>=
                   substring/shared
                   xsubstring)))
    (else (import
            (only (srfi 13)
                  reverse-list->string
                  string-any
                  string-append/shared
                  string-ci<
                  string-ci<=
                  string-ci<>
                  string-ci=
                  string-ci>
                  string-ci>=
                  string-concatenate
                  string-concatenate-reverse
                  string-concatenate-reverse/shared
                  string-concatenate/shared
                  string-contains
                  string-contains-ci
                  string-count
                  string-delete
                  string-downcase!
                  string-drop
                  string-drop-right
                  string-every
                  string-filter
                  string-fold
                  string-fold-right
                  string-for-each-index
                  string-hash
                  string-hash-ci
                  string-index
                  string-index-right
                  string-join
                  string-map!
                  string-null?
                  string-pad
                  string-pad-right
                  string-prefix-ci?
                  string-prefix-length
                  string-prefix-length-ci
                  string-prefix?
                  string-replace
                  string-reverse
                  string-reverse!
                  string-skip
                  string-skip-right
                  string-suffix-ci?
                  string-suffix-length
                  string-suffix-length-ci
                  string-suffix?
                  string-tabulate
                  string-take
                  string-take-right
                  string-titlecase
                  string-titlecase!
                  string-tokenize
                  string-trim
                  string-trim-both
                  string-trim-right
                  string-unfold
                  string-unfold-right
                  string-upcase!
                  string-xcopy!
                  string<
                  string<=
                  string<>
                  string=
                  string>
                  string>=
                  substring/shared
                  xsubstring))))
  (cond-expand
    (guile (import
             (only (srfi srfi-14)
                   ->char-set
                   char-set
                   char-set->list
                   char-set->string
                   char-set-adjoin
                   char-set-adjoin!
                   char-set-any
                   char-set-complement
                   char-set-complement!
                   char-set-contains?
                   char-set-copy
                   char-set-count
                   char-set-cursor
                   char-set-cursor-next
                   char-set-delete
                   char-set-delete!
                   char-set-diff+intersection
                   char-set-diff+intersection!
                   char-set-difference
                   char-set-difference!
                   char-set-every
                   char-set-filter
                   char-set-filter!
                   char-set-fold
                   char-set-for-each
                   char-set-hash
                   char-set-intersection
                   char-set-intersection!
                   char-set-map
                   char-set-ref
                   char-set-size
                   char-set-unfold
                   char-set-unfold!
                   char-set-union
                   char-set-union!
                   char-set-xor
                   char-set-xor!
                   char-set:ascii
                   char-set:blank
                   char-set:digit
                   char-set:empty
                   char-set:full
                   char-set:graphic
                   char-set:hex-digit
                   char-set:iso-control
                   char-set:letter
                   char-set:letter+digit
                   char-set:lower-case
                   char-set:printing
                   char-set:punctuation
                   char-set:symbol
                   char-set:title-case
                   char-set:upper-case
                   char-set:whitespace
                   char-set<=
                   char-set=
                   char-set?
                   end-of-char-set?
                   list->char-set
                   list->char-set!
                   string->char-set
                   string->char-set!
                   ucs-range->char-set
                   ucs-range->char-set!)))
    (else (import
            (only (srfi 14)
                  ->char-set
                  char-set
                  char-set->list
                  char-set->string
                  char-set-adjoin
                  char-set-adjoin!
                  char-set-any
                  char-set-complement
                  char-set-complement!
                  char-set-contains?
                  char-set-copy
                  char-set-count
                  char-set-cursor
                  char-set-cursor-next
                  char-set-delete
                  char-set-delete!
                  char-set-diff+intersection
                  char-set-diff+intersection!
                  char-set-difference
                  char-set-difference!
                  char-set-every
                  char-set-filter
                  char-set-filter!
                  char-set-fold
                  char-set-for-each
                  char-set-hash
                  char-set-intersection
                  char-set-intersection!
                  char-set-map
                  char-set-ref
                  char-set-size
                  char-set-unfold
                  char-set-unfold!
                  char-set-union
                  char-set-union!
                  char-set-xor
                  char-set-xor!
                  char-set:ascii
                  char-set:blank
                  char-set:digit
                  char-set:empty
                  char-set:full
                  char-set:graphic
                  char-set:hex-digit
                  char-set:iso-control
                  char-set:letter
                  char-set:letter+digit
                  char-set:lower-case
                  char-set:printing
                  char-set:punctuation
                  char-set:symbol
                  char-set:title-case
                  char-set:upper-case
                  char-set:whitespace
                  char-set<=
                  char-set=
                  char-set?
                  end-of-char-set?
                  list->char-set
                  list->char-set!
                  string->char-set
                  string->char-set!
                  ucs-range->char-set
                  ucs-range->char-set!))))
  (cond-expand
    (guile (import
             (only (srfi srfi-17) getter-with-setter setter)))
    (else (import
            (only (srfi 17) getter-with-setter setter))))
  (cond-expand
    (guile (import
             (only (srfi srfi-171)
                   bytevector-u8-transduce
                   generator-transduce
                   list-transduce
                   port-transduce
                   rany
                   rcons
                   rcount
                   reverse-rcons
                   revery
                   string-transduce
                   tadd-between
                   tappend-map
                   tconcatenate
                   tdelete-duplicates
                   tdelete-neighbor-duplicates
                   tdrop
                   tdrop-while
                   tenumerate
                   tfilter
                   tfilter-map
                   tflatten
                   tlog
                   tmap
                   tpartition
                   tremove
                   treplace
                   tsegment
                   ttake
                   ttake-while
                   vector-transduce)))
    (else (import
            (only (srfi 171)
                  bytevector-u8-transduce
                  generator-transduce
                  list-transduce
                  port-transduce
                  rany
                  rcons
                  rcount
                  reverse-rcons
                  revery
                  string-transduce
                  tadd-between
                  tappend-map
                  tconcatenate
                  tdelete-duplicates
                  tdelete-neighbor-duplicates
                  tdrop
                  tdrop-while
                  tenumerate
                  tfilter
                  tfilter-map
                  tflatten
                  tlog
                  tmap
                  tpartition
                  tremove
                  treplace
                  tsegment
                  ttake
                  ttake-while
                  vector-transduce))))
  (cond-expand
    (guile (import
             (only (srfi srfi-18)
                   abandoned-mutex-exception?
                   condition-variable-broadcast!
                   condition-variable-name
                   condition-variable-signal!
                   condition-variable-specific
                   condition-variable-specific-set!
                   condition-variable?
                   current-exception-handler
                   current-thread
                   current-time
                   join-timeout-exception?
                   make-condition-variable
                   make-mutex
                   make-thread
                   mutex
                   mutex-lock!
                   mutex-name
                   mutex-specific
                   mutex-specific-set!
                   mutex-state
                   mutex-unlock!
                   mutex?
                   seconds->time
                   terminated-thread-exception?
                   thread-join!
                   thread-name
                   thread-sleep!
                   thread-specific
                   thread-specific-set!
                   thread-start!
                   thread-terminate!
                   thread-yield!
                   thread?
                   time->seconds
                   time?
                   uncaught-exception-reason
                   uncaught-exception?)))
    (else (import
            (only (srfi 18)
                  abandoned-mutex-exception?
                  condition-variable-broadcast!
                  condition-variable-name
                  condition-variable-signal!
                  condition-variable-specific
                  condition-variable-specific-set!
                  condition-variable?
                  current-exception-handler
                  current-thread
                  current-time
                  join-timeout-exception?
                  make-condition-variable
                  make-mutex
                  make-thread
                  mutex
                  mutex-lock!
                  mutex-name
                  mutex-specific
                  mutex-specific-set!
                  mutex-state
                  mutex-unlock!
                  mutex?
                  seconds->time
                  terminated-thread-exception?
                  thread-join!
                  thread-name
                  thread-sleep!
                  thread-specific
                  thread-specific-set!
                  thread-start!
                  thread-terminate!
                  thread-yield!
                  thread?
                  time->seconds
                  time?
                  uncaught-exception-reason
                  uncaught-exception?))))
  (cond-expand
    (guile (import
             (only (srfi srfi-19)
                   add-duration
                   add-duration!
                   copy-time
                   current-date
                   current-julian-day
                   current-modified-julian-day
                   date->julian-day
                   date->modified-julian-day
                   date->string
                   date->time-monotonic
                   date->time-tai
                   date->time-utc
                   date-day
                   date-hour
                   date-minute
                   date-month
                   date-nanosecond
                   date-second
                   date-week-day
                   date-week-number
                   date-year
                   date-year-day
                   date-zone-offset
                   date?
                   julian-day->date
                   julian-day->time-monotonic
                   julian-day->time-tai
                   julian-day->time-utc
                   make-date
                   make-time
                   modified-julian-day->date
                   modified-julian-day->time-monotonic
                   modified-julian-day->time-tai
                   modified-julian-day->time-utc
                   set-time-nanosecond!
                   set-time-second!
                   set-time-type!
                   string->date
                   subtract-duration
                   subtract-duration!
                   time-difference
                   time-difference!
                   time-duration
                   time-monotonic
                   time-monotonic->date
                   time-monotonic->julian-day
                   time-monotonic->modified-julian-day
                   time-monotonic->time-tai
                   time-monotonic->time-tai!
                   time-monotonic->time-utc
                   time-monotonic->time-utc!
                   time-nanosecond
                   time-process
                   time-resolution
                   time-second
                   time-tai
                   time-tai->date
                   time-tai->julian-day
                   time-tai->modified-julian-day
                   time-tai->time-monotonic
                   time-tai->time-monotonic!
                   time-tai->time-utc
                   time-tai->time-utc!
                   time-thread
                   time-type
                   time-utc
                   time-utc->date
                   time-utc->julian-day
                   time-utc->modified-julian-day
                   time-utc->time-monotonic
                   time-utc->time-monotonic!
                   time-utc->time-tai
                   time-utc->time-tai!
                   time<=?
                   time<?
                   time=?
                   time>=?
                   time>?)))
    (else (import
            (only (srfi 19)
                  add-duration
                  add-duration!
                  copy-time
                  current-date
                  current-julian-day
                  current-modified-julian-day
                  date->julian-day
                  date->modified-julian-day
                  date->string
                  date->time-monotonic
                  date->time-tai
                  date->time-utc
                  date-day
                  date-hour
                  date-minute
                  date-month
                  date-nanosecond
                  date-second
                  date-week-day
                  date-week-number
                  date-year
                  date-year-day
                  date-zone-offset
                  date?
                  julian-day->date
                  julian-day->time-monotonic
                  julian-day->time-tai
                  julian-day->time-utc
                  make-date
                  make-time
                  modified-julian-day->date
                  modified-julian-day->time-monotonic
                  modified-julian-day->time-tai
                  modified-julian-day->time-utc
                  set-time-nanosecond!
                  set-time-second!
                  set-time-type!
                  string->date
                  subtract-duration
                  subtract-duration!
                  time-difference
                  time-difference!
                  time-duration
                  time-monotonic
                  time-monotonic->date
                  time-monotonic->julian-day
                  time-monotonic->modified-julian-day
                  time-monotonic->time-tai
                  time-monotonic->time-tai!
                  time-monotonic->time-utc
                  time-monotonic->time-utc!
                  time-nanosecond
                  time-process
                  time-resolution
                  time-second
                  time-tai
                  time-tai->date
                  time-tai->julian-day
                  time-tai->modified-julian-day
                  time-tai->time-monotonic
                  time-tai->time-monotonic!
                  time-tai->time-utc
                  time-tai->time-utc!
                  time-thread
                  time-type
                  time-utc
                  time-utc->date
                  time-utc->julian-day
                  time-utc->modified-julian-day
                  time-utc->time-monotonic
                  time-utc->time-monotonic!
                  time-utc->time-tai
                  time-utc->time-tai!
                  time<=?
                  time<?
                  time=?
                  time>=?
                  time>?))))
  (cond-expand
    (guile (import (only (srfi srfi-2) and-let*)))
    (else (import (only (srfi 2) and-let*))))
  (cond-expand
    (guile (import (only (srfi srfi-26) cut cute)))
    (else (import (only (srfi 26) cut cute))))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import
             (only (srfi srfi-35)
                   &condition
                   &error
                   &message
                   &serious
                   condition
                   condition-has-type?
                   condition-message
                   condition-ref
                   condition-type?
                   condition?
                   define-condition-type
                   error?
                   extract-condition
                   make-compound-condition
                   make-condition
                   make-condition-type
                   message-condition?
                   serious-condition?)))
    (else (import
            (only (srfi 35)
                  &condition
                  &error
                  &message
                  &serious
                  condition
                  condition-has-type?
                  condition-message
                  condition-ref
                  condition-type?
                  condition?
                  define-condition-type
                  error?
                  extract-condition
                  make-compound-condition
                  make-condition
                  make-condition-type
                  message-condition?
                  serious-condition?))))
  (cond-expand
    (guile (import
             (only (srfi srfi-37)
                   args-fold
                   option
                   option-names
                   option-optional-arg?
                   option-processor
                   option-required-arg?)))
    (else (import
            (only (srfi 37)
                  args-fold
                  option
                  option-names
                  option-optional-arg?
                  option-processor
                  option-required-arg?))))
  (cond-expand
    (guile (import
             (only (srfi srfi-38)
                   read-with-shared-structure
                   write-with-shared-structure)))
    (else (import
            (only (srfi 38)
                  read-with-shared-structure
                  write-with-shared-structure))))
  (cond-expand
    (guile (import (only (srfi srfi-39) with-parameters*)))
    (else (import (only (srfi 39) with-parameters*))))
  (cond-expand
    (guile (import
             (only (srfi srfi-4)
                   f32vector
                   f32vector->list
                   f32vector-length
                   f32vector-ref
                   f32vector-set!
                   f32vector?
                   f64vector
                   f64vector->list
                   f64vector-length
                   f64vector-ref
                   f64vector-set!
                   f64vector?
                   list->f32vector
                   list->f64vector
                   list->s16vector
                   list->s32vector
                   list->s64vector
                   list->s8vector
                   list->u16vector
                   list->u32vector
                   list->u64vector
                   list->u8vector
                   make-f32vector
                   make-f64vector
                   make-s16vector
                   make-s32vector
                   make-s64vector
                   make-s8vector
                   make-u16vector
                   make-u32vector
                   make-u64vector
                   make-u8vector
                   s16vector
                   s16vector->list
                   s16vector-length
                   s16vector-ref
                   s16vector-set!
                   s16vector?
                   s32vector
                   s32vector->list
                   s32vector-length
                   s32vector-ref
                   s32vector-set!
                   s32vector?
                   s64vector
                   s64vector->list
                   s64vector-length
                   s64vector-ref
                   s64vector-set!
                   s64vector?
                   s8vector
                   s8vector->list
                   s8vector-length
                   s8vector-ref
                   s8vector-set!
                   s8vector?
                   u16vector
                   u16vector->list
                   u16vector-length
                   u16vector-ref
                   u16vector-set!
                   u16vector?
                   u32vector
                   u32vector->list
                   u32vector-length
                   u32vector-ref
                   u32vector-set!
                   u32vector?
                   u64vector
                   u64vector->list
                   u64vector-length
                   u64vector-ref
                   u64vector-set!
                   u64vector?
                   u8vector
                   u8vector->list
                   u8vector-length
                   u8vector-ref
                   u8vector-set!
                   u8vector?)))
    (else (import
            (only (srfi 4)
                  f32vector
                  f32vector->list
                  f32vector-length
                  f32vector-ref
                  f32vector-set!
                  f32vector?
                  f64vector
                  f64vector->list
                  f64vector-length
                  f64vector-ref
                  f64vector-set!
                  f64vector?
                  list->f32vector
                  list->f64vector
                  list->s16vector
                  list->s32vector
                  list->s64vector
                  list->s8vector
                  list->u16vector
                  list->u32vector
                  list->u64vector
                  list->u8vector
                  make-f32vector
                  make-f64vector
                  make-s16vector
                  make-s32vector
                  make-s64vector
                  make-s8vector
                  make-u16vector
                  make-u32vector
                  make-u64vector
                  make-u8vector
                  s16vector
                  s16vector->list
                  s16vector-length
                  s16vector-ref
                  s16vector-set!
                  s16vector?
                  s32vector
                  s32vector->list
                  s32vector-length
                  s32vector-ref
                  s32vector-set!
                  s32vector?
                  s64vector
                  s64vector->list
                  s64vector-length
                  s64vector-ref
                  s64vector-set!
                  s64vector?
                  s8vector
                  s8vector->list
                  s8vector-length
                  s8vector-ref
                  s8vector-set!
                  s8vector?
                  u16vector
                  u16vector->list
                  u16vector-length
                  u16vector-ref
                  u16vector-set!
                  u16vector?
                  u32vector
                  u32vector->list
                  u32vector-length
                  u32vector-ref
                  u32vector-set!
                  u32vector?
                  u64vector
                  u64vector->list
                  u64vector-length
                  u64vector-ref
                  u64vector-set!
                  u64vector?
                  u8vector
                  u8vector->list
                  u8vector-length
                  u8vector-ref
                  u8vector-set!
                  u8vector?))))
  (cond-expand
    (guile (import
             (only (srfi srfi-41)
                   define-stream
                   list->stream
                   port->stream
                   stream
                   stream->list
                   stream-append
                   stream-car
                   stream-cdr
                   stream-concat
                   stream-cons
                   stream-constant
                   stream-drop
                   stream-drop-while
                   stream-filter
                   stream-fold
                   stream-for-each
                   stream-from
                   stream-iterate
                   stream-lambda
                   stream-length
                   stream-let
                   stream-map
                   stream-match
                   stream-null
                   stream-null?
                   stream-of
                   stream-pair?
                   stream-range
                   stream-ref
                   stream-reverse
                   stream-scan
                   stream-take
                   stream-take-while
                   stream-unfold
                   stream-unfolds
                   stream-zip
                   stream?)))
    (else (import
            (only (srfi 41)
                  define-stream
                  list->stream
                  port->stream
                  stream
                  stream->list
                  stream-append
                  stream-car
                  stream-cdr
                  stream-concat
                  stream-cons
                  stream-constant
                  stream-drop
                  stream-drop-while
                  stream-filter
                  stream-fold
                  stream-for-each
                  stream-from
                  stream-iterate
                  stream-lambda
                  stream-length
                  stream-let
                  stream-map
                  stream-match
                  stream-null
                  stream-null?
                  stream-of
                  stream-pair?
                  stream-range
                  stream-ref
                  stream-reverse
                  stream-scan
                  stream-take
                  stream-take-while
                  stream-unfold
                  stream-unfolds
                  stream-zip
                  stream?))))
  (cond-expand
    (guile (import
             (only (srfi srfi-42)
                   :
                   :-dispatch-ref
                   :-dispatch-set!
                   :char-range
                   :dispatched
                   :do
                   :generator-proc
                   :integers
                   :let
                   :list
                   :parallel
                   :port
                   :range
                   :real-range
                   :string
                   :until
                   :vector
                   :while
                   any?-ec
                   append-ec
                   dispatch-union
                   do-ec
                   every?-ec
                   first-ec
                   fold-ec
                   fold3-ec
                   last-ec
                   list-ec
                   make-initial-:-dispatch
                   max-ec
                   min-ec
                   product-ec
                   string-append-ec
                   string-ec
                   sum-ec
                   vector-ec
                   vector-of-length-ec)))
    (else (import
            (only (srfi 42)
                  :
                  :-dispatch-ref
                  :-dispatch-set!
                  :char-range
                  :dispatched
                  :do
                  :generator-proc
                  :integers
                  :let
                  :list
                  :parallel
                  :port
                  :range
                  :real-range
                  :string
                  :until
                  :vector
                  :while
                  any?-ec
                  append-ec
                  dispatch-union
                  do-ec
                  every?-ec
                  first-ec
                  fold-ec
                  fold3-ec
                  last-ec
                  list-ec
                  make-initial-:-dispatch
                  max-ec
                  min-ec
                  product-ec
                  string-append-ec
                  string-ec
                  sum-ec
                  vector-ec
                  vector-of-length-ec))))
  (cond-expand
    (guile (import
             (only (srfi srfi-43)
                   reverse-list->vector
                   reverse-vector->list
                   vector-any
                   vector-binary-search
                   vector-concatenate
                   vector-count
                   vector-empty?
                   vector-every
                   vector-fold
                   vector-fold-right
                   vector-index
                   vector-index-right
                   vector-map!
                   vector-reverse!
                   vector-reverse-copy
                   vector-reverse-copy!
                   vector-skip
                   vector-skip-right
                   vector-swap!
                   vector-unfold
                   vector-unfold-right
                   vector=)))
    (else (import
            (only (srfi 43)
                  reverse-list->vector
                  reverse-vector->list
                  vector-any
                  vector-binary-search
                  vector-concatenate
                  vector-count
                  vector-empty?
                  vector-every
                  vector-fold
                  vector-fold-right
                  vector-index
                  vector-index-right
                  vector-map!
                  vector-reverse!
                  vector-reverse-copy
                  vector-reverse-copy!
                  vector-skip
                  vector-skip-right
                  vector-swap!
                  vector-unfold
                  vector-unfold-right
                  vector=))))
  (cond-expand
    (guile (import (only (srfi srfi-45) eager lazy)))
    (else (import (only (srfi 45) eager lazy))))
  (cond-expand
    (guile (import
             (only (srfi srfi-60)
                   any-bits-set?
                   arithmetic-shift
                   ash
                   bit-count
                   bit-field
                   bit-set?
                   bitwise-and
                   bitwise-if
                   bitwise-ior
                   bitwise-merge
                   bitwise-not
                   bitwise-xor
                   booleans->integer
                   copy-bit
                   copy-bit-field
                   first-set-bit
                   integer->list
                   integer-length
                   list->integer
                   log2-binary-factors
                   logand
                   logbit?
                   logcount
                   logior
                   logtest
                   logxor
                   reverse-bit-field
                   rotate-bit-field)))
    (else (import
            (only (srfi 60)
                  any-bits-set?
                  arithmetic-shift
                  ash
                  bit-count
                  bit-field
                  bit-set?
                  bitwise-and
                  bitwise-if
                  bitwise-ior
                  bitwise-merge
                  bitwise-not
                  bitwise-xor
                  booleans->integer
                  copy-bit
                  copy-bit-field
                  first-set-bit
                  integer->list
                  integer-length
                  list->integer
                  log2-binary-factors
                  logand
                  logbit?
                  logcount
                  logior
                  logtest
                  logxor
                  reverse-bit-field
                  rotate-bit-field))))
  (cond-expand
    (guile (import
             (only (srfi srfi-64)
                   test-apply
                   test-approximate
                   test-assert
                   test-begin
                   test-end
                   test-eq
                   test-equal
                   test-eqv
                   test-error
                   test-expect-fail
                   test-group
                   test-group-with-cleanup
                   test-log-to-file
                   test-match-all
                   test-match-any
                   test-match-name
                   test-match-nth
                   test-on-bad-count-simple
                   test-on-bad-end-name-simple
                   test-on-final-simple
                   test-on-group-begin-simple
                   test-on-group-end-simple
                   test-on-test-end-simple
                   test-passed?
                   test-read-eval-string
                   test-result-alist
                   test-result-alist!
                   test-result-clear
                   test-result-kind
                   test-result-ref
                   test-result-remove
                   test-result-set!
                   test-runner-aux-value
                   test-runner-aux-value!
                   test-runner-create
                   test-runner-current
                   test-runner-factory
                   test-runner-fail-count
                   test-runner-fail-count!
                   test-runner-get
                   test-runner-group-path
                   test-runner-group-stack
                   test-runner-group-stack!
                   test-runner-null
                   test-runner-on-bad-count
                   test-runner-on-bad-count!
                   test-runner-on-bad-end-name
                   test-runner-on-bad-end-name!
                   test-runner-on-final
                   test-runner-on-final!
                   test-runner-on-group-begin
                   test-runner-on-group-begin!
                   test-runner-on-group-end
                   test-runner-on-group-end!
                   test-runner-on-test-begin
                   test-runner-on-test-begin!
                   test-runner-on-test-end
                   test-runner-on-test-end!
                   test-runner-pass-count
                   test-runner-pass-count!
                   test-runner-reset
                   test-runner-simple
                   test-runner-skip-count
                   test-runner-skip-count!
                   test-runner-test-name
                   test-runner-xfail-count
                   test-runner-xfail-count!
                   test-runner-xpass-count
                   test-runner-xpass-count!
                   test-runner?
                   test-skip
                   test-with-runner)))
    (else (import
            (only (srfi 64)
                  test-apply
                  test-approximate
                  test-assert
                  test-begin
                  test-end
                  test-eq
                  test-equal
                  test-eqv
                  test-error
                  test-expect-fail
                  test-group
                  test-group-with-cleanup
                  test-log-to-file
                  test-match-all
                  test-match-any
                  test-match-name
                  test-match-nth
                  test-on-bad-count-simple
                  test-on-bad-end-name-simple
                  test-on-final-simple
                  test-on-group-begin-simple
                  test-on-group-end-simple
                  test-on-test-end-simple
                  test-passed?
                  test-read-eval-string
                  test-result-alist
                  test-result-alist!
                  test-result-clear
                  test-result-kind
                  test-result-ref
                  test-result-remove
                  test-result-set!
                  test-runner-aux-value
                  test-runner-aux-value!
                  test-runner-create
                  test-runner-current
                  test-runner-factory
                  test-runner-fail-count
                  test-runner-fail-count!
                  test-runner-get
                  test-runner-group-path
                  test-runner-group-stack
                  test-runner-group-stack!
                  test-runner-null
                  test-runner-on-bad-count
                  test-runner-on-bad-count!
                  test-runner-on-bad-end-name
                  test-runner-on-bad-end-name!
                  test-runner-on-final
                  test-runner-on-final!
                  test-runner-on-group-begin
                  test-runner-on-group-begin!
                  test-runner-on-group-end
                  test-runner-on-group-end!
                  test-runner-on-test-begin
                  test-runner-on-test-begin!
                  test-runner-on-test-end
                  test-runner-on-test-end!
                  test-runner-pass-count
                  test-runner-pass-count!
                  test-runner-reset
                  test-runner-simple
                  test-runner-skip-count
                  test-runner-skip-count!
                  test-runner-test-name
                  test-runner-xfail-count
                  test-runner-xfail-count!
                  test-runner-xpass-count
                  test-runner-xpass-count!
                  test-runner?
                  test-skip
                  test-with-runner))))
  (cond-expand
    (guile (import
             (only (srfi srfi-67)
                   </<=?
                   </<?
                   <=/<=?
                   <=/<?
                   <=?
                   <?
                   =?
                   >/>=?
                   >/>?
                   >=/>=?
                   >=/>?
                   >=?
                   >?
                   boolean-compare
                   chain<=?
                   chain<?
                   chain=?
                   chain>=?
                   chain>?
                   char-compare
                   char-compare-ci
                   compare-by<
                   compare-by<=
                   compare-by=/<
                   compare-by=/>
                   compare-by>
                   compare-by>=
                   complex-compare
                   cond-compare
                   debug-compare
                   default-compare
                   if-not=?
                   if3
                   if<=?
                   if<?
                   if=?
                   if>=?
                   if>?
                   integer-compare
                   kth-largest
                   list-compare
                   list-compare-as-vector
                   max-compare
                   min-compare
                   not=?
                   number-compare
                   pair-compare
                   pair-compare-car
                   pair-compare-cdr
                   pairwise-not=?
                   rational-compare
                   real-compare
                   refine-compare
                   select-compare
                   string-compare
                   string-compare-ci
                   symbol-compare
                   vector-compare
                   vector-compare-as-list)))
    (else (import
            (only (srfi 67)
                  </<=?
                  </<?
                  <=/<=?
                  <=/<?
                  <=?
                  <?
                  =?
                  >/>=?
                  >/>?
                  >=/>=?
                  >=/>?
                  >=?
                  >?
                  boolean-compare
                  chain<=?
                  chain<?
                  chain=?
                  chain>=?
                  chain>?
                  char-compare
                  char-compare-ci
                  compare-by<
                  compare-by<=
                  compare-by=/<
                  compare-by=/>
                  compare-by>
                  compare-by>=
                  complex-compare
                  cond-compare
                  debug-compare
                  default-compare
                  if-not=?
                  if3
                  if<=?
                  if<?
                  if=?
                  if>=?
                  if>?
                  integer-compare
                  kth-largest
                  list-compare
                  list-compare-as-vector
                  max-compare
                  min-compare
                  not=?
                  number-compare
                  pair-compare
                  pair-compare-car
                  pair-compare-cdr
                  pairwise-not=?
                  rational-compare
                  real-compare
                  refine-compare
                  select-compare
                  string-compare
                  string-compare-ci
                  symbol-compare
                  vector-compare
                  vector-compare-as-list))))
  (cond-expand
    (guile (import
             (only (srfi srfi-71)
                   uncons
                   unlist
                   unvector
                   values->list
                   values->vector)))
    (else (import
            (only (srfi 71)
                  uncons
                  unlist
                  unvector
                  values->list
                  values->vector))))
  (cond-expand
    (guile (import (only (srfi srfi-8) receive)))
    (else (import (only (srfi 8) receive))))
  (cond-expand
    (guile (import
             (only (srfi srfi-88)
                   keyword->string
                   keyword?
                   string->keyword)))
    (else (import
            (only (srfi 88)
                  keyword->string
                  keyword?
                  string->keyword))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-compilation.scm")))
    (else (include "test-compilation.scm"))))
