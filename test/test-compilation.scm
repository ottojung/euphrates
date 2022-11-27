
%run guile


%use (absolute-posix-path?) "./src/absolute-posix-path-q.scm"
%use (alpha/alphabet) "./src/alpha-alphabet.scm"
%use (alpha-lowercase/alphabet) "./src/alpha-lowercase-alphabet.scm"
%use (alphanum/alphabet alphanum/alphabet/index) "./src/alphanum-alphabet.scm"
%use (alphanum-lowercase/alphabet) "./src/alphanum-lowercase-alphabet.scm"
%use (append-posix-path) "./src/append-posix-path.scm"
%use (append-string-file) "./src/append-string-file.scm"
%use (apploop) "./src/apploop.scm"
%use (assert=HS) "./src/assert-equal-hs.scm"
%use (assert=) "./src/assert-equal.scm"
%use (assert#raw) "./src/assert-raw.scm"
%use (assert) "./src/assert.scm"
%use (assoc/any) "./src/assoc-any.scm"
%use (assoc/find) "./src/assoc-find.scm"
%use (assoc-or) "./src/assoc-or.scm"
%use (assoc-set-default) "./src/assoc-set-default.scm"
%use (assoc-set-value) "./src/assoc-set-value.scm"
%use (assq-or) "./src/assq-or.scm"
%use (assq-set-value) "./src/assq-set-value.scm"
%use (atomic-box-compare-and-set! atomic-box-ref atomic-box-set! atomic-box? make-atomic-box) "./src/atomic-box.scm"
%use (base64/alphabet/minusunderscore) "./src/base64-alphabet-minusunderscore.scm"
%use (base64/alphabet/pluscomma) "./src/base64-alphabet-pluscomma.scm"
%use (base64/alphabet) "./src/base64-alphabet.scm"
%use (big-random-int) "./src/big-random-int.scm"
%use (bool->profun-result) "./src/bool-to-profun-result.scm"
%use (box-ref box-set! box? make-box) "./src/box.scm"
%use (builtin-descriptors) "./src/builtin-descriptors.scm"
%use (builtin-type?) "./src/builtin-type-huh.scm"
%use (call-with-finally) "./src/call-with-finally.scm"
%use (cartesian-any?) "./src/cartesian-any-q.scm"
%use (cartesian-each) "./src/cartesian-each.scm"
%use (cartesian-map) "./src/cartesian-map.scm"
%use (cartesian-product/g cartesian-product/g/reversed) "./src/cartesian-product-g.scm"
%use (cartesian-product) "./src/cartesian-product.scm"
%use (catch-any) "./src/catch-any.scm"
%use (catchu-case) "./src/catchu-case.scm"
%use (make-cfg-machine make-cfg-machine* make-cfg-machine/full) "./src/cfg-machine.scm"
%use (command-line-argumets/p) "./src/command-line-arguments-p.scm"
%use (appcomp comp) "./src/comp.scm"
%use (CFG-AST->CFG-CLI-help) "./src/compile-cfg-cli-help.scm"
%use (CFG-AST->CFG-lang CFG-CLI->CFG-lang CFG-lang-modifier-char?) "./src/compile-cfg-cli.scm"
%use (compile-regex-cli:IR->Regex compile-regex-cli:make-IR) "./src/compile-regex-cli.scm"
%use (compose-under-par) "./src/compose-under-par.scm"
%use (compose-under) "./src/compose-under.scm"
%use (comprocess-stderr) "./src/comprocess-stderr.scm"
%use (comprocess-stdout) "./src/comprocess-stdout.scm"
%use (comprocess comprocess-args comprocess-command comprocess-exited? comprocess-pid comprocess-pipe comprocess-status comprocess? set-comprocess-exited?! set-comprocess-pid! set-comprocess-pipe! set-comprocess-status!) "./src/comprocess.scm"
%use (cons!) "./src/cons-bang.scm"
%use (conss) "./src/conss.scm"
%use (convert-number-base convert-number-base/generic convert-number-base:default-max-base) "./src/convert-number-base.scm"
%use (current-directory/p) "./src/current-directory-p.scm"
%use (current-program-path/p) "./src/current-program-path-p.scm"
%use (current-random-source/p) "./src/current-random-source-p.scm"
%use (current-source-info->string) "./src/current-source-info-to-string.scm"
%use (curry-if) "./src/curry-if.scm"
%use (date-get-current-string) "./src/date-get-current-string.scm"
%use (date-get-current-time24h-string) "./src/date-get-current-time24h-string.scm"
%use (debug) "./src/debug.scm"
%use (debugs) "./src/debugs.scm"
%use (debugv) "./src/debugv.scm"
%use (define-cli:raisu/default-exit define-cli:raisu/p define-cli:show-help lambda-cli make-cli make-cli-with-handler make-cli/f make-cli/f/basic with-cli) "./src/define-cli.scm"
%use (define-dumb-record) "./src/define-dumb-record.scm"
%use (define-newtype) "./src/define-newtype.scm"
%use (define-pair) "./src/define-pair.scm"
%use (define-tuple) "./src/define-tuple.scm"
%use (define-type9 define-type9/nobind-descriptor type9-get-descriptor-by-name type9-get-record-descriptor) "./src/define-type9.scm"
%use (descriptors-registry-get descriptors-registry-set! descritors-registry-decolisify-name) "./src/descriptors-registry.scm"
%use (directory-files-depth-foreach) "./src/directory-files-depth-foreach.scm"
%use (directory-files-depth-iter) "./src/directory-files-depth-iter.scm"
%use (directory-files-rec/filter) "./src/directory-files-rec-filter.scm"
%use (directory-files-rec) "./src/directory-files-rec.scm"
%use (directory-files) "./src/directory-files.scm"
%use (directory-mtime-state) "./src/directory-mtime-state.scm"
%use (directory-tree) "./src/directory-tree.scm"
%use (dprint#p-default) "./src/dprint-p-default.scm"
%use (dprint#p) "./src/dprint-p.scm"
%use (dprint) "./src/dprint.scm"
%use (dprintln) "./src/dprintln.scm"
%use (dynamic-thread-async-thunk) "./src/dynamic-thread-async-thunk.scm"
%use (dynamic-thread-async) "./src/dynamic-thread-async.scm"
%use (dynamic-thread-cancel#p) "./src/dynamic-thread-cancel-p.scm"
%use (dynamic-thread-cancel-tag) "./src/dynamic-thread-cancel-tag.scm"
%use (dynamic-thread-cancel) "./src/dynamic-thread-cancel.scm"
%use (dynamic-thread-critical-make#p-default) "./src/dynamic-thread-critical-make-p-default.scm"
%use (dynamic-thread-critical-make#p) "./src/dynamic-thread-critical-make-p.scm"
%use (dynamic-thread-critical-make) "./src/dynamic-thread-critical-make.scm"
%use (dynamic-thread-disable-cancel#p-default) "./src/dynamic-thread-disable-cancel-p-default.scm"
%use (dynamic-thread-disable-cancel#p) "./src/dynamic-thread-disable-cancel-p.scm"
%use (dynamic-thread-disable-cancel) "./src/dynamic-thread-disable-cancel.scm"
%use (dynamic-thread-enable-cancel#p-default) "./src/dynamic-thread-enable-cancel-p-default.scm"
%use (dynamic-thread-enable-cancel#p) "./src/dynamic-thread-enable-cancel-p.scm"
%use (dynamic-thread-enable-cancel) "./src/dynamic-thread-enable-cancel.scm"
%use (dynamic-thread-get-delay-procedure#p-default) "./src/dynamic-thread-get-delay-procedure-p-default.scm"
%use (dynamic-thread-get-delay-procedure#p) "./src/dynamic-thread-get-delay-procedure-p.scm"
%use (dynamic-thread-get-delay-procedure) "./src/dynamic-thread-get-delay-procedure.scm"
%use (dynamic-thread-get-wait-delay) "./src/dynamic-thread-get-wait-delay.scm"
%use (dynamic-thread-get-yield-procedure) "./src/dynamic-thread-get-yield-procedure.scm"
%use (dynamic-thread-mutex-lock!#p-default) "./src/dynamic-thread-mutex-lock-p-default.scm"
%use (dynamic-thread-mutex-lock!#p) "./src/dynamic-thread-mutex-lock-p.scm"
%use (dynamic-thread-mutex-lock!) "./src/dynamic-thread-mutex-lock.scm"
%use (dynamic-thread-mutex-make#p-default) "./src/dynamic-thread-mutex-make-p-default.scm"
%use (dynamic-thread-mutex-make#p) "./src/dynamic-thread-mutex-make-p.scm"
%use (dynamic-thread-mutex-make) "./src/dynamic-thread-mutex-make.scm"
%use (dynamic-thread-mutex-unlock!#p-default) "./src/dynamic-thread-mutex-unlock-p-default.scm"
%use (dynamic-thread-mutex-unlock!#p) "./src/dynamic-thread-mutex-unlock-p.scm"
%use (dynamic-thread-mutex-unlock!) "./src/dynamic-thread-mutex-unlock.scm"
%use (dynamic-thread-sleep#p-default) "./src/dynamic-thread-sleep-p-default.scm"
%use (dynamic-thread-sleep#p) "./src/dynamic-thread-sleep-p.scm"
%use (dynamic-thread-sleep) "./src/dynamic-thread-sleep.scm"
%use (dynamic-thread-spawn#p) "./src/dynamic-thread-spawn-p.scm"
%use (dynamic-thread-spawn) "./src/dynamic-thread-spawn.scm"
%use (dynamic-thread-wait-delay#us#p-default) "./src/dynamic-thread-wait-delay-p-default.scm"
%use (dynamic-thread-wait-delay#us#p) "./src/dynamic-thread-wait-delay-p.scm"
%use (dynamic-thread-yield#p-default) "./src/dynamic-thread-yield-p-default.scm"
%use (dynamic-thread-yield#p) "./src/dynamic-thread-yield-p.scm"
%use (dynamic-thread-yield) "./src/dynamic-thread-yield.scm"
%use (eval-in-current-namespace) "./src/eval-in-current-namespace.scm"
%use (exception-monad) "./src/exception-monad.scm"
%use (fast-parameterizeable-timestamp/p) "./src/fast-parameterizeable-timestamp-p.scm"
%use (file-delete) "./src/file-delete.scm"
%use (file-is-directory?/no-readlink) "./src/file-is-directory-q-no-readlink.scm"
%use (file-is-regular-file?/no-readlink) "./src/file-is-regular-file-q-no-readlink.scm"
%use (file-mtime) "./src/file-mtime.scm"
%use (file-or-directory-exists?) "./src/file-or-directory-exists-q.scm"
%use (file-size) "./src/file-size.scm"
%use (filter-monad) "./src/filter-monad.scm"
%use (fn-cons) "./src/fn-cons.scm"
%use (fn-pair) "./src/fn-pair.scm"
%use (fn-tuple) "./src/fn-tuple.scm"
%use (fn) "./src/fn.scm"
%use (fp) "./src/fp.scm"
%use (get-command-line-arguments) "./src/get-command-line-arguments.scm"
%use (get-current-directory) "./src/get-current-directory.scm"
%use (get-current-program-path) "./src/get-current-program-path.scm"
%use (get-current-random-source) "./src/get-current-random-source.scm"
%use (get-current-source-file-path) "./src/get-current-source-file-path.scm"
%use (get-current-source-info) "./src/get-current-source-info.scm"
%use (get-directory-name) "./src/get-directory-name.scm"
%use (get-object-descriptor) "./src/get-object-descriptor.scm"
%use (global-debug-mode-filter) "./src/global-debug-mode-filter.scm"
%use (group-by/sequential group-by/sequential*) "./src/group-by-sequential.scm"
%use (hashmap-constructor hashmap-predicate) "./src/hashmap-obj.scm"
%use (alist->hashmap hashmap->alist hashmap-clear! hashmap-copy hashmap-count hashmap-delete! hashmap-foreach hashmap-has? hashmap-map hashmap-merge hashmap-merge! hashmap-ref hashmap-set! hashmap? make-hashmap multi-alist->hashmap) "./src/hashmap.scm"
%use (hashset-constructor hashset-predicate hashset-value) "./src/hashset-obj.scm"
%use (hashset->list hashset-add! hashset-clear! hashset-delete! hashset-difference hashset-equal? hashset-foreach hashset-has? hashset-intersection hashset-length hashset-map hashset-ref hashset-union list->hashset make-hashset vector->hashset) "./src/hashset.scm"
%use (identity-monad) "./src/identity-monad.scm"
%use (identity*) "./src/identity-star.scm"
%use (immutable-hashmap-constructor immutable-hashmap-predicate immutable-hashmap-value) "./src/immutable-hashmap-obj.scm"
%use (alist->immutable-hashmap immutable-hashmap->alist immutable-hashmap-clear immutable-hashmap-copy immutable-hashmap-count immutable-hashmap-foreach immutable-hashmap-fromlist immutable-hashmap-map immutable-hashmap-ref immutable-hashmap-ref/first immutable-hashmap-set immutable-hashmap? make-immutable-hashmap) "./src/immutable-hashmap.scm"
%use (json-parse) "./src/json-parse.scm"
%use (lazy-monad) "./src/lazy-monad.scm"
%use (lazy-parameter) "./src/lazy-parameter.scm"
%use (letin) "./src/letin.scm"
%use (lexical-scope-unwrap lexical-scope-wrap lexical-scope?) "./src/lexical-scope-obj.scm"
%use (lexical-scope-make lexical-scope-namespace lexical-scope-ref lexical-scope-set! lexical-scope-stage! lexical-scope-unstage!) "./src/lexical-scope.scm"
%use (linear-interpolate-1d linear-interpolate-2d) "./src/linear-interpolation.scm"
%use (lines->string) "./src/lines-to-string.scm"
%use (linux-get-memory-free% linux-get-memory-stat) "./src/linux-get-memory-stat.scm"
%use (list-and-map) "./src/list-and-map.scm"
%use (list-break) "./src/list-break.scm"
%use (list-chunks) "./src/list-chunks.scm"
%use (list-combinations) "./src/list-combinations.scm"
%use (list-deduplicate list-deduplicate/reverse) "./src/list-deduplicate.scm"
%use (list-drop-n) "./src/list-drop-n.scm"
%use (list-drop-while) "./src/list-drop-while.scm"
%use (list-find-first) "./src/list-find-first.scm"
%use (list-fold*) "./src/list-fold-star.scm"
%use (list-fold) "./src/list-fold.scm"
%use (list-group-by) "./src/list-group-by.scm"
%use (list-init) "./src/list-init.scm"
%use (list-insert-at) "./src/list-insert-at.scm"
%use (list-intersperse) "./src/list-intersperse.scm"
%use (list-last) "./src/list-last.scm"
%use (list-length=) "./src/list-length-eq.scm"
%use (list-length=<?) "./src/list-length-geq-q.scm"
%use (list-levenshtein-distance) "./src/list-levenshtein-distance.scm"
%use (list-map-first) "./src/list-map-first.scm"
%use (list-map/flatten) "./src/list-map-flatten.scm"
%use (list-maximal-element-or) "./src/list-maximal-element-or.scm"
%use (list-minimal-element-or) "./src/list-minimal-element-or.scm"
%use (list-or-map) "./src/list-or-map.scm"
%use (list-partition) "./src/list-partition.scm"
%use (list-permutations) "./src/list-permutations.scm"
%use (list-prefix?) "./src/list-prefix-q.scm"
%use (list-random-element) "./src/list-random-element.scm"
%use (list-random-shuffle) "./src/list-random-shuffle.scm"
%use (list-ref-or) "./src/list-ref-or.scm"
%use (list-remove-common-prefix) "./src/list-remove-common-prefix.scm"
%use (list-replace-last-element) "./src/list-replace-last.scm"
%use (list-singleton?) "./src/list-singleton-q.scm"
%use (list-span-n) "./src/list-span-n.scm"
%use (list-span-while) "./src/list-span-while.scm"
%use (list-span) "./src/list-span.scm"
%use (list-split-on) "./src/list-split-on.scm"
%use (list-tag/next list-tag/next/rev list-untag/next) "./src/list-tag-next.scm"
%use (list-tag/prev list-tag/prev/rev) "./src/list-tag-prev.scm"
%use (list-tag list-untag) "./src/list-tag.scm"
%use (list-take-n) "./src/list-take-n.scm"
%use (list-take-while) "./src/list-take-while.scm"
%use (list->tree) "./src/list-to-tree.scm"
%use (list-traverse) "./src/list-traverse.scm"
%use (list-windows) "./src/list-windows.scm"
%use (list-zip-with) "./src/list-zip-with.scm"
%use (list-zip) "./src/list-zip.scm"
%use (log-monad) "./src/log-monad.scm"
%use (make-directories) "./src/make-directories.scm"
%use (make-temporary-filename) "./src/make-temporary-filename.scm"
%use (make-temporary-fileport) "./src/make-temporary-fileport.scm"
%use (make-unique) "./src/make-unique.scm"
%use (maybe-monad) "./src/maybe-monad.scm"
%use (ahash->mdict hash->mdict mdict mdict->alist mdict-has? mdict-keys mdict-set!) "./src/mdict.scm"
%use (memconst) "./src/memconst.scm"
%use (mimetype/extensions) "./src/mimetype-extensions.scm"
%use (monad-apply) "./src/monad-apply.scm"
%use (monad-ask) "./src/monad-ask.scm"
%use (monad-bind) "./src/monad-bind.scm"
%use (monad-compose) "./src/monad-compose.scm"
%use (monad-current/p) "./src/monad-current-p.scm"
%use (monad-do monad-do/generic) "./src/monad-do.scm"
%use (monad-make/hook) "./src/monad-make-hook.scm"
%use (monad-make/no-cont/no-fin) "./src/monad-make-no-cont-no-fin.scm"
%use (monad-make/no-cont) "./src/monad-make-no-cont.scm"
%use (monad-make/no-fin) "./src/monad-make-no-fin.scm"
%use (monad-make) "./src/monad-make.scm"
%use (monad-parameterize with-monad-left with-monad-right) "./src/monad-parameterize.scm"
%use (monad-transformer-current/p) "./src/monad-transformer-current-p.scm"
%use (monadfinobj monadfinobj-lval monadfinobj?) "./src/monadfinobj.scm"
%use (monadic-id) "./src/monadic-id.scm"
%use (monadic monadic-bare) "./src/monadic.scm"
%use (monadobj-constructor monadobj-handles-fin? monadobj-procedure monadobj-uses-continuations? monadobj?) "./src/monadobj.scm"
%use (monadstate-current/p) "./src/monadstate-current-p.scm"
%use (monadstate-arg monadstate-args monadstate-cret monadstate-cret/thunk monadstate-handle-multiple monadstate-lval monadstate-make-empty monadstate-qtags monadstate-qval monadstate-qvar monadstate-replicate-multiple monadstate-ret monadstate-ret/thunk monadstate?) "./src/monadstate.scm"
%use (monadstateobj monadstateobj-cont monadstateobj-lval monadstateobj-qtags monadstateobj-qval monadstateobj-qvar monadstateobj?) "./src/monadstateobj.scm"
%use (multiset-constructor multiset-predicate multiset-value) "./src/multiset-obj.scm"
%use (list->multiset make-multiset multiset->list multiset-add! multiset-equal? multiset-filter multiset-ref multiset? vector->multiset) "./src/multiset.scm"
%use (node/directed node/directed-children node/directed-label node/directed? set-node/directed-children! set-node/directed-label!) "./src/node-directed-obj.scm"
%use (make-node/directed) "./src/node-directed.scm"
%use (np-thread-obj np-thread-obj-cancel-enabled? np-thread-obj-cancel-scheduled? np-thread-obj-continuation np-thread-obj? set-np-thread-obj-cancel-scheduled?! set-np-thread-obj-continuation!) "./src/np-thread-obj.scm"
%use (np-thread-parameterize-env with-np-thread-env/non-interruptible) "./src/np-thread-parameterize.scm"
%use (np-thread-global-cancel np-thread-global-critical-make np-thread-global-disable-cancel np-thread-global-enable-cancel np-thread-global-mutex-lock! np-thread-global-mutex-make np-thread-global-mutex-unlock! np-thread-global-sleep np-thread-global-spawn np-thread-global-yield np-thread-make-env) "./src/np-thread.scm"
%use (number->number-list number->number-list:precision/p number-list->number number-list->number-list) "./src/number-list.scm"
%use (open-cond-constructor open-cond-predicate open-cond-value set-open-cond-value!) "./src/open-cond-obj.scm"
%use (define-open-cond define-open-cond-instance open-cond-lambda open-cond?) "./src/open-cond.scm"
%use (open-file-port) "./src/open-file-port.scm"
%use (make-package make-static-package use-svars with-package with-svars) "./src/package.scm"
%use (CFG-CLI->CFG-AST) "./src/parse-cfg-cli.scm"
%use (partial-apply) "./src/partial-apply.scm"
%use (partial-apply1) "./src/partial-apply1.scm"
%use (path-extension) "./src/path-extension.scm"
%use (path-extensions) "./src/path-extensions.scm"
%use (path-get-basename) "./src/path-get-basename.scm"
%use (path-get-dirname) "./src/path-get-dirname.scm"
%use (path-normalize) "./src/path-normalize.scm"
%use (path-replace-extension) "./src/path-replace-extension.scm"
%use (path-without-extension) "./src/path-without-extension.scm"
%use (patri-handle-make-callback petri-handle-get) "./src/petri-error-handling.scm"
%use (petri-net-make) "./src/petri-net-make.scm"
%use (petri-net-obj petri-net-obj-critical petri-net-obj-finished? petri-net-obj-queue petri-net-obj-transitions petri-net-obj? set-petri-net-obj-finished?!) "./src/petri-net-obj.scm"
%use (petri-profun-net) "./src/petri-net-parse-profun.scm"
%use (petri-lambda-net petri-net-parse) "./src/petri-net-parse.scm"
%use (petri-push petri-run) "./src/petri.scm"
%use (prefixtree prefixtree-children prefixtree-value prefixtree? set-prefixtree-children! set-prefixtree-value!) "./src/prefixtree-obj.scm"
%use (make-prefixtree prefixtree->tree prefixtree-ref prefixtree-ref-closest prefixtree-ref-furthest prefixtree-set!) "./src/prefixtree.scm"
%use (print-in-frame) "./src/print-in-frame.scm"
%use (print-in-window) "./src/print-in-window.scm"
%use (printable/alphabet) "./src/printable-alphabet.scm"
%use (printable/stable/alphabet) "./src/printable-stable-alphabet.scm"
%use (printf) "./src/printf.scm"
%use (make-profun-CR profun-CR-what profun-CR?) "./src/profun-CR.scm"
%use (make-profun-IDR profun-IDR-arity profun-IDR-name profun-IDR?) "./src/profun-IDR.scm"
%use (make-profun-RFC profun-RFC-add-info profun-RFC-insert profun-RFC-modify-continuation profun-RFC-reset profun-RFC-set-continuation profun-RFC-what profun-RFC?) "./src/profun-RFC.scm"
%use (make-profun-abort profun-abort-add-info profun-abort-insert profun-abort-modify-continuation profun-abort-reset profun-abort-set-continuation profun-abort-type profun-abort-what profun-abort?) "./src/profun-abort.scm"
%use (make-profun-accept profun-accept profun-accept-alist profun-accept-ctx profun-accept-ctx-changed? profun-accept? profun-ctx-set profun-set) "./src/profun-accept.scm"
%use (profun-answer?) "./src/profun-answer-huh.scm"
%use (profun-answer-join/and profun-answer-join/any profun-answer-join/or) "./src/profun-answer-join.scm"
%use (make-profun-error profun-error-args profun-error?) "./src/profun-error.scm"
%use (profun-make-handler) "./src/profun-make-handler.scm"
%use (profun-make-instantiation-check) "./src/profun-make-instantiation-test.scm"
%use (profun-make-set) "./src/profun-make-set.scm"
%use (profun-make-tuple-set) "./src/profun-make-tuple-set.scm"
%use (profun-op-apply/result#p) "./src/profun-op-apply-result-p.scm"
%use (profun-apply-fail! profun-apply-return! profun-op-apply) "./src/profun-op-apply.scm"
%use (profun-op-binary) "./src/profun-op-binary.scm"
%use (profun-op-divisible) "./src/profun-op-divisible.scm"
%use (profun-op-envlambda/p) "./src/profun-op-envlambda-p.scm"
%use (profun-op-envlambda) "./src/profun-op-envlambda.scm"
%use (profun-op-equals) "./src/profun-op-equals.scm"
%use (profun-op-eval/result#p) "./src/profun-op-eval-result-p.scm"
%use (profun-eval-fail! profun-eval-return! profun-op-eval) "./src/profun-op-eval.scm"
%use (profun-op-false) "./src/profun-op-false.scm"
%use (profun-op-function) "./src/profun-op-function.scm"
%use (profun-op-lambda) "./src/profun-op-lambda.scm"
%use (profun-op-less) "./src/profun-op-less.scm"
%use (profun-op-modulo) "./src/profun-op-modulo.scm"
%use (profun-op*) "./src/profun-op-mult.scm"
%use (profun-op-arity profun-op-constructor profun-op-procedure profun-op?) "./src/profun-op-obj.scm"
%use (instantiate-profun-parameter make-profun-parameter) "./src/profun-op-parameter.scm"
%use (profun-op+) "./src/profun-op-plus.scm"
%use (profun-op-print) "./src/profun-op-print.scm"
%use (profun-op-separate) "./src/profun-op-separate.scm"
%use (profun-op-sqrt) "./src/profun-op-sqrt.scm"
%use (profun-op-true) "./src/profun-op-true.scm"
%use (profun-op-unary) "./src/profun-op-unary.scm"
%use (profun-op-unify) "./src/profun-op-unify.scm"
%use (profun-op-value) "./src/profun-op-value.scm"
%use (make-profun-op) "./src/profun-op.scm"
%use (profun-query-get-free-variables) "./src/profun-query-get-free-variables.scm"
%use (profun-reject profun-reject?) "./src/profun-reject.scm"
%use (profun-bound-value? profun-make-constant profun-make-unbound-var profun-make-var profun-unbound-value? profun-value-name profun-value-unwrap profun-value?) "./src/profun-value.scm"
%use (profun-variable-arity-op?) "./src/profun-variable-arity-op-huh.scm"
%use (profun-variable-arity-op-keyword) "./src/profun-variable-arity-op-keyword.scm"
%use (profun-variable-arity-op) "./src/profun-variable-arity-op.scm"
%use (profun-variable-equal?) "./src/profun-variable-equal-q.scm"
%use (profun-varname?) "./src/profun-varname-q.scm"
%use (profun-create-database profun-database-add-rule! profun-database-copy profun-database? profun-eval-query profun-iterator-copy profun-iterator-db profun-iterator-insert! profun-iterator-reset! profun-make-iterator profun-next) "./src/profun.scm"
%use (profune-communications-hook/p) "./src/profune-communications-hook-p.scm"
%use (profune-communications) "./src/profune-communications.scm"
%use (make-profune-communicator profune-communicator-handle profune-communicator?) "./src/profune-communicator.scm"
%use (define-property) "./src/properties.scm"
%use (queue-constructor queue-first queue-last queue-predicate queue-vector set-queue-first! set-queue-last! set-queue-vector!) "./src/queue-obj.scm"
%use (list->queue make-queue queue->list queue-empty? queue-peek queue-peek-rotate! queue-pop! queue-push! queue-rotate! queue-unload! queue?) "./src/queue.scm"
%use (raisu) "./src/raisu.scm"
%use (random-choice) "./src/random-choice.scm"
%use (random-variable-name) "./src/random-variable-name.scm"
%use (range) "./src/range.scm"
%use (read-all-port) "./src/read-all-port.scm"
%use (read/lines) "./src/read-lines.scm"
%use (read-list) "./src/read-list.scm"
%use (read-string-file) "./src/read-string-file.scm"
%use (read-string-line) "./src/read-string-line.scm"
%use (make-regex-machine make-regex-machine* make-regex-machine/full) "./src/regex-machine.scm"
%use (remove-common-prefix) "./src/remove-common-prefix.scm"
%use (replacement-monad) "./src/replacement-monad.scm"
%use (replicate) "./src/replicate.scm"
%use (reversed-args-f) "./src/reversed-args-f.scm"
%use (reversed-args) "./src/reversed-args.scm"
%use (rtree rtree-children rtree-ref rtree-value rtree? set-rtree-children! set-rtree-ref!) "./src/rtree.scm"
%use (run-comprocess/p-default) "./src/run-comprocess-p-default.scm"
%use (run-comprocess/p) "./src/run-comprocess-p.scm"
%use (run-comprocess) "./src/run-comprocess.scm"
%use (deserialize-builtin/natural serialize-builtin/natural) "./src/serialization-builtin-natural.scm"
%use (deserialize/human serialize/human) "./src/serialization-human.scm"
%use (deserialize/runnable serialize/runnable) "./src/serialization-runnable.scm"
%use (deserialize/sexp/generic serialize/sexp/generic) "./src/serialization-sexp-generic.scm"
%use (shell-nondisrupt/alphabet shell-nondisrupt/alphabet/index) "./src/shell-nondisrupt-alphabet.scm"
%use (shell-quote/permissive) "./src/shell-quote-permissive.scm"
%use (shell-quote shell-quote/always/list) "./src/shell-quote.scm"
%use (shell-safe/alphabet shell-safe/alphabet/index) "./src/shell-safe-alphabet.scm"
%use (sleep-until) "./src/sleep-until.scm"
%use (mrg32k3a-pack-state mrg32k3a-random-integer mrg32k3a-random-range mrg32k3a-random-real mrg32k3a-unpack-state) "./src/srfi-27-backbone-generator.scm"
%use (default-random-source make-random-source random-source-make-integers random-source-make-reals random-source-pseudo-randomize! random-source-randomize! random-source-state-ref random-source-state-set! random-source?) "./src/srfi-27-generic.scm"
%use (:random-source-current-time :random-source-make :random-source-make-integers :random-source-make-reals :random-source-pseudo-randomize! :random-source-randomize! :random-source-state-ref :random-source-state-set! :random-source?) "./src/srfi-27-random-source-obj.scm"
%use (set-stack-lst! stack-constructor stack-lst stack-predicate) "./src/stack-obj.scm"
%use (list->stack stack->list stack-discard! stack-empty? stack-make stack-peek stack-pop! stack-push! stack-unload! stack?) "./src/stack.scm"
%use (string-drop-n) "./src/string-drop-n.scm"
%use (string-null-or-whitespace?) "./src/string-null-or-whitespace-p.scm"
%use (string-pad-L string-pad-R) "./src/string-pad.scm"
%use (string-plus-encode string-plus-encode/generic string-plus-encoding-make) "./src/string-plus-encode.scm"
%use (string-split-3) "./src/string-split-3.scm"
%use (string-split/simple) "./src/string-split-simple.scm"
%use (string-strip) "./src/string-strip.scm"
%use (string-take-n) "./src/string-take-n.scm"
%use (string->lines) "./src/string-to-lines.scm"
%use (string->numstring) "./src/string-to-numstring.scm"
%use (string->seconds/columned) "./src/string-to-seconds-columned.scm"
%use (string->seconds) "./src/string-to-seconds.scm"
%use (string->words) "./src/string-to-words.scm"
%use (string-trim-chars) "./src/string-trim-chars.scm"
%use (stringf) "./src/stringf.scm"
%use (syntax-append) "./src/syntax-append.scm"
%use (syntax-flatten*) "./src/syntax-flatten-star.scm"
%use (syntax-identity) "./src/syntax-identity.scm"
%use (syntax-map) "./src/syntax-map.scm"
%use (syntax-reverse) "./src/syntax-reverse.scm"
%use (syntax-tree-foreach) "./src/syntax-tree-foreach.scm"
%use (sys-mutex-lock!) "./src/sys-mutex-lock.scm"
%use (sys-mutex-make) "./src/sys-mutex-make.scm"
%use (sys-mutex-unlock!) "./src/sys-mutex-unlock.scm"
%use (sys-thread-current#p-default) "./src/sys-thread-current-p-default.scm"
%use (sys-thread-current#p) "./src/sys-thread-current-p.scm"
%use (set-sys-thread-obj-cancel-enabled?! set-sys-thread-obj-cancel-scheduled?! set-sys-thread-obj-handle! sys-thread-obj sys-thread-obj-cancel-enabled? sys-thread-obj-cancel-scheduled? sys-thread-obj-handle sys-thread-obj?) "./src/sys-thread-obj.scm"
%use (sys-thread-cancel sys-thread-current sys-thread-disable-cancel sys-thread-enable-cancel sys-thread-mutex-lock! sys-thread-mutex-make sys-thread-mutex-unlock! sys-thread-sleep sys-thread-spawn) "./src/sys-thread.scm"
%use (sys-usleep) "./src/sys-usleep.scm"
%use (system-environment-get-all) "./src/system-environment-get-all.scm"
%use (system-environment-get system-environment-set!) "./src/system-environment.scm"
%use (system-fmt) "./src/system-fmt.scm"
%use (system-re) "./src/system-re.scm"
%use (system*/exit-code) "./src/system-star-exit-code.scm"
%use (~a) "./src/tilda-a.scm"
%use (~s) "./src/tilda-s.scm"
%use (time-get-current-unixtime/values#p-default) "./src/time-get-current-unixtime-values-p-default.scm"
%use (time-get-current-unixtime/values#p) "./src/time-get-current-unixtime-values-p.scm"
%use (time-get-current-unixtime time-get-current-unixtime/values) "./src/time-get-current-unixtime.scm"
%use (time-get-fast-parameterizeable-timestamp) "./src/time-get-fast-parameterizeable-timestamp.scm"
%use (time-get-monotonic-nanoseconds-timestamp) "./src/time-get-monotonic-nanoseconds-timestamp.scm"
%use (seconds->H/M/s seconds->M/s seconds->time-string) "./src/time-to-string.scm"
%use (tree-map-leafs) "./src/tree-map-leafs.scm"
%use (un~s) "./src/un-tilda-s.scm"
%use (uni-critical-make) "./src/uni-critical.scm"
%use (make-uni-spinlock make-uni-spinlock-critical uni-spinlock-lock! uni-spinlock-unlock!) "./src/uni-spinlock.scm"
%use (gibi->gibi/unit gibi->giga/unit gibi->kibi/unit gibi->kilo/unit gibi->mebi/unit gibi->mega/unit gibi->micro/unit gibi->milli/unit gibi->nano/unit gibi->normal/unit gibi->pebi/unit gibi->peta/unit gibi->pico/unit giga->gibi/unit giga->giga/unit giga->kibi/unit giga->kilo/unit giga->mebi/unit giga->mega/unit giga->micro/unit giga->milli/unit giga->nano/unit giga->normal/unit giga->pebi/unit giga->peta/unit giga->pico/unit kibi->gibi/unit kibi->giga/unit kibi->kibi/unit kibi->kilo/unit kibi->mebi/unit kibi->mega/unit kibi->micro/unit kibi->milli/unit kibi->nano/unit kibi->normal/unit kibi->pebi/unit kibi->peta/unit kibi->pico/unit kilo->gibi/unit kilo->giga/unit kilo->kibi/unit kilo->kilo/unit kilo->mebi/unit kilo->mega/unit kilo->micro/unit kilo->milli/unit kilo->nano/unit kilo->normal/unit kilo->pebi/unit kilo->peta/unit kilo->pico/unit mebi->gibi/unit mebi->giga/unit mebi->kibi/unit mebi->kilo/unit mebi->mebi/unit mebi->mega/unit mebi->micro/unit mebi->milli/unit mebi->nano/unit mebi->normal/unit mebi->pebi/unit mebi->peta/unit mebi->pico/unit mega->gibi/unit mega->giga/unit mega->kibi/unit mega->kilo/unit mega->mebi/unit mega->mega/unit mega->micro/unit mega->milli/unit mega->nano/unit mega->normal/unit mega->pebi/unit mega->peta/unit mega->pico/unit micro->gibi/unit micro->giga/unit micro->kibi/unit micro->kilo/unit micro->mebi/unit micro->mega/unit micro->micro/unit micro->milli/unit micro->nano/unit micro->normal/unit micro->pebi/unit micro->peta/unit micro->pico/unit milli->gibi/unit milli->giga/unit milli->kibi/unit milli->kilo/unit milli->mebi/unit milli->mega/unit milli->micro/unit milli->milli/unit milli->nano/unit milli->normal/unit milli->pebi/unit milli->peta/unit milli->pico/unit nano->gibi/unit nano->giga/unit nano->kibi/unit nano->kilo/unit nano->mebi/unit nano->mega/unit nano->micro/unit nano->milli/unit nano->nano/unit nano->normal/unit nano->pebi/unit nano->peta/unit nano->pico/unit normal->gibi/unit normal->giga/unit normal->kibi/unit normal->kilo/unit normal->mebi/unit normal->mega/unit normal->micro/unit normal->milli/unit normal->nano/unit normal->normal/unit normal->pebi/unit normal->peta/unit normal->pico/unit pebi->gibi/unit pebi->giga/unit pebi->kibi/unit pebi->kilo/unit pebi->mebi/unit pebi->mega/unit pebi->micro/unit pebi->milli/unit pebi->nano/unit pebi->normal/unit pebi->pebi/unit pebi->peta/unit pebi->pico/unit peta->gibi/unit peta->giga/unit peta->kibi/unit peta->kilo/unit peta->mebi/unit peta->mega/unit peta->micro/unit peta->milli/unit peta->nano/unit peta->normal/unit peta->pebi/unit peta->peta/unit peta->pico/unit pico->gibi/unit pico->giga/unit pico->kibi/unit pico->kilo/unit pico->mebi/unit pico->mega/unit pico->micro/unit pico->milli/unit pico->nano/unit pico->normal/unit pico->pebi/unit pico->peta/unit pico->pico/unit) "./src/unit-conversions.scm"
%use (universal-lockr! universal-unlockr!) "./src/universal-lockr-unlockr.scm"
%use (universal-usleep) "./src/universal-usleep.scm"
%use (uri-encode) "./src/uri-encode.scm"
%use (uri-safe/alphabet uri-safe/alphabet/index) "./src/uri-safe-alphabet.scm"
%use (url-decompose) "./src/url-decompose.scm"
%use (url-get-hostname-and-port) "./src/url-get-hostname-and-port.scm"
%use (url-get-path) "./src/url-get-path.scm"
%use (url-get-protocol) "./src/url-get-protocol.scm"
%use (url-goto) "./src/url-goto.scm"
%use (make-usymbol usymbol-name usymbol-qualifier usymbol?) "./src/usymbol.scm"
%use (vector-random-shuffle!) "./src/vector-random-shuffle-bang.scm"
%use (with-critical) "./src/with-critical.scm"
%use (with-dynamic-set!) "./src/with-dynamic-set.scm"
%use (with-dynamic) "./src/with-dynamic.scm"
%use (with-ignore-errors!) "./src/with-ignore-errors.scm"
%use (with-monad) "./src/with-monad.scm"
%use (with-randomizer-seed) "./src/with-randomizer-seed.scm"
%use (words->string) "./src/words-to-string.scm"
%use (write-string-file) "./src/write-string-file.scm"

(+ 2 2)
