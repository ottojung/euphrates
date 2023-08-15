
# Euphrates: nourishing projects

## Introduction

Euphrates is a standard library/computing environment for Scheme.

Euphrates is similar to:

- [SLIB](https://people.csail.mit.edu/jaffer/SLIB.html)
- [Scmutils](https://groups.csail.mit.edu/mac/users/gjs/6946/installation.html)
- [Schemepunk](https://github.com/ar-nelson/schemepunk)
- [Spells](https://github.com/rotty/spells/tree/master/spells)
- [Alschemist](https://github.com/ashinn/alschemist)
- [Xitomatl](https://github.com/weinholt/xitomatl)
- [Riastradh](https://github.com/arcfide/riastradh)
- [Ocelotl](https://github.com/rotty/ocelotl)

in that it contains various common functionalities that can be used independently
from the rest of the library.

However, some of the things that Euphrates provides are deeply connected.
For example: subprocesses and petri-nets abstract over threading systems
using dynamic threading implementation of Euphrates.

## Content

Here's a snapshot of what Euphrates offers:

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

...and much more.

The code is predominantly R<sup>7</sup>RS Scheme,
with GNU Guile being the primary target.

## Getting Started

To explore how to use functionalities implemented in `src/euphrates/name.scm`,
refer to the corresponding examples in `test/test-name.scm`.

## Licensing

Euphrates is licensed under the GPL-3.
