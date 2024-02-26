
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
  (assert=
   (olnode->list node1)
   '(1    ; root node
     (2  ; child of root
      (3    ; child of 2nd node
       )))))

;; Test case: Multiple branches
;; Use graph built above for this test
(assert=
 (map olnode->list (olgraph:initial olgraph-test))
 '((1 (3 (4)) (2))))

;; Test case: Leaf node (no branches)
(let ((node1 (make-olnode 1)))
  (assert=
   (olnode->list node1)
   '(1))) ; single node, no children

;; Test case: Empty graph
(let ((empty-graph (make-olgraph '())))
  (assert=
   (map olnode->list (olgraph:initial empty-graph))
   '())) ; an empty graph
