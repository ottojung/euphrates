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
  ;; Get the nonterminals from the grammar (assume this helper exists)
  (define nonterminals (bnf-alist:nonterminals bnf-alist))

  ;; predicate: is symbol a nonterminal?
  (define (nonterminal? sym)
    (member sym nonterminals))

  ;; Given a nonterminal, return its productions.
  ;; Our bnf-alist is assumed to have the form:
  ;;   ((S p1 p2 ...) (A p3 ... ) …)
  ;; where each p is a production (a list of symbols).
  (define (productions-for nt)
    (cdr (assoc nt bnf-alist)))

  ;; derive-sym takes a symbol and a visited set (list of nonterminals already seen)
  ;; and returns a list of pairs (path . visited-out).
  (define (derive-sym sym visited)
    (if (and (nonterminal? sym) (member sym visited))
        ;; Already seen this nonterminal: halt expansion and return just sym.
        (list (cons (list sym) visited))
        (if (nonterminal? sym)
            (let ((new-visited (cons sym visited)))
              (let ((prods (productions-for sym)))
                (if (null? prods)
                    ;; Edge case: nonterminal with no productions: return only itself.
                    (list (cons (list sym) new-visited))
                    ;; For every production alternative, expand it.
                    (apply append
                           (map (lambda (prod)
                                  (map (lambda (pair)
                                         ;; pair: (derived-path . visited-after-prod)
                                         ;; Prepend the current nonterminal.
                                         (cons (cons sym (car pair)) (cdr pair)))
                                       (derive-prod prod new-visited)))
                                prods)))))
            ;; Else sym is not a nonterminal; treat it as a terminal.
            (list (cons (list sym) visited)))))

  ;; derive-prod takes a list of symbols (a production alternative) and a visited set.
  ;; It returns a list of pairs (path . visited) for expanding the whole production.
  (define (derive-prod prod visited)
    (if (null? prod)
        (list (cons '() visited))
        (let* ((first (car prod))
               (rest (cdr prod))
               (first-results (derive-sym first visited)))
          (apply append
                 (map (lambda (pair)
                        (let ((first-path (car pair))
                              (visited-after-first (cdr pair)))
                          (map (lambda (pair2)
                                 (cons (append first-path (car pair2))
                                       (cdr pair2)))
                               (derive-prod rest visited-after-first))))
                      first-results)))))

  ;; Start the derivation from the starting-nonterminal and discard visited sets.
  (map car (derive-sym starting-nonterminal '())))
