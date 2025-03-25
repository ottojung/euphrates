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

  ;; derive-sym expands one symbol with a given visited list.
  ;; Returns a list of pairs (path . visited-out).
  (define (derive-sym sym visited)
    (if (and (nonterminal? sym) (member sym visited))
        ;; Already visited: halt expansion.
        (list (cons (list sym) visited))
        (if (nonterminal? sym)
            (let ((new-visited (cons sym visited)))
              (let ((prods (productions-for sym)))
                (if (null? prods)
                    (list (cons (list sym) new-visited))
                    (apply append
                           (map (lambda (prod)
                                  (if (null? prod)
                                      ;; epsilon production: record the epsilon marker.
                                      (list (cons (list sym parselynn:epsilon) new-visited))
                                      (map (lambda (pair)
                                             (cons (cons sym (car pair)) (cdr pair)))
                                           (derive-prod prod new-visited))))
                                prods)))))
            ;; Terminal: just return it.
            (list (cons (list sym) visited)))))

  ;; derive-prod expands a production (list of symbols) in left-to-right order.
  ;; If one of the symbols was halted (because it was already visited),
  ;; stop expanding that production further.
  (define (derive-prod prod visited)
    (if (null? prod)
        (list (cons '() visited))
        (let* ((first (car prod))
               (rest  (cdr prod))
               (first-results (derive-sym first visited)))
          (apply append
                 (map (lambda (pair)
                        (let* ((first-path (car pair))
                               (visited-after-first (cdr pair))
                               ;; Check whether the expansion was halted.
                               (halted? (and (nonterminal? first)
                                             (equal? visited-after-first visited))))
                          (if halted?
                              ;; Stop expansion if halted.
                              (list (cons first-path visited-after-first))
                              ;; Otherwise, continue with the rest of the production.
                              (map (lambda (pair2)
                                     (cons (append first-path (car pair2))
                                           (cdr pair2)))
                                   (derive-prod rest visited-after-first)))))
                      first-results)))))

  ;; Start the expansion and deduplicate the paths (we ignore the visited sets).
  (list-deduplicate (map car (derive-sym starting-nonterminal '()))))
