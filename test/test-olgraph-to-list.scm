
;; Create ordered list graph for testing
(define olgraph-test
  (let ((graph (make-olgraph '())))
    (let ((node1 (make-olnode 1))
          (node2 (make-olnode 2))
          (node3 (make-olnode 3))
          (node4 (make-olnode 4)))
      (olnode:prepend-child! node1 node2)
      (olnode:prepend-child! node1 node3)
      (olnode:prepend-child! node3 node4)
      (olgraph:prepend-initial! graph node1)
      graph)))


;; Test case: Normal operation
;; Test a graph with single branch
(let ((node1 (make-olnode 1))
      (node2 (make-olnode 2))
      (node3 (make-olnode 3)))
  (olnode:prepend-child! node1 node2)
  (olnode:prepend-child! node2 node3)
  (assert-equal
      (olnode->list node1)
      '(1    ; root node
        (2  ; child of root
         (3    ; child of 2nd node
          )))))

;; Test case: Multiple branches
;; Use graph built above for this test
(assert-equal
    (olnode->list (olgraph:initial olgraph-test))
    '(1   ; root node
      (2) ; 1st child
      (3   ; 2nd child
       (4)))) ; child of 2nd child

;; Test case: Leaf node (no branches)
(let ((node1 (make-olnode 1)))
  (assert-equal
    (olnode->list node1)
    '(1))) ; single node, no children

;; Test case: Empty graph
(let ((empty-graph (make-olgraph '())))
  (assert-equal
    (olnode->list (olgraph:initial empty-graph))
    '())) ; an empty graph

;; Additional test may be conducted if the assumed non-recursion
;; of input graph is not guaranteed.
