;; Copyright 2023, 2024, 2025  Otto Jung <otto.jung@vauplace.com>
;; Copyright 2014  Jan Nieuwenhuizen <janneke@gnu.org>
;; Copyright 1993, 2010 Dominique Boucher
;;
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU Lesser General Public License
;; as published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Lesser General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;
;;;; An Efficient and Portable Parser Generator for Scheme
;;;

(define *lalr-scm-version* "3.0.0")

(define (parselynn:core arguments)
  (define *bits-per-word* 28)

  (define common-definitions-code
    `((define (cadar l) (car (cdr (car l))))
      (define (drop l n)
        (cond ((and (> n 0) (pair? l))
               (drop (cdr l) (- n 1)))
              (else
               l)))
      (define (take-right l n)
        (drop l (- (length l) n)))

      (define (note-source-location lvalue tok) lvalue)

      (define (token? x)
        (and (vector? x)
             (= 4 (vector-length x))
             (equal? (vector-ref x 0) (quote ,parselynn:token:typetag))))

      (define (token-category x)
        (vector-ref x 1))

      (define (token-source x)
        (vector-ref x 2))

      (define (token-value x)
        (vector-ref x 3))

      (define (token-category/soft x)
        (if (token? x)
            (token-category x)
            x))

      (define (token-source/soft x)
        (if (token? x)
            (token-source x)
            x))

      (define (token-value/soft x)
        (if (token? x)
            (token-value x)
            x))

      ))


;;;
;;;;  LR-driver
;;;

  (define (lr-driver-code results-mode)
    (cond
     ((equal? results-mode 'first) 'fine)
     ((equal? results-mode 'all)
      (parselynn:core:grammar-error
       "Invalid option: ~s because LR parser can only output a single result, so choose ~s ~s for it."
       (~a results-mode) 'results: 'first))
     (else (raisu 'impossible 'expected-all-or-first results-mode)))

    `((define *initial-stack-size* 500)

      (define ___atable action-table)
      (define ___gtable goto-table)
      (define ___rtable reduction-table)

      (define ___stack  #f)
      (define ___sp     0)

      (define ___curr-input #f)
      (define ___reuse-input #f)

      (define ___input #f)
      (define (___consume)
        (set! ___input (if ___reuse-input ___curr-input (get-next-token)))
        (set! ___reuse-input #f)
        (set! ___curr-input ___input))

      (define (___pushback)
        (set! ___reuse-input #t))

      (define (___initstack)
        (set! ___stack (make-vector *initial-stack-size* 0))
        (set! ___sp 0))

      (define (___growstack)
        (let ((new-stack (make-vector (* 2 (vector-length ___stack)) 0)))
          (let loop ((i (- (vector-length ___stack) 1)))
            (if (>= i 0)
                (begin
                  (vector-set! new-stack i (vector-ref ___stack i))
                  (loop (- i 1)))))
          (set! ___stack new-stack)))

      (define (___checkstack)
        (if (>= ___sp (vector-length ___stack))
            (___growstack)))

      (define (___push delta new-category lvalue tok)
        (set! ___sp (- ___sp (* delta 2)))
        (let* ((state     (vector-ref ___stack ___sp))
               (new-state (cdr (assoc new-category (vector-ref ___gtable state)))))
          (set! ___sp (+ ___sp 2))
          (___checkstack)
          (vector-set! ___stack ___sp new-state)
          (vector-set! ___stack (- ___sp 1) (note-source-location lvalue tok))))

      (define (___reduce st)
        ((vector-ref ___rtable st) ___stack ___sp ___gtable ___push ___pushback))

      (define (___shift token attribute)
        (set! ___sp (+ ___sp 2))
        (___checkstack)
        (vector-set! ___stack (- ___sp 1) attribute)
        (vector-set! ___stack ___sp token))

      (define (___action x l)
        (let ((y (assoc x l)))
          (if y (cadr y) (cadar l))))

      (define (___recover tok)
        (let find-state ((sp ___sp))
          (if (< sp 0)
              (set! ___sp sp)
              (let* ((state (vector-ref ___stack sp))
                     (act   (assoc 'error (vector-ref ___atable state))))
                (if act
                    (begin
                      (set! ___sp sp)
                      (___sync (cadr act) tok))
                    (find-state (- sp 2)))))))

      (define (___sync state tok)
        (let ((sync-set (map car (cdr (vector-ref ___atable state)))))
          (set! ___sp (+ ___sp 4))
          (___checkstack)
          (vector-set! ___stack (- ___sp 3) #f)
          (vector-set! ___stack (- ___sp 2) state)
          (let skip ()
            (let ((i (token-category/soft ___input)))
              (if (equal? i '*eoi*)
                  (set! ___sp -1)
                  (if (memq i sync-set)
                      (let ((act (assoc i (vector-ref ___atable state))))
                        (vector-set! ___stack (- ___sp 1) #f)
                        (vector-set! ___stack ___sp (cadr act)))
                      (begin
                        (___consume)
                        (skip))))))))

      (define (___run)
        (let loop ()
          (if ___input
              (let* ((state (vector-ref ___stack ___sp))
                     (i     (token-category/soft ___input))
                     (act   (___action i (vector-ref ___atable state))))

                (cond ((not (symbol? i))
                       (when ___errorp
                         (___errorp 'invalid-token "Syntax error: invalid token: ~s" ___input))
                       #f)

                      ;; Input succesfully parsed
                      ((equal? act 'accept)
                       (vector-ref ___stack 1))

                      ;; Syntax error in input
                      ((equal? act '*error*)
                       (if (equal? i '*eoi*)
                           (begin
                             (when ___errorp
                               (___errorp 'end-of-input "Syntax error: unexpected end of input: ~s" ___input))
                             #f)
                           (begin
                             (when ___errorp
                               (___errorp 'unexpected-token "Syntax error: unexpected token: ~s" ___input))
                             (___recover i)
                             (if (>= ___sp 0)
                                 (set! ___input #f)
                                 (begin
                                   (set! ___sp 0)
                                   (set! ___input '*eoi*)))
                             (loop))))

                      ;; Shift current token on top of the stack
                      ((>= act 0)
                       (___shift act ___input)
                       (set! ___input (if (equal? i '*eoi*) '*eoi* #f))
                       (loop))

                      ;; Reduce by rule (- act)
                      (else
                       (___reduce (- act))
                       (loop))))

              ;; no lookahead, so check if there is a default action
              ;; that does not require the lookahead
              (let* ((state  (vector-ref ___stack ___sp))
                     (acts   (vector-ref ___atable state))
                     (defact (if (pair? acts) (cadar acts) #f)))
                (if (and (= 1 (length acts)) (< defact 0))
                    (___reduce (- defact))
                    (___consume))
                (loop)))))


      (set! ___input #f)
      (set! ___reuse-input #f)
      (___initstack)
      (___run)))


;;;
;;;;  Simple-minded GLR-driver
;;;


  (define (glr-driver-code results-mode)
    `((define ___atable action-table)
      (define ___gtable goto-table)
      (define ___rtable reduction-table)

      ;; -- Input handling

      (define (consume)
        (get-next-token))

      ;; -- Processes (stacks) handling

      (define *processes* '())

      (define (initialize-processes)
        (set! *processes* '()))
      (define (add-process! process)
        (set! *processes* (cons process *processes*)))
      (define (get-processes)
        (reverse *processes*))

      (define (push delta new-category lvalue stack tok)
        (let* ((stack     (drop stack (* delta 2)))
               (state     (car stack))
               (new-state (cdr (assv new-category (vector-ref ___gtable state)))))
          (cons new-state (cons (note-source-location lvalue tok) stack))))

      (define (reduce state stack)
        ((vector-ref ___rtable state) stack ___gtable push))

      (define (shift state symbol stack)
        (cons state (cons symbol stack)))

      (define (get-actions token action-list)
        (let ((pair (assoc token action-list)))
          (if pair
              (cdr pair)
              (cdar action-list)))) ;; get the default action

      ;; Loop state. Set by iterator.
      (define s_routine 'run)
      (define s_input #f)
      (define s_symbol #f)
      (define s_processes #f)
      (define s_stacks #f)
      (define s_active-stacks #f)
      (define s_stack #f)
      (define s_actions #f)

      (define (save-loop-state! routine
                                *input* symbol processes
                                stacks active-stacks
                                stack actions)
        (set! s_routine routine)
        (set! s_input *input*)
        (set! s_symbol symbol)
        (set! s_processes processes)
        (set! s_stacks stacks)
        (set! s_active-stacks active-stacks)
        (set! s_stack stack)
        (set! s_actions actions))

      (define (continue routine
                        *input* symbol processes
                        stacks active-stacks
                        stack actions)
        (case routine
          ((run) (run))
          ((run-processes)
           (run-processes *input* symbol processes))
          ((run-single-process)
           (run-single-process *input* symbol processes stacks active-stacks))
          ((run-actions-loop)
           (run-actions-loop *input* symbol processes stacks active-stacks stack actions))
          ((done) #f)
          (else
           'TODO
           (+ 1 routine)
           (/ 1 0))))

      (define (continue-from-saved)
        (continue s_routine
                  s_input s_symbol s_processes
                  s_stacks s_active-stacks
                  s_stack s_actions))

      (define (run-actions-loop *input* symbol processes stacks active-stacks stack actions)
        (let actions-loop ((actions       actions)
                           (active-stacks active-stacks))
          (if (pair? actions)
              (let ((action        (car actions))
                    (other-actions (cdr actions)))
                (cond ((equal? action '*error*)
                       (actions-loop other-actions active-stacks))
                      ((equal? action 'accept)
                       (let ((actions other-actions))
                         (save-loop-state! 'run-actions-loop
                                           *input* symbol processes
                                           stacks active-stacks
                                           stack actions))
                       (let ((result (car (take-right stack 2))))
                         result))
                      ((>= action 0)
                       (let ((new-stack (shift action *input* stack)))
                         (add-process! new-stack))
                       (actions-loop other-actions active-stacks))
                      (else
                       (let ((new-stack (reduce (- action) stack)))
                         (actions-loop other-actions (cons new-stack active-stacks))))))
              ;; active-stacks)))
              (continue 'run-single-process
                        *input* symbol processes
                        (cdr stacks) active-stacks
                        #f #f))))

      (define (run-single-process *input* symbol processes stacks active-stacks)
        (let loop ((stacks stacks) (active-stacks active-stacks))
          (cond ((pair? stacks)
                 (let ()
                   (define stack   (car stacks))
                   (define state   (car stack))
                   (define actions (get-actions symbol (vector-ref ___atable state)))
                   ;; (loop (cdr stacks)
                   ;;       (run-actions-loop
                   ;;        *input* symbol processes
                   ;;        stacks active-stacks
                   ;;        stack actions))))
                   (run-actions-loop
                    *input* symbol processes
                    stacks active-stacks
                    stack actions)))

                ((pair? active-stacks)
                 (continue 'run-single-process
                           *input* symbol processes
                           (reverse active-stacks) '()
                           #f #f))
                 ;; (loop (reverse active-stacks) '()))

                (else
                 (continue 'run-processes
                           *input* symbol (cdr processes)
                           #f #f
                           #f #f)))))

                 ;; (run-processes symbol (cdr processes))))))

      (define (run-processes *input* symbol processes)
        (let loop ((processes processes))
          (if (null? processes)
              (if (pair? (get-processes))
                  (continue 'run #f #f #f #f #f #f #f)
                  (continue 'done #f #f #f #f #f #f #f))
              (continue 'run-single-process
                        *input* symbol processes
                        (list (car processes)) '()
                        #f #f))))
              ;; (run-single-process
              ;;  *input* symbol processes
              ;;  (list (car processes)) '()))))

      (define (run)
        (let loop-tokens ()
          (define *input* (consume))
          (define symbol (token-category/soft *input*))
          (define processes (get-processes))
          (initialize-processes)
          (continue 'run-processes
                    *input* symbol processes
                    #f #f
                    #f #f)))

      (define (init)
        (initialize-processes)
        (save-loop-state! 'run #f #f #f #f #f #f #f)
        (add-process! '(0)))

      (define (make-iterator)
        (init)
        (lambda _ (continue-from-saved)))

      (define (make-first-returner)
        (init)
        (continue-from-saved))

      ,(cond
        ((equal? results-mode 'all) '(make-iterator))
        ((equal? results-mode 'first) '(make-first-returner))
        (else (raisu 'impossible 'expected-all-or-first)))))

  (define (drop l n)
    (cond ((and (> n 0) (pair? l))
           (drop (cdr l) (- n 1)))
          (else
           l)))

  (define (take-right l n)
    (drop l (- (length l) n)))

  (define (set-bit v b)
    (let ((x (quotient b *bits-per-word*))
          (y (expt 2 (remainder b *bits-per-word*))))
      (vector-set! v x (logior (vector-ref v x) y))))

  (define (bit-union v1 v2 n)
    (do ((i 0 (+ i 1)))
        ((= i n))
      (vector-set! v1 i (logior (vector-ref v1 i)
                                (vector-ref v2 i)))))

  ;; - Macro pour les structures de donnees

  (define (new-core)              (make-vector 4 0))
  (define (set-core-number! c n)  (vector-set! c 0 n))
  (define (set-core-acc-sym! c s) (vector-set! c 1 s))
  (define (set-core-nitems! c n)  (vector-set! c 2 n))
  (define (set-core-items! c i)   (vector-set! c 3 i))
  (define (core-number c)         (vector-ref c 0))
  (define (core-acc-sym c)        (vector-ref c 1))
  (define (core-nitems c)         (vector-ref c 2))
  (define (core-items c)          (vector-ref c 3))

  (define (new-shift)              (make-vector 3 0))
  (define (set-shift-number! c x)  (vector-set! c 0 x))
  (define (set-shift-nshifts! c x) (vector-set! c 1 x))
  (define (set-shift-shifts! c x)  (vector-set! c 2 x))
  (define (shift-number s)         (vector-ref s 0))
  (define (shift-nshifts s)        (vector-ref s 1))
  (define (shift-shifts s)         (vector-ref s 2))

  (define (new-red)                (make-vector 3 0))
  (define (set-red-number! c x)    (vector-set! c 0 x))
  (define (set-red-nreds! c x)     (vector-set! c 1 x))
  (define (set-red-rules! c x)     (vector-set! c 2 x))
  (define (red-number c)           (vector-ref c 0))
  (define (red-nreds c)            (vector-ref c 1))
  (define (red-rules c)            (vector-ref c 2))


  (define (new-set nelem)
    (make-vector nelem 0))


  (define (vector-map f v)
    (let ((vm-n (- (vector-length v) 1)))
      (let loop ((vm-low 0) (vm-high vm-n))
        (if (= vm-low vm-high)
            (vector-set! v vm-low (f (vector-ref v vm-low) vm-low))
            (let ((vm-middle (quotient (+ vm-low vm-high) 2)))
              (loop vm-low vm-middle)
              (loop (+ vm-middle 1) vm-high))))))


  ;; - Constantes
  (define STATE-TABLE-SIZE 1009)


  ;; - Tableaux
  (define rrhs         #f)
  (define rlhs         #f)
  (define ritem        #f)
  (define nullable     #f)
  (define derives      #f)
  (define fderives     #f)
  (define firsts       #f)
  (define kernel-base  #f)
  (define kernel-end   #f)
  (define shift-symbol #f)
  (define shift-set    #f)
  (define red-set      #f)
  (define state-table  #f)
  (define acces-symbol #f)
  (define reduction-table #f)
  (define shift-table  #f)
  (define consistent   #f)
  (define lookaheads   #f)
  (define LA           #f)
  (define LAruleno     #f)
  (define lookback     #f)
  (define goto-map     #f)
  (define from-state   #f)
  (define to-state     #f)
  (define includes     #f)
  (define F            #f)
  (define action-table #f)

  ;; - Variables
  (define nitems          #f)
  (define nrules          #f)
  (define nvars           #f)
  (define nterms          #f)
  (define nsyms           #f)
  (define nstates         #f)
  (define first-state     #f)
  (define last-state      #f)
  (define final-state     #f)
  (define first-shift     #f)
  (define last-shift      #f)
  (define first-reduction #f)
  (define last-reduction  #f)
  (define nshifts         #f)
  (define maxrhs          #f)
  (define ngotos          #f)
  (define token-set-size  #f)

  ;; Default values.
  (define driver-normalized-name     'lr-driver)
  (define driver-user-name           '(lr))
  (define results-mode               'first)

  (define (glr-driver?)
    (equal? driver-normalized-name 'glr-driver))
  (define (lr-driver?)
    (equal? driver-normalized-name 'lr-driver))

  (define (gen-tables! tokens gram )
    (initialize-all)
    (rewrite-grammar
     tokens
     gram
     (lambda (terms terms/prec vars gram gram/actions)
       (set! the-terminals/prec (list->vector terms/prec))
       (set! the-terminals (list->vector terms))
       (set! the-nonterminals (list->vector vars))
       (set! nterms (length terms))
       (set! nvars  (length vars))
       (set! nsyms  (+ nterms nvars))
       (let ((no-of-rules (length gram/actions))
             (no-of-items (let loop ((l gram/actions) (count 0))
                            (if (null? l)
                                count
                                (loop (cdr l) (+ count (length (caar l))))))))
         (pack-grammar no-of-rules no-of-items gram)
         (set-derives)
         (set-nullable)
         (generate-states)
         (lalr)
         (build-tables)
         (compact-action-table terms)
         gram/actions))))


  (define (initialize-all)
    (set! rrhs         #f)
    (set! rlhs         #f)
    (set! ritem        #f)
    (set! nullable     #f)
    (set! derives      #f)
    (set! fderives     #f)
    (set! firsts       #f)
    (set! kernel-base  #f)
    (set! kernel-end   #f)
    (set! shift-symbol #f)
    (set! shift-set    #f)
    (set! red-set      #f)
    (set! state-table  (make-vector STATE-TABLE-SIZE '()))
    (set! acces-symbol #f)
    (set! reduction-table #f)
    (set! shift-table  #f)
    (set! consistent   #f)
    (set! lookaheads   #f)
    (set! LA           #f)
    (set! LAruleno     #f)
    (set! lookback     #f)
    (set! goto-map     #f)
    (set! from-state   #f)
    (set! to-state     #f)
    (set! includes     #f)
    (set! F            #f)
    (set! action-table #f)
    (set! nstates         #f)
    (set! first-state     #f)
    (set! last-state      #f)
    (set! final-state     #f)
    (set! first-shift     #f)
    (set! last-shift      #f)
    (set! first-reduction #f)
    (set! last-reduction  #f)
    (set! nshifts         #f)
    (set! maxrhs          #f)
    (set! ngotos          #f)
    (set! token-set-size  #f)
    (set! rule-precedences '()))


  (define (pack-grammar no-of-rules no-of-items gram)
    (set! nrules (+  no-of-rules 1))
    (set! nitems no-of-items)
    (set! rlhs (make-vector nrules #f))
    (set! rrhs (make-vector nrules #f))
    (set! ritem (make-vector (+ 1 nitems) #f))

    (let loop ((p gram) (item-no 0) (rule-no 1))
      (unless (null? p)
        (let ((nt (caar p)))
          (let loop2 ((prods (cdar p)) (it-no2 item-no) (rl-no2 rule-no))
            (if (null? prods)
                (loop (cdr p) it-no2 rl-no2)
                (begin
                  (vector-set! rlhs rl-no2 nt)
                  (vector-set! rrhs rl-no2 it-no2)
                  (let loop3 ((rhs (car prods)) (it-no3 it-no2))
                    (if (null? rhs)
                        (begin
                          (vector-set! ritem it-no3 (- rl-no2))
                          (loop2 (cdr prods) (+ it-no3 1) (+ rl-no2 1)))
                        (begin
                          (vector-set! ritem it-no3 (car rhs))
                          (loop3 (cdr rhs) (+ it-no3 1))))))))))))


  (define (set-derives)
    (define delts (make-vector (+ nrules 1) 0))
    (define dset  (make-vector nvars -1))

    (let loop ((i 1) (j 0))        ; i = 0
      (when (< i nrules)
        (let ((lhs (vector-ref rlhs i)))
          (if (>= lhs 0)
              (begin
                (vector-set! delts j (cons i (vector-ref dset lhs)))
                (vector-set! dset lhs j)
                (loop (+ i 1) (+ j 1)))
              (loop (+ i 1) j)))))

    (set! derives (make-vector nvars 0))

    (let loop ((i 0))
      (when (< i nvars)
        (let ((q (let loop2 ((j (vector-ref dset i)) (s '()))
                   (if (< j 0)
                       s
                       (let ((x (vector-ref delts j)))
                         (loop2 (cdr x) (cons (car x) s)))))))
          (vector-set! derives i q)
          (loop (+ i 1))))))



  (define (set-nullable)
    (set! nullable (make-vector nvars #f))
    (let ((squeue (make-vector nvars #f))
          (rcount (make-vector (+ nrules 1) 0))
          (rsets  (make-vector nvars #f))
          (relts  (make-vector (+ nitems nvars 1) #f)))
      (let loop ((r 0) (s2 0) (p 0))
        (let ((*r (vector-ref ritem r)))
          (if *r
              (if (< *r 0)
                  (let ((symbol (vector-ref rlhs (- *r))))
                    (when (and (>= symbol 0)
                             (not (vector-ref nullable symbol)))
                      (vector-set! nullable symbol #t)
                      (vector-set! squeue s2 symbol)
                      (loop (+ r 1) (+ s2 1) p)))
                  (let loop2 ((r1 r) (any-tokens #f))
                    (let* ((symbol (vector-ref ritem r1)))
                      (if (> symbol 0)
                          (loop2 (+ r1 1) (or any-tokens (>= symbol nvars)))
                          (if (not any-tokens)
                              (let ((ruleno (- symbol)))
                                (let loop3 ((r2 r) (p2 p))
                                  (let ((symbol (vector-ref ritem r2)))
                                    (if (> symbol 0)
                                        (begin
                                          (vector-set! rcount ruleno
                                                       (+ (vector-ref rcount ruleno) 1))
                                          (vector-set! relts p2
                                                       (cons (vector-ref rsets symbol)
                                                             ruleno))
                                          (vector-set! rsets symbol p2)
                                          (loop3 (+ r2 1) (+ p2 1)))
                                        (loop (+ r2 1) s2 p2)))))
                              (loop (+ r1 1) s2 p))))))
              (let loop ((s1 0) (s3 s2))
                (when (< s1 s3)
                  (let loop2 ((p (vector-ref rsets (vector-ref squeue s1))) (s4 s3))
                    (when p
                      (let* ((x (vector-ref relts p))
                             (ruleno (cdr x))
                             (y (- (vector-ref rcount ruleno) 1)))
                        (vector-set! rcount ruleno y)
                        (if (= y 0)
                            (let ((symbol (vector-ref rlhs ruleno)))
                              (if (and (>= symbol 0)
                                       (not (vector-ref nullable symbol)))
                                  (begin
                                    (vector-set! nullable symbol #t)
                                    (vector-set! squeue s4 symbol)
                                    (loop2 (car x) (+ s4 1)))
                                  (loop2 (car x) s4)))
                            (loop2 (car x) s4))))
                    (loop (+ s1 1) s4)))))))))



  (define (set-firsts)
    (set! firsts (make-vector nvars '()))

    ;; -- initialization
    (let loop ((i 0))
      (when (< i nvars)
        (let loop2 ((sp (vector-ref derives i)))
          (if (null? sp)
              (loop (+ i 1))
              (let ((sym (vector-ref ritem (vector-ref rrhs (car sp)))))
                (when (< -1 sym nvars)
                  (vector-set! firsts i (sinsert sym (vector-ref firsts i))))
                (loop2 (cdr sp)))))))

    ;; -- reflexive and transitive closure
    (let loop ((continue #t))
      (when continue
        (let loop2 ((i 0) (cont #f))
          (if (>= i nvars)
              (loop cont)
              (let* ((x (vector-ref firsts i))
                     (y (let loop3 ((l x) (z x))
                          (if (null? l)
                              z
                              (loop3 (cdr l)
                                     (sunion (vector-ref firsts (car l)) z))))))
                (if (equal? x y)
                    (loop2 (+ i 1) cont)
                    (begin
                      (vector-set! firsts i y)
                      (loop2 (+ i 1) #t))))))))

    (let loop ((i 0))
      (when (< i nvars)
        (vector-set! firsts i (sinsert i (vector-ref firsts i)))
        (loop (+ i 1)))))




  (define (set-fderives)
    (set! fderives (make-vector nvars #f))

    (set-firsts)

    (let loop ((i 0))
      (when (< i nvars)
        (let ((x (let loop2 ((l (vector-ref firsts i)) (fd '()))
                   (if (null? l)
                       fd
                       (loop2 (cdr l)
                              (sunion (vector-ref derives (car l)) fd))))))
          (vector-set! fderives i x)
          (loop (+ i 1))))))


  (define (closure core)
    ;; Initialization
    (define ruleset (make-vector nrules #f))

    (let loop ((csp core))
      (unless (null? csp)
        (let ((sym (vector-ref ritem (car csp))))
          (when (< -1 sym nvars)
            (let loop2 ((dsp (vector-ref fderives sym)))
              (unless (null? dsp)
                (vector-set! ruleset (car dsp) #t)
                (loop2 (cdr dsp)))))
          (loop (cdr csp)))))

    (let loop ((ruleno 1) (csp core) (itemsetv '())) ; ruleno = 0
      (if (< ruleno nrules)
          (if (vector-ref ruleset ruleno)
              (let ((itemno (vector-ref rrhs ruleno)))
                (let loop2 ((c csp) (itemsetv2 itemsetv))
                  (if (and (pair? c)
                           (< (car c) itemno))
                      (loop2 (cdr c) (cons (car c) itemsetv2))
                      (loop (+ ruleno 1) c (cons itemno itemsetv2)))))
              (loop (+ ruleno 1) csp itemsetv))
          (let loop2 ((c csp) (itemsetv2 itemsetv))
            (if (pair? c)
                (loop2 (cdr c) (cons (car c) itemsetv2))
                (reverse itemsetv2))))))



  (define (allocate-item-sets)
    (set! kernel-base (make-vector nsyms 0))
    (set! kernel-end  (make-vector nsyms #f)))


  (define (allocate-storage)
    (allocate-item-sets)
    (set! red-set (make-vector (+ nrules 1) 0)))

                                        ; --


  (define (initialize-states)
    (let ((p (new-core)))
      (set-core-number! p 0)
      (set-core-acc-sym! p #f)
      (set-core-nitems! p 1)
      (set-core-items! p '(0))

      (set! first-state (list p))
      (set! last-state first-state)
      (set! nstates 1)))



  (define (generate-states)
    (allocate-storage)
    (set-fderives)
    (initialize-states)
    (let loop ((this-state first-state))
      (when (pair? this-state)
        (let* ((x (car this-state))
               (is (closure (core-items x))))
          (save-reductions x is)
          (new-itemsets is)
          (append-states)
          (when (> nshifts 0)
            (save-shifts x))
          (loop (cdr this-state))))))


  (define (new-itemsets itemset)
    ;; - Initialization
    (set! shift-symbol '())
    (let loop ((i 0))
      (when (< i nsyms)
        (vector-set! kernel-end i '())
        (loop (+ i 1))))

    (let loop ((isp itemset))
      (when (pair? isp)
        (let* ((i (car isp))
               (sym (vector-ref ritem i)))
          (when (>= sym 0)
            (set! shift-symbol (sinsert sym shift-symbol))
            (let ((x (vector-ref kernel-end sym)))
              (if (null? x)
                  (begin
                    (vector-set! kernel-base sym (cons (+ i 1) x))
                    (vector-set! kernel-end sym (vector-ref kernel-base sym)))
                  (begin
                    (set-cdr! x (list (+ i 1)))
                    (vector-set! kernel-end sym (cdr x))))))
          (loop (cdr isp)))))

    (set! nshifts (length shift-symbol)))



  (define (get-state sym)
    (let* ((isp  (vector-ref kernel-base sym))
           (n    (length isp))
           (key  (let loop ((isp1 isp) (k 0))
                   (if (null? isp1)
                       (modulo k STATE-TABLE-SIZE)
                       (loop (cdr isp1) (+ k (car isp1))))))
           (sp   (vector-ref state-table key)))
      (if (null? sp)
          (let ((x (new-state sym)))
            (vector-set! state-table key (list x))
            (core-number x))
          (let loop ((sp1 sp))
            (if (and (= n (core-nitems (car sp1)))
                     (let loop2 ((i1 isp) (t (core-items (car sp1))))
                       (if (and (pair? i1)
                                (= (car i1)
                                   (car t)))
                           (loop2 (cdr i1) (cdr t))
                           (null? i1))))
                (core-number (car sp1))
                (if (null? (cdr sp1))
                    (let ((x (new-state sym)))
                      (set-cdr! sp1 (list x))
                      (core-number x))
                    (loop (cdr sp1))))))))


  (define (new-state sym)
    (let* ((isp  (vector-ref kernel-base sym))
           (n    (length isp))
           (p    (new-core)))
      (set-core-number! p nstates)
      (set-core-acc-sym! p sym)
      (when (= sym nvars) (set! final-state nstates))
      (set-core-nitems! p n)
      (set-core-items! p isp)
      (set-cdr! last-state (list p))
      (set! last-state (cdr last-state))
      (set! nstates (+ nstates 1))
      p))


                                        ; --

  (define (append-states)
    (set! shift-set
          (let loop ((l (reverse shift-symbol)))
            (if (null? l)
                '()
                (cons (get-state (car l)) (loop (cdr l)))))))

                                        ; --

  (define (save-shifts core)
    (let ((p (new-shift)))
      (set-shift-number! p (core-number core))
      (set-shift-nshifts! p nshifts)
      (set-shift-shifts! p shift-set)
      (if last-shift
          (begin
            (set-cdr! last-shift (list p))
            (set! last-shift (cdr last-shift)))
          (begin
            (set! first-shift (list p))
            (set! last-shift first-shift)))))

  (define (save-reductions core itemset)
    (let ((rs (let loop ((l itemset))
                (if (null? l)
                    '()
                    (let ((item (vector-ref ritem (car l))))
                      (if (< item 0)
                          (cons (- item) (loop (cdr l)))
                          (loop (cdr l))))))))
      (when (pair? rs)
        (let ((p (new-red)))
          (set-red-number! p (core-number core))
          (set-red-nreds!  p (length rs))
          (set-red-rules!  p rs)
          (if last-reduction
              (begin
                (set-cdr! last-reduction (list p))
                (set! last-reduction (cdr last-reduction)))
              (begin
                (set! first-reduction (list p))
                (set! last-reduction first-reduction)))))))


                                        ; --

  (define (lalr)
    (set! token-set-size (+ 1 (quotient nterms *bits-per-word*)))
    (set-accessing-symbol)
    (set-shift-table)
    (set-reduction-table)
    (set-max-rhs)
    (initialize-LA)
    (set-goto-map)
    (initialize-F)
    (build-relations)
    (digraph includes)
    (compute-lookaheads))

  (define (set-accessing-symbol)
    (set! acces-symbol (make-vector nstates #f))
    (let loop ((l first-state))
      (when (pair? l)
        (let ((x (car l)))
          (vector-set! acces-symbol (core-number x) (core-acc-sym x))
          (loop (cdr l))))))

  (define (set-shift-table)
    (set! shift-table (make-vector nstates #f))
    (let loop ((l first-shift))
      (when (pair? l)
        (let ((x (car l)))
          (vector-set! shift-table (shift-number x) x)
          (loop (cdr l))))))

  (define (set-reduction-table)
    (set! reduction-table (make-vector nstates #f))
    (let loop ((l first-reduction))
      (when (pair? l)
        (let ((x (car l)))
          (vector-set! reduction-table (red-number x) x)
          (loop (cdr l))))))

  (define (set-max-rhs)
    (let loop ((p 0) (curmax 0) (length 0))
      (let ((x (vector-ref ritem p)))
        (if x
            (if (>= x 0)
                (loop (+ p 1) curmax (+ length 1))
                (loop (+ p 1) (max curmax length) 0))
            (set! maxrhs curmax)))))

  (define (initialize-LA)
    (define (last l)
      (if (null? (cdr l))
          (car l)
          (last (cdr l))))

    (set! consistent (make-vector nstates #f))
    (set! lookaheads (make-vector (+ nstates 1) #f))

    (let loop ((count 0) (i 0))
      (if (< i nstates)
          (begin
            (vector-set! lookaheads i count)
            (let ((rp (vector-ref reduction-table i))
                  (sp (vector-ref shift-table i)))
              (if (and rp
                       (or (> (red-nreds rp) 1)
                           (and sp
                                (not
                                 (< (vector-ref acces-symbol
                                                (last (shift-shifts sp)))
                                    nvars)))))
                  (loop (+ count (red-nreds rp)) (+ i 1))
                  (begin
                    (vector-set! consistent i #t)
                    (loop count (+ i 1))))))

          (begin
            (vector-set! lookaheads nstates count)
            (let ((c (max count 1)))
              (set! LA (make-vector c #f))
              (do ((j 0 (+ j 1))) ((= j c)) (vector-set! LA j (new-set token-set-size)))
              (set! LAruleno (make-vector c -1))
              (set! lookback (make-vector c #f)))
            (let loop ((i 0) (np 0))
              (when (< i nstates)
                (if (vector-ref consistent i)
                    (loop (+ i 1) np)
                    (let ((rp (vector-ref reduction-table i)))
                      (if rp
                          (let loop2 ((j (red-rules rp)) (np2 np))
                            (if (null? j)
                                (loop (+ i 1) np2)
                                (begin
                                  (vector-set! LAruleno np2 (car j))
                                  (loop2 (cdr j) (+ np2 1)))))
                          (loop (+ i 1) np))))))))))


  (define (set-goto-map)
    (set! goto-map (make-vector (+ nvars 1) 0))
    (let ((temp-map (make-vector (+ nvars 1) 0)))
      (let loop ((ng 0) (sp first-shift))
        (if (pair? sp)
            (let loop2 ((i (reverse (shift-shifts (car sp)))) (ng2 ng))
              (if (pair? i)
                  (let ((symbol (vector-ref acces-symbol (car i))))
                    (if (< symbol nvars)
                        (begin
                          (vector-set! goto-map symbol
                                       (+ 1 (vector-ref goto-map symbol)))
                          (loop2 (cdr i) (+ ng2 1)))
                        (loop2 (cdr i) ng2)))
                  (loop ng2 (cdr sp))))

            (let loop ((k 0) (i 0))
              (if (< i nvars)
                  (begin
                    (vector-set! temp-map i k)
                    (loop (+ k (vector-ref goto-map i)) (+ i 1)))

                  (begin
                    (do ((i 0 (+ i 1)))
                        ((>= i nvars))
                      (vector-set! goto-map i (vector-ref temp-map i)))

                    (set! ngotos ng)
                    (vector-set! goto-map nvars ngotos)
                    (vector-set! temp-map nvars ngotos)
                    (set! from-state (make-vector ngotos #f))
                    (set! to-state (make-vector ngotos #f))

                    (do ((sp first-shift (cdr sp)))
                        ((null? sp))
                      (let* ((x (car sp))
                             (state1 (shift-number x)))
                        (do ((i (shift-shifts x) (cdr i)))
                            ((null? i))
                          (let* ((state2 (car i))
                                 (symbol (vector-ref acces-symbol state2)))
                            (when (< symbol nvars)
                              (let ((k (vector-ref temp-map symbol)))
                                (vector-set! temp-map symbol (+ k 1))
                                (vector-set! from-state k state1)
                                (vector-set! to-state k state2))))))))))))))


  (define (map-goto state symbol)
    (let loop ((low (vector-ref goto-map symbol))
               (high (- (vector-ref goto-map (+ symbol 1)) 1)))
      (if (> low high)
          (begin
            (display (list "Error in map-goto" state symbol)) (newline)
            0)
          (let* ((middle (quotient (+ low high) 2))
                 (s (vector-ref from-state middle)))
            (cond
             ((= s state)
              middle)
             ((< s state)
              (loop (+ middle 1) high))
             (else
              (loop low (- middle 1))))))))


  (define (initialize-F)
    (set! F (make-vector ngotos #f))
    (do ((i 0 (+ i 1))) ((= i ngotos)) (vector-set! F i (new-set token-set-size)))

    (let ((reads (make-vector ngotos #f)))

      (let loop ((i 0) (rowp 0))
        (when (< i ngotos)
          (let* ((rowf (vector-ref F rowp))
                 (stateno (vector-ref to-state i))
                 (sp (vector-ref shift-table stateno)))
            (when sp
              (let loop2 ((j (shift-shifts sp)) (edges '()))
                (if (pair? j)
                    (let ((symbol (vector-ref acces-symbol (car j))))
                      (if (< symbol nvars)
                          (if (vector-ref nullable symbol)
                              (loop2 (cdr j) (cons (map-goto stateno symbol)
                                                   edges))
                              (loop2 (cdr j) edges))
                          (begin
                            (set-bit rowf (- symbol nvars))
                            (loop2 (cdr j) edges))))
                    (when (pair? edges)
                      (vector-set! reads i (reverse edges))))))
            (loop (+ i 1) (+ rowp 1)))))
      (digraph reads)))

  (define (add-lookback-edge stateno ruleno gotono)
    (let ((k (vector-ref lookaheads (+ stateno 1))))
      (let loop ((found #f) (i (vector-ref lookaheads stateno)))
        (if (and (not found) (< i k))
            (if (= (vector-ref LAruleno i) ruleno)
                (loop #t i)
                (loop found (+ i 1)))

            (if (not found)
                (begin (display "Error in add-lookback-edge : ")
                       (display (list stateno ruleno gotono)) (newline))
                (vector-set! lookback i
                             (cons gotono (vector-ref lookback i))))))))


  (define (transpose r-arg n)
    (let ((new-end (make-vector n #f))
          (new-R  (make-vector n #f)))
      (do ((i 0 (+ i 1)))
          ((= i n))
        (let ((x (list 'bidon)))
          (vector-set! new-R i x)
          (vector-set! new-end i x)))
      (do ((i 0 (+ i 1)))
          ((= i n))
        (let ((sp (vector-ref r-arg i)))
          (when (pair? sp)
            (let loop ((sp2 sp))
              (when (pair? sp2)
                (let* ((x (car sp2))
                       (y (vector-ref new-end x)))
                  (set-cdr! y (cons i (cdr y)))
                  (vector-set! new-end x (cdr y))
                  (loop (cdr sp2))))))))
      (do ((i 0 (+ i 1)))
          ((= i n))
        (vector-set! new-R i (cdr (vector-ref new-R i))))

      new-R))



  (define (build-relations)

    (define (get-state stateno symbol)
      (let loop ((j (shift-shifts (vector-ref shift-table stateno)))
                 (stno stateno))
        (if (null? j)
            stno
            (let ((st2 (car j)))
              (if (= (vector-ref acces-symbol st2) symbol)
                  st2
                  (loop (cdr j) st2))))))

    (set! includes (make-vector ngotos #f))
    (do ((i 0 (+ i 1)))
        ((= i ngotos))
      (let ((state1 (vector-ref from-state i))
            (symbol1 (vector-ref acces-symbol (vector-ref to-state i))))
        (let loop ((rulep (vector-ref derives symbol1))
                   (edges '()))
          (if (pair? rulep)
              (let ((*rulep (car rulep)))
                (let loop2 ((rp (vector-ref rrhs *rulep))
                            (stateno state1)
                            (states (list state1)))
                  (let ((*rp (vector-ref ritem rp)))
                    (if (> *rp 0)
                        (let ((st (get-state stateno *rp)))
                          (loop2 (+ rp 1) st (cons st states)))
                        (begin

                          (unless (vector-ref consistent stateno)
                            (add-lookback-edge stateno *rulep i))

                          (let loop2 ((done #f)
                                      (stp (cdr states))
                                      (rp2 (- rp 1))
                                      (edgp edges))
                            (if (not done)
                                (let ((*rp (vector-ref ritem rp2)))
                                  (if (< -1 *rp nvars)
                                      (loop2 (not (vector-ref nullable *rp))
                                             (cdr stp)
                                             (- rp2 1)
                                             (cons (map-goto (car stp) *rp) edgp))
                                      (loop2 #t stp rp2 edgp)))

                                (loop (cdr rulep) edgp))))))))
              (vector-set! includes i edges)))))
    (set! includes (transpose includes ngotos)))



  (define (compute-lookaheads)
    (let ((n (vector-ref lookaheads nstates)))
      (let loop ((i 0))
        (when (< i n)
          (let loop2 ((sp (vector-ref lookback i)))
            (if (pair? sp)
                (let ((LA-i (vector-ref LA i))
                      (F-j  (vector-ref F (car sp))))
                  (bit-union LA-i F-j token-set-size)
                  (loop2 (cdr sp)))
                (loop (+ i 1))))))))



  (define (digraph relation)
    (define infinity (+ ngotos 2))
    (define INDEX (make-vector (+ ngotos 1) 0))
    (define VERTICES (make-vector (+ ngotos 1) 0))
    (define top 0)
    (define R relation)

    (define (traverse i)
      (set! top (+ 1 top))
      (vector-set! VERTICES top i)
      (let ((height top))
        (vector-set! INDEX i height)
        (let ((rp (vector-ref R i)))
          (when (pair? rp)
            (let loop ((rp2 rp))
              (when (pair? rp2)
                (let ((j (car rp2)))
                  (when (= 0 (vector-ref INDEX j))
                    (traverse j))
                  (when (> (vector-ref INDEX i)
                           (vector-ref INDEX j))
                    (vector-set! INDEX i (vector-ref INDEX j)))
                  (let ((F-i (vector-ref F i))
                        (F-j (vector-ref F j)))
                    (bit-union F-i F-j token-set-size))
                  (loop (cdr rp2))))))
          (when (= (vector-ref INDEX i) height)
            (let loop ()
              (let ((j (vector-ref VERTICES top)))
                (set! top (- top 1))
                (vector-set! INDEX j infinity)
                (unless (= i j)
                  (bit-union (vector-ref F i)
                             (vector-ref F j)
                             token-set-size)
                  (loop))))))))

    (let loop ((i 0))
      (when (< i ngotos)
        (when (and (= 0 (vector-ref INDEX i))
                   (pair? (vector-ref R i)))
          (traverse i))
        (loop (+ i 1)))))


  ;; ----------------------------------------------------------------------
  ;; operator precedence management
  ;; ----------------------------------------------------------------------

  ;; a vector of precedence descriptors where each element
  ;; is of the form (terminal type precedence)
  (define the-terminals/prec #f)   ; terminal symbols with precedence
                                        ; the precedence is an integer >= 0
  (define (get-symbol-precedence sym)
    (caddr (vector-ref the-terminals/prec sym)))
                                        ; the operator type is either 'none, 'left, 'right, or 'nonassoc
  (define (get-symbol-assoc sym)
    (cadr (vector-ref the-terminals/prec sym)))

  (define rule-precedences '())
  (define (add-rule-precedence! rule sym)
    (set! rule-precedences
          (cons (cons rule sym) rule-precedences)))

  (define (get-rule-precedence ruleno)
    (cond
     ((assq ruleno rule-precedences)
      => (lambda (p)
           (get-symbol-precedence (cdr p))))
     (else
      ;; process the rule symbols from left to right
      (let loop ((i    (vector-ref rrhs ruleno))
                 (prec 0))
        (let ((item (vector-ref ritem i)))
          ;; end of rule
          (if (< item 0)
              prec
              (let ((i1 (+ i 1)))
                (if (>= item nvars)
                    ;; it's a terminal symbol
                    (loop i1 (get-symbol-precedence (- item nvars)))
                    (loop i1 prec)))))))))

  ;; ----------------------------------------------------------------------
  ;; Build the various tables
  ;; ----------------------------------------------------------------------

  (define (build-tables)

    (define (resolve-conflict sym rule)
      (let ((sym-prec   (get-symbol-precedence sym))
            (sym-assoc  (get-symbol-assoc sym))
            (rule-prec  (get-rule-precedence rule)))
        (cond
         ((> sym-prec rule-prec)     'shift)
         ((< sym-prec rule-prec)     'reduce)
         ((equal? sym-assoc 'left)      'reduce)
         ((equal? sym-assoc 'right)     'shift)
         (else                       'none))))

    (define conflict-messages '())

    (define (add-conflict-message type new current on-symbol in-state)
      (set! conflict-messages (cons (list type new current on-symbol in-state) conflict-messages)))

    (define (log-conflicts)
      (for-each
       (lambda (args)
         (apply parselynn:core:signal-lr-conflict args))
       conflict-messages))

    ;; --- Add an action to the action table
    (define (add-action state symbol new-action)
      (let* ((state-actions (vector-ref action-table state))
             (actions       (assv symbol state-actions)))
        (if (pair? actions)
            (let ((current-action (cadr actions)))
              (unless (equal? new-action current-action)
                ;; -- there is a conflict

                (if (and (<= current-action 0) (<= new-action 0))
                    ;; --- reduce/reduce conflict
                    (begin
                      (add-conflict-message
                       'reduce/reduce
                       (- new-action)
                       (- current-action)
                       (get-symbol (+ symbol nvars))
                       state)
                      (if (glr-driver?)
                          (set-cdr! (cdr actions) (cons new-action (cddr actions)))
                          (set-car! (cdr actions) (max current-action new-action))))
                    ;; --- shift/reduce conflict
                    ;; can we resolve the conflict using precedences?
                    (case (resolve-conflict symbol (- current-action))
                      ;; -- shift
                      ((shift)   (if (glr-driver?)
                                     (set-cdr! (cdr actions) (cons new-action (cddr actions)))
                                     (set-car! (cdr actions) new-action)))
                      ;; -- reduce
                      ((reduce)  #f) ; well, nothing to do...
                      ;; -- signal a conflict!
                      (else      (add-conflict-message
                                  'shift/reduce new-action (- current-action)
                                  (get-symbol (+ symbol nvars)) state)
                                 (if (glr-driver?)
                                     (set-cdr! (cdr actions) (cons new-action (cddr actions)))
                                     (set-car! (cdr actions) new-action)))))))

            (vector-set! action-table state (cons (list symbol new-action) state-actions)))
        ))

    (define (add-action-for-all-terminals state action)
      (do ((i 1 (+ i 1)))
          ((= i nterms))
        (add-action state i action)))

    (set! action-table (make-vector nstates '()))

    (do ((i 0 (+ i 1)))            ; i = state
        ((= i nstates))
      (let ((red (vector-ref reduction-table i)))
        (when (and red (>= (red-nreds red) 1))
          (if (and (= (red-nreds red) 1) (vector-ref consistent i))
              (if (glr-driver?)
                  (add-action-for-all-terminals i (- (car (red-rules red))))
                  (add-action i 'default (- (car (red-rules red)))))
              (let ((k (vector-ref lookaheads (+ i 1))))
                (let loop ((j (vector-ref lookaheads i)))
                  (when (< j k)
                    (let ((rule (- (vector-ref LAruleno j)))
                          (lav  (vector-ref LA j)))
                      (let loop2 ((token 0) (x (vector-ref lav 0)) (y 1) (z 0))
                        (when (< token nterms)
                          (let ((in-la-set? (modulo x 2)))
                            (when (= in-la-set? 1)
                              (add-action i token rule)))
                          (if (= y *bits-per-word*)
                              (loop2 (+ token 1)
                                     (vector-ref lav (+ z 1))
                                     1
                                     (+ z 1))
                              (loop2 (+ token 1) (quotient x 2) (+ y 1) z))))
                      (loop (+ j 1)))))))))

      (let ((shiftp (vector-ref shift-table i)))
        (when shiftp
          (let loop ((k (shift-shifts shiftp)))
            (when (pair? k)
              (let* ((state (car k))
                     (symbol (vector-ref acces-symbol state)))
                (when (>= symbol nvars)
                  (add-action i (- symbol nvars) state))
                (loop (cdr k))))))))

    (add-action final-state 0 'accept)
    (log-conflicts))

  (define (compact-action-table terms)
    (define (most-common-action acts)
      (let ((accums '()))
        (let loop ((l acts))
          (when (pair? l)
            (let* ((x (cadar l))
                   (y (assv x accums)))
              (when (and (number? x) (< x 0))
                (if y
                    (set-cdr! y (+ 1 (cdr y)))
                    (set! accums (cons `(,x . 1) accums))))
              (loop (cdr l)))))

        (let loop ((l accums) (max 0) (sym #f))
          (if (null? l)
              sym
              (let ((x (car l)))
                (if (> (cdr x) max)
                    (loop (cdr l) (cdr x) (car x))
                    (loop (cdr l) max sym)))))))

    (define (translate-terms acts)
      (map (lambda (act)
             (cons (list-ref terms (car act))
                   (cdr act)))
           acts))

    (do ((i 0 (+ i 1)))
        ((= i nstates))
      (let ((acts (vector-ref action-table i)))
        (if (vector? (vector-ref reduction-table i))
            (let ((act (most-common-action acts)))
              (vector-set! action-table i
                           (cons `(*default* ,(if act act '*error*))
                                 (translate-terms
                                  (lalr-filter (lambda (x)
                                                 (not (and (= (length x) 2)
                                                           (equal? (cadr x) act))))
                                               acts)))))
            (vector-set! action-table i
                         (cons `(*default* *error*)
                               (translate-terms acts)))))))



  ;; --

  (define actions-list '())
  (define actions-list-length 0)

  (define (rewrite-grammar tokens grammar k)

    (define eoi '*eoi*)

    (define (check-terminal term terms)
      (cond
       ((not (valid-terminal? term))
        (parselynn:core:grammar-error "Invalid terminal: ~s" term))
       ((member term terms)
        (parselynn:core:grammar-error "Duplicate definition of terminal: ~s" term))))

    (define (prec->type prec)
      (cdr (assq prec '((left:     . left)
                        (right:    . right)
                        (nonassoc: . nonassoc)))))

    (cond
     ;; --- a few error conditions
     ((not (list? tokens))
      (parselynn:core:grammar-error "Invalid token list: ~s" tokens))
     ((not (pair? grammar))
      (parselynn:core:grammar-error "Grammar definition must have a non-empty list of productions"))

     (else
      ;; --- check the terminals
      (let loop1 ((lst            tokens)
                  (rev-terms      '())
                  (rev-terms/prec '())
                  (prec-level     0))
        (if (pair? lst)
            (let ((term (car lst)))
              (cond
               ((pair? term)
                (if (and (memq (car term) '(left: right: nonassoc:))
                         (not (null? (cdr term))))
                    (let ((prec    (+ prec-level 1))
                          (optype  (prec->type (car term))))
                      (let loop-toks ((l             (cdr term))
                                      (rev-terms      rev-terms)
                                      (rev-terms/prec rev-terms/prec))
                        (if (null? l)
                            (loop1 (cdr lst) rev-terms rev-terms/prec prec)
                            (let ((term (car l)))
                              (check-terminal term rev-terms)
                              (loop-toks
                               (cdr l)
                               (cons term rev-terms)
                               (cons (list term optype prec) rev-terms/prec))))))

                    (parselynn:core:grammar-error "Invalid operator precedence specification: ~s" term)))

               (else
                (check-terminal term rev-terms)
                (loop1 (cdr lst)
                       (cons term rev-terms)
                       (cons (list term 'none 0) rev-terms/prec)
                       prec-level))))

            ;; --- check the grammar rules
            (let loop2 ((lst grammar) (rev-nonterm-defs '()))
              (if (pair? lst)
                  (let ((def (car lst)))
                    (if (not (pair? def))
                        (parselynn:core:grammar-error "Nonterminal definition must be a non-empty list")
                        (let ((nonterm (car def)))
                          (cond ((not (valid-nonterminal? nonterm))
                                 (parselynn:core:grammar-error "Invalid nonterminal: ~s" nonterm))
                                ((or (member nonterm rev-terms)
                                     (assoc nonterm rev-nonterm-defs))
                                 (parselynn:core:grammar-error "Nonterminal previously defined: ~s" nonterm))
                                (else
                                 (loop2 (cdr lst)
                                        (cons def rev-nonterm-defs)))))))
                  (let* ((terms        (cons eoi            (cons 'error          (reverse rev-terms))))
                         (terms/prec   (cons '(eoi none 0)  (cons '(error none 0) (reverse rev-terms/prec))))
                         (nonterm-defs (reverse rev-nonterm-defs))
                         (nonterms     (cons '*start* (map car nonterm-defs))))
                    (if (= (length nonterms) 1)
                        (parselynn:core:grammar-error "Grammar must contain at least one nonterminal")
                        (let loop-defs ((defs      (cons `(*start* (,(cadr nonterms) ,eoi) : $1)
                                                         nonterm-defs))
                                        (ruleno    0)
                                        (comp-defs '()))
                          (if (pair? defs)
                              (let* ((nonterm-def  (car defs))
                                     (compiled-def (rewrite-nonterm-def
                                                    nonterm-def
                                                    ruleno
                                                    terms nonterms)))
                                (loop-defs (cdr defs)
                                           (+ ruleno (length compiled-def))
                                           (cons compiled-def comp-defs)))

                              (let ((compiled-nonterm-defs (reverse comp-defs)))
                                (k terms
                                   terms/prec
                                   nonterms
                                   (map (lambda (x) (cons (caaar x) (map cdar x)))
                                        compiled-nonterm-defs)
                                   (apply append compiled-nonterm-defs))))))))))))))


  (define (rewrite-nonterm-def nonterm-def ruleno terms nonterms)

    (define No-NT (length nonterms))

    (define (encode x)
      (let ((PosInNT (pos-in-list x nonterms)))
        (if PosInNT
            PosInNT
            (let ((PosInT (pos-in-list x terms)))
              (if PosInT
                  (+ No-NT PosInT)
                  (parselynn:core:grammar-error "Undefined symbol: ~s" x))))))

    (define (process-prec-directive rhs ruleno)
      (let loop ((l rhs))
        (if (null? l)
            '()
            (let ((first (car l))
                  (rest  (cdr l)))
              (cond
               ((or (member first terms) (member first nonterms))
                (cons first (loop rest)))
               ((and (pair? first)
                     (equal? (car first) 'prec:))
                (if (and (pair? (cdr first))
                         (null? (cddr first))
                         (member (cadr first) terms))
                    (if (null? rest)
                        (begin
                          (add-rule-precedence! ruleno (pos-in-list (cadr first) terms))
                          (loop rest))
                        (parselynn:core:grammar-error "Invalid prec position: directive should be at end of rule: ~s" rhs))
                    (parselynn:core:grammar-error "Invalid prec: directive: ~s" first)))
               (else
                (parselynn:core:grammar-error "Invalid terminal or nonterminal: ~s" first)))))))

    (define (check-error-production rhs)
      (let loop ((rhs rhs))
        (when (pair? rhs)
          (when (and (equal? (car rhs) 'error)
                     (or (null? (cdr rhs))
                         (not (member (cadr rhs) terms))
                         (not (null? (cddr rhs)))))
            (parselynn:core:grammar-error "Invalid 'error' production. A single terminal symbol must follow the 'error' token: ~s" rhs))
          (loop (cdr rhs)))))

    (define (serialize-action action)
      (if (not (pair? action)) action
          (let ()
            (define proc (car action))
            (if (symbol? proc) action
                (let ()
                  (define index actions-list-length)

                  (unless (procedure? proc)
                    (parselynn:core:grammar-error
                     "Expected procedure as action, but got something else: ~s (context: ~s)"
                     proc action))

                  (set! actions-list (cons proc actions-list))
                  (set! actions-list-length (+ 1 actions-list-length))
                  (cons 'external (cons index (cdr action))))))))

    (if (not (pair? (cdr nonterm-def)))
        (parselynn:core:grammar-error "At least one production needed for nonterminal: ~s" (car nonterm-def))
        (let ((name (symbol->string (car nonterm-def))))
          (let loop1 ((lst (cdr nonterm-def))
                      (i 1)
                      (rev-productions-and-actions '()))
            (if (not (pair? lst))
                (reverse rev-productions-and-actions)
                (let* ((rhs  (process-prec-directive (car lst) (+ ruleno i -1)))
                       (rest (cdr lst))
                       (prod (map encode (cons (car nonterm-def) rhs))))
                  ;; -- check for undefined tokens
                  (for-each (lambda (x)
                              (unless (or (member x terms) (member x nonterms))
                                (parselynn:core:grammar-error "Invalid terminal or nonterminal: ~s" x)))
                            rhs)
                  ;; -- check 'error' productions
                  (check-error-production rhs)

                  (if (and (pair? rest)
                           (equal? (car rest) ':)
                           (pair? (cdr rest)))
                      (loop1 (cddr rest)
                             (+ i 1)
                             (let* ((action/0 (cadr rest))
                                    (action (serialize-action action/0)))
                               (cons (cons prod action)
                                     rev-productions-and-actions)))
                      (let* ((rhs-length (length rhs))
                             (action
                              (cons 'list
                                    (cons (list 'quote (string->symbol name))
                                          (let loop-j ((j 1))
                                            (if (> j rhs-length)
                                                '()
                                                (cons (string->symbol
                                                       (string-append
                                                        "$"
                                                        (number->string j)))
                                                      (loop-j (+ j 1)))))))))
                        (loop1 rest
                               (+ i 1)
                               (cons (cons prod action)
                                     rev-productions-and-actions))))))))))

  (define (valid-nonterminal? x)
    (symbol? x))

  (define (valid-terminal? x)
    (symbol? x))            ; DB

  ;; ----------------------------------------------------------------------
  ;; Miscellaneous
  ;; ----------------------------------------------------------------------
  (define (pos-in-list x lst)
    (let loop ((lst lst) (i 0))
      (cond ((not (pair? lst))    #f)
            ((equal? (car lst) x) i)
            (else                 (loop (cdr lst) (+ i 1))))))

  (define (sunion lst1 lst2)        ; union of sorted lists
    (let loop ((L1 lst1)
               (L2 lst2))
      (cond ((null? L1)    L2)
            ((null? L2)    L1)
            (else
             (let ((x (car L1)) (y (car L2)))
               (cond
                ((> x y)
                 (cons y (loop L1 (cdr L2))))
                ((< x y)
                 (cons x (loop (cdr L1) L2)))
                (else
                 (loop (cdr L1) L2))
                ))))))

  (define (sinsert elem lst)
    (let loop ((l1 lst))
      (if (null? l1)
          (cons elem l1)
          (let ((x (car l1)))
            (cond ((< elem x)
                   (cons elem l1))
                  ((> elem x)
                   (cons x (loop (cdr l1))))
                  (else
                   l1))))))

  (define (lalr-filter p lst)
    (let loop ((l lst))
      (if (null? l)
          '()
          (let ((x (car l)) (y (cdr l)))
            (if (p x)
                (cons x (loop y))
                (loop y))))))

  ;; ----------------------------------------------------------------------
  ;; Debugging tools ...
  ;; ----------------------------------------------------------------------
  (define the-terminals #f)        ; names of terminal symbols
  (define the-nonterminals #f)        ; non-terminals

  (define (print-item item-no)
    (let loop ((i item-no))
      (let ((v (vector-ref ritem i)))
        (if (>= v 0)
            (loop (+ i 1))
            (let* ((rlno    (- v))
                   (nt      (vector-ref rlhs rlno)))
              (display (vector-ref the-nonterminals nt)) (display " --> ")
              (let loop ((i (vector-ref rrhs rlno)))
                (let ((v (vector-ref ritem i)))
                  (when (= i item-no)
                    (display ". "))
                  (if (>= v 0)
                      (begin
                        (display (get-symbol v))
                        (display " ")
                        (loop (+ i 1)))
                      (begin
                        (display "   (rule ")
                        (display (- v))
                        (display ")")
                        (newline))))))))))

  (define (get-symbol n)
    (if (>= n nvars)
        (vector-ref the-terminals (- n nvars))
        (vector-ref the-nonterminals n)))


  (define (print-states)
    (define (print-action act)
      (cond
       ((equal? act '*error*)
        (display " : Error"))
       ((equal? act 'accept)
        (display " : Accept input"))
       ((< act 0)
        (display " : reduce using rule ")
        (display (- act)))
       (else
        (display " : shift and goto state ")
        (display act)))
      (newline)
      #t)

    (define (print-actions acts)
      (let loop ((l acts))
        (if (null? l)
            #t
            (let ((sym (caar l))
                  (act (cadar l)))
              (display "   ")
              (cond
               ((equal? sym 'default)
                (display "default action"))
               (else
                (if (number? sym)
                    (display (get-symbol (+ sym nvars)))
                    (display sym))))
              (print-action act)
              (loop (cdr l))))))

    (if (not action-table)
        (begin
          (display "No generated parser available!")
          (newline)
          #f)
        (begin
          (display "State table") (newline)
          (display "-----------") (newline) (newline)

          (let loop ((l first-state))
            (if (null? l)
                #t
                (let* ((core  (car l))
                       (i     (core-number core))
                       (items (core-items core))
                       (actions (vector-ref action-table i)))
                  (display "state ") (display i) (newline)
                  (newline)
                  (for-each (lambda (x) (display "   ") (print-item x))
                            items)
                  (newline)
                  (print-actions actions)
                  (newline)
                  (loop (cdr l))))))))



  ;; ----------------------------------------------------------------------

  (define build-goto-table
    (lambda ()
      `(vector
        ,@(map
           (lambda (shifts)
             (list 'quote
                   (if shifts
                       (let loop ((l (shift-shifts shifts)))
                         (if (null? l)
                             '()
                             (let* ((state  (car l))
                                    (symbol (vector-ref acces-symbol state)))
                               (if (< symbol nvars)
                                   (cons `(,symbol . ,state)
                                         (loop (cdr l)))
                                   (loop (cdr l))))))
                       '())))
           (vector->list shift-table)))))


  (define build-reduction-table
    (lambda (gram/actions)
      `(vector
        '()
        ,@(map
           (lambda (p)
             (let ((act (cdr p)))
               `(lambda ,(if (lr-driver?)
                             '(___stack ___sp ___goto-table ___push yypushback)
                             '(___sp ___goto-table ___push))
                  ,(let* ((nt (caar p)) (rhs (cdar p)) (n (length rhs)))
                     `(let* (,@(if act
                                   (let loop ((i 1) (l rhs))
                                     (if (pair? l)
                                         (let ((rest (cdr l))
                                               (ns (number->string (+ (- n i) 1))))
                                           (cons
                                            `(tok ,(if (lr-driver?)
                                                       `(vector-ref ___stack (- ___sp ,(- (* i 2) 1)))
                                                       `(list-ref ___sp ,(+ (* (- i 1) 2) 1))))
                                            (cons
                                             `(,(string->symbol (string-append "$" ns))
                                               (token-value/soft tok))
                                             (cons
                                              `(,(string->symbol (string-append "@" ns))
                                                (token-source/soft tok))
                                              (loop (+ i 1) rest)))))
                                         '()))
                                   '()))
                        ,(if (= nt 0)
                             '$1
                             `(___push ,n ,nt ,(cdr p) ,@(if (lr-driver?) '() '(___sp))
                                       ,(if (lr-driver?)
                                            `(vector-ref ___stack (- ___sp ,(length rhs)))
                                            `(list-ref ___sp ,(length rhs))))))))))

           gram/actions))))


  ;; Options

  (define driver-user-name->normalized-name-alist
    (map reverse parselynn:core:driver-normalized-name->type/alist))

  (define valid-driver-user-names
    (map car driver-user-name->normalized-name-alist))

  (define *valid-options*
    (list
     (cons 'results:
           (lambda (option)
             (and (list? option)
                  (list-length= 2 option)
                  (symbol? (cadr option))
                  (memq (cadr option) '(all first)))))

     (cons 'rules: (lambda (option) (list? option)))

     (cons 'tokens: (lambda (option) (list? option)))

     (cons 'lexer-code: (lambda (option) (pair? option)))

     (cons 'driver:
           (lambda (option)
             (and (list? option)
                  (list-length= 2 option)
                  (member (cadr option) valid-driver-user-names))))))


  (define (validate-options options)
    (for-each
     (lambda (option)
       (define p (assq-or (car option) *valid-options*))
       (unless p
         (parselynn:core:grammar-error "Invalid option: ~s" option))
       (unless (p option)
         (parselynn:core:grammar-error "Option ~s has invalid format: ~s"
                        (~a (car option))
                        option)))
     options))

  (define conflict-handler
    (or (parselynn:core:conflict-handler/p)
        parselynn:core:conflict-handler/default))

  (define (output-table! options)
    (define port (parselynn:core:output-table-port/p))
    (when port
      (parameterize ((current-output-port port))
        (print-states))))

  (define (set-results-mode! options)
    (let ((results-type (assq-or 'results: options)))
      (when results-type
        (set! results-mode (car results-type)))))

  (define (set-driver-normalized-name! options)
    (set! driver-user-name
          (car (assq-or 'driver: options driver-user-name)))

    (set!
     driver-normalized-name

     (car
      (assoc-or
       driver-user-name
       driver-user-name->normalized-name-alist

       (raisu-fmt
        'logic-error "Expected either of ~a but got ~s somehow."
        (apply
         string-append
         (list-intersperse
          ", " (map ~s valid-driver-user-names)))
        driver-user-name)))))

  (define (options-get-rules options)
    (assq-or 'rules: options
             (parselynn:core:grammar-error "Missing required option ~s" (~a 'rules:))))

  (define (options-get-tokens options)
    (assq-or 'tokens: options
             (parselynn:core:grammar-error "Missing required option ~s" (~a 'tokens:))))

  (define (options-get-results-mode options)
    (assq-or 'results: options 'all))

  (define (options-get-lexer-code options)
    (assq-or 'lexer-code: options #f))

  ;; -- arguments

  (define (extract-arguments lst)
    (let loop ((options '())
               (lst     lst))
      (cond
       ((pair? lst)
        (let ()
          (define p (car lst))
          (cond
           ((and (pair? p)
                 (fkeyword? (car p)))
            (loop (cons p options) (cdr lst)))
           (else
            (parselynn:core:grammar-error "Invalid option: ~s" (~a p))))))
       ((null? lst) options)
       (else
        (parselynn:core:grammar-error "Malformed parselynn form: ~s" lst)))))


  (define (get-code-actions)
    (list->vector (reverse actions-list)))

  (define (build-driver options)
    (define tokens (options-get-tokens options))
    (define rules (options-get-rules options))

    (define _val
      (begin
        (validate-options options)
        (set-driver-normalized-name! options)
        (set-results-mode! options)))

    (define lexer-code
      (options-get-lexer-code options))

    (define default-lexer-code
      `((lambda args
          (___scanner))))

    (define all-lexer-code
      (or lexer-code default-lexer-code))

    (define gram/actions (gen-tables! tokens rules))
    (define goto-table (build-goto-table))
    (define reduction-table (build-reduction-table gram/actions))

    (define (legacy-code driver-code)
      `(let ()
         ,@common-definitions-code
         (define action-table (quote ,action-table))
         (define goto-table ,goto-table)
         (lambda (actions)
           (define (external index . args) (apply (vector-ref actions index) args))
           (define reduction-table ,reduction-table)
           (lambda (___scanner ___errorp)
             (define get-next-token
               (let () ,@all-lexer-code))
             ,@driver-code))))

    (define code
      (cond
       ((lr-driver?)
        (legacy-code
         (lr-driver-code results-mode)))

       ((glr-driver?)
        (legacy-code
         (glr-driver-code results-mode)))

       (else
        (parselynn:core:novel
         driver-normalized-name
         all-lexer-code
         rules
         results-mode))))

    (define _output
      (begin
        (output-table! options)))

    (define actions (get-code-actions))
    (define maybefun
      #f)

    (make-parselynn:core:struct
     results-mode driver-normalized-name tokens
     rules actions code maybefun))

  (define options
    (extract-arguments arguments))

  (build-driver options))
