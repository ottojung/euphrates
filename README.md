
## What is this

Personal all-in-one library for schemes.

## Content

- CFG-based CLI parsing `src/define-cli.scm`
- Embedabble mini prolog `src/profun.scm`
- Dynamic threading environment `src/dynamic-thread-*.scm`
  - with default being portable, non-preemptive threads `src/np-thread.scm`
- Number conversions `src/convert-number-base.scm` and `src/number-list.scm`
- Simple subprocesses `src/run-comprocess.scm`
- Various alphabets `src/*-alphabet.scm`
- Lots of list functions `src/list-*.scm`

## How to use

Look into `test/main.scm` for examples/specification.

Use `czempak` to import stuff.

## License

GPL-3
