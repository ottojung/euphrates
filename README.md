
## What is this

Personal all-in-one library for schemes.

## Content

- CFG-based CLI parsing `src/define-cli.scm`
- Embedabble mini prolog `src/profun.scm`
- Composable monads `src/monadic.scm`
  - work kind of like `Redux`, but more powerful thanks to macros and continuations
  - suppport Haskell-like DSL for do-notation
- JSON parser `src/json-parse.scm`
- Petri networks `src/petri.scm`
  - with `profun` integration `src/petri-net-parse-profun.scm`
- Dynamic threading environment `src/dynamic-thread-*.scm`
  - with an implementaion of non-preemptive portable threads `src/np-thread.scm`
- Number conversions `src/convert-number-base.scm` and `src/number-list.scm`
- Simple subprocesses `src/run-asyncproc.scm`
- Various alphabets `src/*-alphabet.scm`
- Lots of list functions `src/list-*.scm`

## How to use

Look into `test/main.scm` for examples/specification.

Use `czempak` to import stuff.

## License

GPL-3

## TODO

- [ ] GUI library targeting the browser
  - [ ] alternatively - many targets
- [x] Add monads back
- [ ] Add `tree-future` back
- [ ] Handle $PWD the way Racket does
- [ ] Move `szcalc`'s core rewriting system here
- [ ] Make system threads parameterizable, so make an `np-parameterize-env` equivalent for `sys-thread.scm`
- [ ] Port everything to other scheme compilers (this involves making czempak runners for them)
  - [x] Guile
  - [ ] Racket
  - [ ] Chez
  - [ ] Chibi
  - [ ] Cyclone
- [ ] Split tests
- [ ] Add `cut!` to `profun`
- [x] Add recursion to `profun`
- [ ] Add structures to `profun`. Simple `cons` should be very easy to implement
- [x] Steal regular expressions https://synthcode.com/scheme/irregex/
- [ ] Steal matcher https://synthcode.com/scheme/match.scm but simplify it
- [ ] Add prolog to shell integration, a-la https://github.com/thomasrebele/bashlog
- [ ] Add `(optional EXPR)` and `(required EXPR)` to `define-cli`
- [ ] Add subparsers to `define-cli`
- [ ] Change "<name...>" syntax to "<name*>" syntax in `define-cli`
- [ ] Profun: return results by iterating free variables of the input query, instead of by iterating all env variables
