


(let () ;; string-plus-encode
  (define (test1 a b)
    (assert= a (string-plus-encode b)))

  (test1 "1234" "1234")
  (test1 "hello" "hello")
  (test1 "" "")
  (test1 "+5gL+5Ww+5br+7Nl" "你好世界")
  (test1 "hello+J+x+5gL+5Ww+5br+7Nl" "hello, 你好世界")
  (test1 "hello+J+x+5gL+5Ww+5br+7Nl+J+x+0c+3e+x+0va+12" "hello, 你好世界, cą va?")
  )
