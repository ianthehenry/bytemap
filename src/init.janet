(use judge)
(import ./util)

(defn braille [byte]
  (def codepoint (+ 0x2800 byte))
  (string/from-bytes ;(util/encode codepoint)))

# x will be 0-1 inclusive; y will be 0-3 inclusive
(defn bit-of-subpixel [[x y]]
  (if (= y 3)
    (+ 6 x)
    (+ (* 3 x) y)))

(defn set-subpixel [num subpixel value]
  (util/set-bit num (bit-of-subpixel subpixel) value))

(test-stdout
  (loop [x :range-to [0 1]
         y :range-to [0 3]]
    (prin (braille (set-subpixel 0 [x y] true)))) `
  ⠁⠂⠄⡀⠈⠐⠠⢀
`)

# width is in "pixels"
# height is in "pixels"
(defn new [width height]
  {:width width
   :height height
   :pixels (array/new-filled (* width height) 0)})

# returns width and height in "subpixels"
(defn bounds [canvas]
  (def {:width width :height height} canvas)
  [(* 2 width) (* 4 height)])

(defn draw [canvas [x y] &opt value]
  (default value true)
  (def {:width width :height height :pixels pixels} canvas)
  (def [pixel-x pixel-y] [(util/idiv x 2) (util/idiv y 4)])
  (when (or (< pixel-x 0) (< pixel-y 0)
            (>= pixel-x width) (>= pixel-y height))
    (break))
  (def pixel-ix (+ (* pixel-y width) pixel-x))
  (def subpixel [(mod x 2) (mod y 4)])
  (update pixels pixel-ix |(set-subpixel $ subpixel value))
  nil)

(defn print-canvas [canvas]
  (def {:width width :height height :pixels pixels} canvas)
  (loop [y :range [0 height]
         :after (print)
         x :range [0 width]
         :let [i (+ (* y width) x)]]
    (prin (braille (pixels i)))))

(defn plot [f [w h] x-scale y-scale &named axis]
  (default axis true)
  (def canvas (new w h))
  (def [w h] (bounds canvas))
  (def cx (/ w 2))
  (def cy (/ h 2))

  (def y-scale (* y-scale (/ (+ h 1) h)))

  (when axis
    (for i 0 h
      (draw canvas [cx i]))
    (for i 0 w
      (draw canvas [i cy])))
  # this should be drawing lines, not points, in case the value
  # changes rapidly
  (for i 0 w
    # x spans -0.5 to 0.5
    (def x (/ (- i cx) w))
    (def y (* (/ cy y-scale) (f (* x 2 x-scale))))
    (draw canvas [(+ cx (math/round (* x w))) (+ cy (math/round y))]))
  (print-canvas canvas))
