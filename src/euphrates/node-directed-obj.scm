
(cond-expand
 (guile
  (define-module (euphrates node-directed-obj)
    :export (node/directed node/directed? node/directed-children set-node/directed-children! node/directed-label set-node/directed-label!)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 <n>
  (node/directed label children) node/directed?
  (label node/directed-label set-node/directed-label!)
  (children node/directed-children set-node/directed-children!)
  )
