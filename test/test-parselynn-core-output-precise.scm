
(let ()
  (define failures (stack-make))

  (define (check-code name filename)
    (define expected-filename
      (stringf "test/data/~a.sld" name))

    (define generated
      (call-with-input-file filename read-list))

    (define expected
      (if (file-exists? expected-filename)
          (call-with-input-file expected-filename read-list)
          #f))

    (unless (equal? expected generated)
      (stack-push! failures name)))

  (define (save+check type driver code)
    (define driver*
      (if (equal? "(LR 1)" driver) "lr-1" driver))
    (define name
      (string->symbol
       (stringf "parser-~a-~a" type driver*)))
    (define filename
      (stringf "scripts/generated/~a.sld" name))

    (call-with-output-file
        filename
      (lambda (p)
        (write `(define-library (data ,name)
                  (export ,name)
                  (import (scheme base) (euphrates stack)) ;; FIXME: remove the import.
                  (begin (define ,name ,code)))
               p)
        (newline p)))

    (check-code name filename))

  (define (generate-repating driver)
    (define parser
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (parselynn:core
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (driver: ,(un~s driver))
           (results: ,(if (equal? driver "glr") 'all 'first))
           (rules:
            (expr     (term add expr) : #t
                      (term) : #t)
            (add      (+) : #t)
            (term     (NUM) : #t))))))

    (save+check
     "repeating" driver
     (parselynn:core:serialize parser)))

  (define (generate-branching driver)
    (define parser
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (parselynn:core
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (driver: ,(un~s driver))
           (results: ,(if (equal? driver "glr") 'all 'first))
           (rules:
            (expr     (term add expr) : #t
                      (LPAREN expr RPAREN) : #t
                      (term) : #t)
            (add      (+) : #t)
            (term     (NUM) : #t))))))

    (save+check
     "branching" driver
     (parselynn:core:serialize parser)))

  (define (generate-large driver)
    (define numbers
      `(n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 n17 n18 n19 n20 n21 n22 n23 n24 n25 n26 n27 n28 n29 n30 n31 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 n49 n50 n51 n52 n53 n54 n55 n56 n57 n58 n59 n60 n61 n62 n63 n64 n65 n66 n67 n68 n69 n70 n71 n72 n73 n74 n75 n76 n77 n78 n79 n80 n81 n82 n83 n84 n85 n86 n87 n88 n89 n90 n91 n92 n93 n94 n95 n96 n97 n98 n99 n100 n101 n102 n103 n104 n105 n106 n107 n108 n109 n110 n111 n112 n113 n114 n115 n116 n117 n118 n119 n120 n121 n122 n123 n124 n125 n126 n127 n128 n129 n130 n131 n132 n133 n134 n135 n136 n137 n138 n139 n140 n141 n142 n143 n144 n145 n146 n147 n148 n149 n150 n151 n152 n153 n154 n155 n156 n157 n158 n159 n160 n161 n162 n163 n164 n165 n166 n167 n168 n169 n170 n171 n172 n173 n174 n175 n176 n177 n178 n179 n180 n181 n182 n183 n184 n185 n186 n187 n188 n189 n190 n191 n192 n193 n194 n195 n196 n197 n198 n199 n200 n201 n202 n203 n204 n205 n206 n207 n208 n209 n210 n211 n212 n213 n214 n215 n216 n217 n218 n219 n220 n221 n222 n223 n224 n225 n226 n227 n228 n229 n230 n231 n232 n233 n234 n235 n236 n237 n238 n239 n240 n241 n242 n243 n244 n245 n246 n247 n248 n249 n250 n251 n252 n253 n254 n255 n256 n257 n258 n259 n260 n261 n262 n263 n264 n265 n266 n267 n268 n269 n270 n271 n272 n273 n274 n275 n276 n277 n278 n279 n280 n281 n282 n283 n284 n285 n286 n287 n288 n289 n290 n291 n292 n293 n294 n295 n296 n297 n298 n299 n300))

    (define parser
      (parameterize ((parselynn:core:conflict-handler/p ignore))
        (parselynn:core
         `((tokens: + * - ^ % ,@numbers)
           (driver: ,(un~s driver))
           (results: ,(if (equal? driver "glr") 'all 'first))
           (rules:
            (expr    (term op expr) (term))
            (op      (+) (*) (-) (^) (%))
            (term    ,@(map list numbers)))))))

    (save+check
     "large" driver
     (parselynn:core:serialize parser)))

  (define (generate driver)
    (generate-repating driver)
    (generate-large driver)
    (generate-branching driver))

  (for-each generate '("lr" "glr" "(LR 1)"))

  (for-each
   (lambda (failure)
     (printf "FAIL: ~s\n" failure))
   (stack->list failures))

  (assert (stack-empty? failures)))
