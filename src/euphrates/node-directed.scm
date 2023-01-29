
%run guile

%use (node/directed node/directed? node/directed-children set-node/directed-children! node/directed-label set-node/directed-label!) "./node-directed-obj.scm"

%var make-node/directed

(define (make-node/directed label children)
  (node/directed label children))
