
%run guile

%use (make-unique) "./make-unique.scm"
%use (make-hashmap hashmap->alist alist->hashmap hashmap-foreach) "./ihashmap.scm"
%use (raisu) "./raisu.scm"

%var hash->mdict
%var ahash->mdict
%var mdict
%var mdict-has?
%var mdict-set!
%var mdict->alist
%var mdict-keys

(define [hash->mdict h]
  (let [[unique (make-unique)]]
    (case-lambda
      [[] h]
      [[key]
       (let [[g (hash-ref h key unique)]]
         (if (unique g)
             (raisu 'mdict-key-not-found key h)
             g))]
      [[key value]
       (let* [[new (make-hashmap)]]
         (hashmap-foreach
          (lambda (key value)
            (hash-set! new key value))
          h)
         (hash-set! new key value)
         (hash->mdict new))])))

(define [alist->mdict alist]
  (hash->mdict (alist->hashmap alist)))

(define-syntax mdict-c
  (syntax-rules ()
    [(mdict-c carry) (alist->mdict carry)]
    [(mdict-c carry key value . rest)
     (mdict-c (cons (cons key value) carry) . rest)]))

(define-syntax-rule [mdict . entries]
  (mdict-c '() . entries))

(define [mdict-has? h-func key]
  (let [[h (h-func)]]
    (hash-get-handle h key)))

(define [mdict-set! h-func key value]
  (let [[h (h-func)]]
    (hash-set! h key value)))

(define [mdict->alist h-func]
  (let [[h (h-func)]]
    (hashmap->alist h)))

(define [mdict-keys h-func]
  (map car (mdict->alist h-func)))
