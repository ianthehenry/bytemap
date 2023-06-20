(use judge)

(def- least-six-bit-mask 0x3f)
(def- least-four-bit-mask 0x0f)

(defn encode [codepoint]
  (def first-six (band codepoint least-six-bit-mask))
  (def next-six  (band (brshift codepoint 6) least-six-bit-mask))
  (def next-four (band (brshift codepoint 6 6) least-four-bit-mask))

  [(bor 0xe0 next-four)
   (bor 0x80 next-six)
   (bor 0x80 first-six)])

(defn set-bit [num i value]
  (if value
    (bor num (blshift 1 i))
    (band num (bnot (blshift 1 i)))))

(defn idiv [a b]
  (math/floor (/ a b)))
