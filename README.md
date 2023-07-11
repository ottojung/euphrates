
## What is this

Library of common functionalities for use in Scheme projects.

Similar to

- [SLIB](https://people.csail.mit.edu/jaffer/SLIB.html)
- [Scmutils](https://groups.csail.mit.edu/mac/users/gjs/6946/installation.html)
- [Schemepunk](https://github.com/ar-nelson/schemepunk)
- [Spells](https://github.com/rotty/spells/tree/master/spells)
- [Alschemist](https://github.com/ashinn/alschemist)

## Content

- CFG-based CLI parsing `src/define-cli.scm`
- Object system based on properties constraints `src/properties.scm`
  - Similar to propagators but less (computationally) expensive, and time-aware
- Embedabble mini prolog `src/profun.scm`
- Composable monads `src/monadic.scm`
  - work kind of like `Redux`, but more powerful thanks to macros and continuations
  - suppport Haskell-like DSL for do-notation
- Petri networks `src/petri.scm`
  - with `profun` integration `src/petri-net-parse-profun.scm`
- Dynamic threading environment `src/dynamic-thread-*.scm`
  - with an implementaion of non-preemptive portable threads `src/np-thread.scm`
- Simple subprocesses `src/run-asyncproc.scm`
- JSON parser `src/json-parse.scm`
- Lots of list functions `src/list-*.scm`
- Number conversions `src/convert-number-base.scm` and `src/number-list.scm`
- Various alphabets `src/*-alphabet.scm`

## How to use

Look into `test/test-<functionality-name>.scm` for examples.

## License

GPL-3
