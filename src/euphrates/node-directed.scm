
(cond-expand
 (guile
  (define-module (euphrates node-directed)
    :export (make-node/directed)
    :use-module ((euphrates node-directed-obj) :select (node/directed node/directed? node/directed-children set-node/directed-children! node/directed-label set-node/directed-label!)))))



(define (make-node/directed label children)
  (node/directed label children))
