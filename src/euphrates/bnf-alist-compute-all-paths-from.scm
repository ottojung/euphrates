;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; The idea is that we first get the list of nonterminals,
;; and then define two mutually recursive helper procedures:
;;
;; • derive‐sym, which given a symbol and the “visited” nonterminals so far,
;;   returns a list of “pairs” of the form (path . visited-out) where
;;   path is a list of symbols computed from that symbol.
;;
;; • derive‐prod, which, given a production (a list of symbols) and a visited set,
;;   returns a list of such (path . visited) pairs obtained by “expanding”
;;   the production’s symbols in left–to–right order.
;;
;; When a nonterminal is encountered that is already in the visited set
;; we “halt” expansion (but we still include it in the path). Otherwise, if
;; the symbol is a terminal (or a nonterminal having productions) we expand it.
;; Finally, the overall procedure returns just the paths (dropping the visited sets).
(define (bnf-alist:compute-all-paths-from bnf-alist starting-nonterminal)
  ;;
  ;; This procedure returns a list of derivation paths.
  ;; Each derivation path is a list of symbols derived from the starting
  ;; nonterminal. If a production is empty (an epsilon
  ;; production), we include parselynn:epsilon in its place.
  ;;
  (define nonterminals
    (list->hashset
     (bnf-alist:nonterminals bnf-alist)))

  (define (nonterminal? sym)
    (hashset-has? nonterminals sym))

  (define (productions-for nt)
    (cdr (assoc nt bnf-alist)))

  ;; A triple is represented as (list path visited halted?)
  (define (make-triple path visited halted?)
    (list path visited halted?))
  (define (triple-path triple) (car triple))
  (define (triple-visited triple) (cadr triple))
  (define (triple-halted? triple) (caddr triple))

  ;; derive-sym: expand a single symbol with a current visited list.
  ;; Returns a list of triples (path, visited-out, halted?).
  (define (derive-sym sym visited)
    (if (and (nonterminal? sym) (member sym visited))
        ;; Cycle detected: do not expand further.
        (list (make-triple (list sym) visited #t))
        (if (nonterminal? sym)
            (let ((new-visited (cons sym visited)))
              (let ((prods (productions-for sym)))
                (if (null? prods)
                    ;; If there are no productions, return the symbol as‐is.
                    (list (make-triple (list sym) new-visited #f))
                    (apply append
                           (map (lambda (prod)
                                  (if (null? prod)
                                      ;; Epsilon production: include epsilon marker.
                                      (list (make-triple (list sym parselynn:epsilon) new-visited #f))
                                      ;; Otherwise, expand the production.
                                      (map (lambda (triple)
                                             ;; Prepend the current nonterminal.
                                             (make-triple (cons sym (triple-path triple))
                                                          (triple-visited triple)
                                                          (triple-halted? triple)))
                                           (derive-prod prod new-visited))))
                                prods)))))
            ;; Terminal: return the symbol as is.
            (list (make-triple (list sym) visited #f)))))

  ;; derive-prod: expand a production (list of symbols) left–to–right given visited.
  ;; If at any point a symbol’s expansion is halted (cyclic) then we stop expanding
  ;; the rest of that production.
  (define (derive-prod prod visited)
    (if (null? prod)
        (list (make-triple '() visited #f))
        (let* ((first (car prod))
               (rest  (cdr prod))
               (first-results (derive-sym first visited)))
          (apply append
                 (map (lambda (triple)
                        (if (triple-halted? triple)
                            ;; If the expansion of the first symbol was halted,
                            ;; do not expand the rest of the production.
                            (list triple)
                            ;; Otherwise, expand the rest.
                            (map (lambda (triple2)
                                   (make-triple (append (triple-path triple)
                                                        (triple-path triple2))
                                                (triple-visited triple2)
                                                (triple-halted? triple2))
                                   )
                                 (derive-prod rest (triple-visited triple)))))
                      first-results)))))

  ;; Start expansion from the starting nonterminal; we ignore visited info
  ;; and also the halted? flags (it has impacted the derivation already).
  (list-deduplicate (map triple-path (derive-sym starting-nonterminal '()))))
