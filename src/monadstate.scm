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

%var monadstate?
%var monadstate-cret
%var monadstate-cret/thunk
%var monadstate-ret
%var monadstate-ret/thunk
%var monadstate-make-empty
%var monadstate-qvar
%var monadstate-qval
%var monadstate-qtags
%var monadstate-lval
%var monadstate-arg
%var monadstate-args
%var monadstate-replicate-multiple
%var monadstate-handle-multiple

%use (identity*) "./identity-star.scm"
%use (memconst) "./memconst.scm"
%use (monadfinobj monadfinobj-lval monadfinobj?) "./monadfinobj.scm"
%use (monadstate-current/p) "./monadstate-current-p.scm"
%use (monadstateobj monadstateobj-cont monadstateobj-lval monadstateobj-qtags monadstateobj-qval monadstateobj-qvar monadstateobj?) "./monadstateobj.scm"
%use (raisu) "./raisu.scm"
%use (replicate) "./replicate.scm"

(define monadstate? monadstateobj?)

(define (monadstate-make-empty)
  (monadstateobj #f #f #f #f #f))

(define monadstate-qvar
  (case-lambda
   (() (monadstate-qvar (monadstate-current/p)))
   ((monadstate-input)
    (if (monadstateobj? monadstate-input)
        (monadstateobj-qvar monadstate-input)
        '()))))

(define monadstate-qval
  (case-lambda
   (() (monadstate-qval (monadstate-current/p)))
   ((monadstate-input)
    (if (monadstateobj? monadstate-input)
        (monadstateobj-qval monadstate-input)
        '()))))

(define monadstate-qtags
  (case-lambda
   (() (monadstate-qtags (monadstate-current/p)))
   ((monadstate-input)
    (if (monadstateobj? monadstate-input)
        (monadstateobj-qtags monadstate-input)
        '()))))

(define monadstate-lval
  (case-lambda
   (() (monadstate-lval (monadstate-current/p)))
   ((monadstate-input)
    (if (monadstateobj? monadstate-input)
        (monadstateobj-lval monadstate-input)
        (monadfinobj-lval monadstate-input)))))

(define monadstate-args
  (case-lambda
   (() (monadstate-args (monadstate-current/p)))
   ((monadstate-input)
    (if (monadstateobj? monadstate-input)
        ((monadstateobj-lval monadstate-input))
        ((monadfinobj-lval monadstate-input))))))

(define monadstate-arg
  (case-lambda
   (() (monadstate-arg (monadstate-current/p)))
   ((monadstate-input)
    (apply values (monadstate-args monadstate-input)))))

(define-syntax monadstate-cret
  (syntax-rules ()
    ((_ arg cont)
     (monadstate-cret (monadstate-current/p) arg cont))
    ((_ monadstate-input arg cont)
     (begin
       (unless (list? arg)
         (raisu 'monadstate-lval-must-be-list arg))

       (if (monadstateobj? monadstate-input)
           (monadstateobj
            (memconst arg)
            cont
            (monadstateobj-qvar monadstate-input)
            (monadstateobj-qval monadstate-input)
            (monadstateobj-qtags monadstate-input))
           (monadfinobj
            (memconst
             (call-with-values
                 (lambda _ (cont arg))
               identity*))))))))

(define-syntax monadstate-cret/thunk
  (syntax-rules ()
    ((_ arg cont)
     (monadstate-cret/thunk (monadstate-current/p) arg cont))
    ((_ monadstate-input arg cont)
     (begin
       (unless (list? arg)
         (raisu 'monadstate-lval-must-be-list arg))

       (if (monadstateobj? monadstate-input)
           (monadstateobj
            arg
            cont
            (monadstateobj-qvar monadstate-input)
            (monadstateobj-qval monadstate-input)
            (monadstateobj-qtags monadstate-input))
           (monadfinobj
            (memconst
             (call-with-values
                 (lambda _ (cont arg))
               identity*))))))))

(define-syntax monadstate-ret
  (syntax-rules ()
    ((_ arg)
     (monadstate-ret (monadstate-current/p) arg))
    ((_ monadstate-input arg)
     (begin
       (unless (list? arg)
         (raisu 'monadstate-lval-must-be-list arg))

       (if (monadfinobj? monadstate-input)
           (monadfinobj (lambda _ arg))
           (monadstateobj
            (lambda _ arg)
            (monadstateobj-cont monadstate-input)
            (monadstateobj-qvar monadstate-input)
            (monadstateobj-qval monadstate-input)
            (monadstateobj-qtags monadstate-input)))))))

(define-syntax monadstate-ret/thunk
  (syntax-rules ()
    ((_ arg)
     (monadstate-ret (monadstate-current/p) arg))
    ((_ monadstate-input arg)
     (if (monadfinobj? monadstate-input)
         (monadfinobj arg)
         (monadstateobj
          arg
          (monadstateobj-cont monadstate-input)
          (monadstateobj-qvar monadstate-input)
          (monadstateobj-qval monadstate-input)
          (monadstateobj-qtags monadstate-input))))))

(define monadstate-handle-multiple
  (case-lambda
   ((arg) (monadstate-handle-multiple (monadstate-current/p) arg))
   ((monadstate-input arg)
    (if (monadfinobj? monadstate-input)
        (arg)
        (let* ((qvar (monadstateobj-qvar monadstate-input))
               (len (if (list? qvar) (length qvar) 1)))
          (if (< len 2)
              arg
              (replicate len (arg))))))))

(define monadstate-replicate-multiple
  (case-lambda
   ((arg) (monadstate-handle-multiple (monadstate-current/p) arg))
   ((monadstate-input arg)
    (let* ((qvar (monadstateobj-qvar monadstate-input))
           (len (if (list? qvar) (length qvar) 1)))
      (if (< len 2)
          arg
          (replicate len arg))))))
