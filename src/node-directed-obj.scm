
%run guile

%var node/directed
%var node/directed?
%var node/directed-children
%var set-node/directed-children!
%var node/directed-label
%var set-node/directed-label!

%use (define-type9) "./define-type9.scm"

(define-type9 <n>
  (node/directed label children) node/directed?
  (label node/directed-label set-node/directed-label!)
  (children node/directed-children set-node/directed-children!)
  )
