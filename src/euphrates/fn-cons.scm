


(define fn-cons
  (case-lambda
   ((fn-car fn-cdr)
    (lambda (lst)
      (cons (fn-car (car lst)) (fn-cdr (cdr lst)))))
   ((fn-car fn-cadr . fns)
    (lambda (lst)
      (cons (fn-car (car lst))
            (cons (fn-cadr (cadr lst))
                  (let loop ((lst (cddr lst)) (fns fns))
                    (if (null? fns) lst
                        (if (null? (cdr fns))
                            ((car fns) lst)
                            (cons ((car fns) (car lst))
                                  (loop (cdr lst) (cdr fns))))))))))))
