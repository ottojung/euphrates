
# Euphrates

## Introduction

Euphrates is a standard library/computing environment for Scheme.

Euphrates is similar to:

- [SLIB](https://people.csail.mit.edu/jaffer/SLIB.html)
- [Schemepunk](https://github.com/ar-nelson/schemepunk)
- [Scmutils](https://groups.csail.mit.edu/mac/users/gjs/6946/installation.html)
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

- CFG-based CLI parsing `define-cli.scm`
- Object system based on properties constraints `properties.scm`
  - similar to propagators but less (computationally) expensive, and time-aware
- A fast LALR+GLR parser generator `parselynn.scm`
  - with a simplified interface (ex. irregex-based lexer) - `parselynn-simple.scm`
- Embedabble mini prolog `profun.scm`
- Composable monads `monadic.scm`
  - work kind of like `Redux`, but more powerful thanks to macros and continuations
  - suppport Haskell-like DSL for do-notation
- Petri networks `petri.scm`
  - with `profun` integration `petri-net-parse-profun.scm`
- Dynamic threading environment `dynamic-thread-*.scm`
  - with an implementaion of non-preemptive portable threads `np-thread.scm`
- Simple subprocesses `run-asyncproc.scm`
- JSON parser `json-parse.scm`
- Lots of list functions `list-*.scm`
- Number conversions `convert-number-base.scm` and `*radix*.scm`
- Various alphabets `*-alphabet.scm`

...and much more.

The code is predominantly R<sup>7</sup>RS Scheme,
with GNU Guile being the primary target.

## Getting Started

To explore how to use functionalities implemented in `src/euphrates/name.scm`,
refer to the corresponding examples in `test/test-name.scm`.

## Licensing

Euphrates is licensed under the GPL-3.
