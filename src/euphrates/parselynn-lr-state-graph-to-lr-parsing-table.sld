
(define-library
  (euphrates
    parselynn-lr-state-graph-to-lr-parsing-table)
  (export
    parselynn:lr-state-graph->lr-parsing-table)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates bnf-alist-empty-huh)
          bnf-alist:empty?))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import
    (only (euphrates bnf-alist-start-symbol)
          bnf-alist:start-symbol))
  (import
    (only (euphrates bnf-alist-terminals)
          bnf-alist:terminals))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates lenode) lenode:get-child))
  (import (only (euphrates olgraph) olnode:value))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import
    (only (euphrates parselynn-lr-accept-action)
          parselynn:lr-accept-action:make))
  (import
    (only (euphrates parselynn-lr-goto-action)
          parselynn:lr-goto-action:make))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:dot-at-end?
          parselynn:lr-item:left-hand-side
          parselynn:lr-item:lookahead
          parselynn:lr-item:production))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:action:add!
          parselynn:lr-parsing-table:goto:set!
          parselynn:lr-parsing-table:make
          parselynn:lr-parsing-table:state:add!))
  (import
    (only (euphrates parselynn-lr-reduce-action)
          parselynn:lr-reduce-action:make))
  (import
    (only (euphrates parselynn-lr-shift-action)
          parselynn:lr-shift-action:make))
  (import
    (only (euphrates parselynn-lr-state-graph-traverse)
          parselynn:lr-state-graph:traverse))
  (import
    (only (euphrates parselynn-lr-state-graph)
          parselynn:lr-state-graph:node-id
          parselynn:lr-state-graph:start))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:foreach-item))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          and
          begin
          cond
          define
          else
          equal?
          for-each
          if
          lambda
          let
          list
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state-graph-to-lr-parsing-table.scm")))
    (else (include
            "parselynn-lr-state-graph-to-lr-parsing-table.scm"))))
