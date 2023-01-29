
(cond-expand
 (guile
  (define-module (test-uri-encode)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates uri-encode) :select (uri-encode)))))


(let () ;; uri-encode
  (define (test1 a b)
    (assert= a (uri-encode b)))

  (test1 "1234" "1234")
  (test1 "hello" "hello")
  (test1 "" "")
  (test1 "%E4%BD%A0%E5%A5%BD%E4%B8%96%E7%95%8C" "你好世界")
  (test1 "hello%2C%20%E4%BD%A0%E5%A5%BD%E4%B8%96%E7%95%8C" "hello, 你好世界")
  (test1 "hello%2C%20%E4%BD%A0%E5%A5%BD%E4%B8%96%E7%95%8C%2C%20c%C4%85%20va%3F" "hello, 你好世界, cą va?")
  )
