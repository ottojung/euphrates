;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

%var monad-cret
%var monad-cret/thunk
%var monad-ret
%var monad-ret/thunk
%var monad-arg
%var monad-args
%var monad-replicate-multiple
%var monad-handle-multiple

%use (memconst) "./memconst.scm"
%use (monad-current-arg/p) "./monad-current-arg-p.scm"
%use (monadfin monadfin-lval monadfin?) "./monadfin.scm"
%use (monadstate monadstate-cont monadstate-lval monadstate-qtags monadstate-qval monadstate-qvar monadstate?) "./monadstate.scm"
%use (raisu) "./raisu.scm"
%use (replicate) "./replicate.scm"

(define monad-qvar
  (case-lambda
   (() (monad-qvar (monad-current-arg/p)))
   ((monad-input)
    (if (monadstate? monad-input)
        (monadstate-qvar monad-input)
        '()))))

(define monad-qval
  (case-lambda
   (() (monad-qval (monad-current-arg/p)))
   ((monad-input)
    (if (monadstate? monad-input)
        (monadstate-qval monad-input)
        '()))))

(define monad-qtags
  (case-lambda
   (() (monad-qtags (monad-current-arg/p)))
   ((monad-input)
    (if (monadstate? monad-input)
        (monadstate-qtags monad-input)
        '()))))

(define monad-args
  (case-lambda
   (() (monad-args (monad-current-arg/p)))
   ((monad-input)
    (if (monadstate? monad-input)
        ((monadstate-lval monad-input))
        ((monadfin-lval monad-input))))))

(define monad-arg
  (case-lambda
   (() (monad-arg (monad-current-arg/p)))
   ((monad-input)
    (apply values (monad-args monad-input)))))

(define-syntax monad-cret
  (syntax-rules ()
    ((_ arg cont)
     (monad-cret (monad-current-arg/p) arg cont))
    ((_ monad-input arg cont)
     (begin
       (unless (list? arg)
         (raisu 'monad-lval-must-be-list arg))

       (if (monadstate? monad-input)
           (monadstate (memconst arg)
                     cont
                     (monadstate-qvar monad-input)
                     (monadstate-qval monad-input)
                     (monadstate-qtags monad-input))
           (monadfin
            (memconst
              (call-with-values
                  (lambda _ (cont arg))
                (lambda vals vals)))))))))

(define-syntax monad-cret/thunk
  (syntax-rules ()
    ((_ arg cont)
     (monad-cret/thunk (monad-current-arg/p) arg cont))
    ((_ monad-input arg cont)
     (begin
       (unless (list? arg)
         (raisu 'monad-lval-must-be-list arg))

       (if (monadstate? monad-input)
           (monadstate arg
                     cont
                     (monadstate-qvar monad-input)
                     (monadstate-qval monad-input)
                     (monadstate-qtags monad-input))
           (monadfin
            (memconst
              (call-with-values
                  (lambda _ (cont arg))
                (lambda vals vals)))))))))

(define-syntax monad-ret
  (syntax-rules ()
    ((_ arg)
     (monad-ret (monad-current-arg/p) arg))
    ((_ monad-input arg)
     (begin
       (unless (list? arg)
         (raisu 'monad-lval-must-be-list arg))

       (if (monadfin? monad-input)
           (monadfin (lambda _ arg))
           (monadstate (memconst arg)
                     (monadstate-cont monad-input)
                     (monadstate-qvar monad-input)
                     (monadstate-qval monad-input)
                     (monadstate-qtags monad-input)))))))

(define-syntax monad-ret/thunk
  (syntax-rules ()
    ((_ arg)
     (monad-ret (monad-current-arg/p) arg))
    ((_ monad-input arg)
     (if (monadfin? monad-input)
         (monadfin arg)
         (monadstate arg
                   (monadstate-cont monad-input)
                   (monadstate-qvar monad-input)
                   (monadstate-qval monad-input)
                   (monadstate-qtags monad-input))))))

(define monad-handle-multiple
  (case-lambda
   ((arg) (monad-handle-multiple (monad-current-arg/p) arg))
   ((monad-input arg)
    (if (monadfin? monad-input)
        (arg)
        (let* ((qvar (monadstate-qvar monad-input))
               (len (if (list? qvar) (length qvar) 1)))
          (if (< len 2)
              arg
              (replicate len (arg))))))))

(define monad-replicate-multiple
  (case-lambda
   ((arg) (monad-handle-multiple (monad-current-arg/p) arg))
   ((monad-input arg)
    (let* ((qvar (monadstate-qvar monad-input))
           (len (if (list? qvar) (length qvar) 1)))
      (if (< len 2)
          arg
          (replicate len arg))))))
