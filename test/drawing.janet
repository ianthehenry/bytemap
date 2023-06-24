(use judge)
(use ../src)

(deftest "union jack"
  (def canvas (new 10 5))
  (for x 0 20
    (draw-point canvas [x x])
    (draw-point canvas [x (- 20 x)]))

  (for x 0 20
    (draw-point canvas [10 x])
    (draw-point canvas [x 10]))

  (test-stdout (print-canvas canvas) `
    ⠑⢄⠀⠀⠀⡇⠀⠀⢀⠔
    ⠀⠀⠑⢄⠀⡇⢀⠔⠁⠀
    ⠤⠤⠤⠤⢵⣷⠥⠤⠤⠤
    ⠀⠀⢀⠔⠁⡇⠑⢄⠀⠀
    ⢀⠔⠁⠀⠀⡇⠀⠀⠑⢄
  `))

(deftest "fill"
  (def canvas (new 10 5))
  (loop [x :range [0 30]
         y :range [0 30]]
    (draw-point canvas [x y]))

  (test-stdout (print-canvas canvas) `
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
  `))

(deftest "sine"
  (test-stdout (plot math/sin [40 10] math/pi 1) `
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⢀⠴⠒⠚⠓⠒⢤⡀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠈⠢⡀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢆⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⡀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡷⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄
    ⠹⡉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⢉⠝⡏⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉
    ⠀⠘⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠊⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠈⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠁⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠑⢤⣀⣀⣀⣀⡴⠊⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  `))

(deftest "plot draws lines rather than individual points"
  (test-stdout (plot math/sin [10 10] math/pi 1 :axis false) `
    ⠀⠀⠀⠀⠀⠀⢠⠲⡀⠀
    ⠀⠀⠀⠀⠀⠀⡇⠀⢇⠀
    ⠀⠀⠀⠀⠀⢰⠁⠀⠸⡀
    ⠀⠀⠀⠀⠀⡸⠀⠀⠀⡇
    ⠀⠀⠀⠀⠀⡇⠀⠀⠀⢣
    ⡇⠀⠀⠀⢰⠁⠀⠀⠀⠈
    ⢸⠀⠀⠀⡸⠀⠀⠀⠀⠀
    ⠈⡆⠀⠀⡇⠀⠀⠀⠀⠀
    ⠀⢇⠀⢸⠀⠀⠀⠀⠀⠀
    ⠀⠘⣄⠇⠀⠀⠀⠀⠀⠀
  `))

(deftest "line"
  (def canvas (new 10 5))
  (draw-line canvas [0 0] [20 20])
  (draw-line canvas [0 5] [20 10])
  (draw-line canvas [5 15] [20 5])
  (test-stdout (print-canvas canvas) `
    ⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀
    ⠒⠢⠵⢄⣀⡀⠀⠀⢀⠤
    ⠀⠀⠀⠀⠑⢌⠭⠛⠓⠢
    ⠀⠀⢀⠤⠊⠁⠑⢄⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄
  `))

(def tau (* 2 math/pi))

(deftest "draw-line can draw lines in any direction"
  (def c 30)
  (def canvas (new c (/ c 2)))
  (def r (- c 1))
  (def points 20)
  (for i 0 points
    (def angle (+ 0.1 (* i (/ tau points))))
    (draw-line canvas [c c]
      [(+ c (* r (math/cos angle)))
       (+ c (* r (math/sin angle)))]))

  (test-stdout (print-canvas canvas) `
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⢰⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠐⡄⠀⠀⠀⢱⠀⠀⠀⡜⠀⠀⠀⡰⠁⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⡀⠀⠀⠀⠘⢄⠀⠀⠈⡆⠀⠀⡇⠀⠀⡰⠁⠀⠀⡠⠊⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠈⠢⣀⠀⠀⠈⢆⠀⠀⢣⠀⠀⡇⠀⢠⠃⠀⢀⠜⠀⠀⠀⠀⢀⠀⠀
    ⠀⠠⢄⡀⠀⠀⠀⠑⢄⠀⠈⢢⠀⠸⡀⢸⠀⢠⠃⢀⠔⠁⠀⠀⣀⠤⠒⠁⠀⠀
    ⠀⠀⠀⠈⠑⠢⠤⣀⠀⠑⢄⡀⠣⡀⢇⢸⢀⠎⡰⠁⠀⡠⠔⠊⠀⠀⠀⠀⠀⠀
    ⢀⣀⣀⠀⠀⠀⠀⠀⠉⠒⠢⢌⡢⡱⣸⣜⡮⢊⠤⠒⠉⣀⣀⡠⠤⠔⠒⠒⠉⠁
    ⠀⠀⠀⠉⠉⠉⠉⠉⠒⠒⠒⢒⣚⣽⢷⣿⣾⢗⣊⣉⣉⣀⡀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⢀⣀⡠⠤⠤⠒⠒⠊⠉⡡⠔⡞⣝⢿⢗⠭⡒⠤⢄⡀⠈⠉⠉⠉⠉⠑⠒⠂
    ⠀⠉⠁⠀⠀⠀⠀⢀⡠⠒⠉⡠⠊⡜⢸⠈⡆⢣⠈⠢⡀⠈⠑⠒⠤⣀⠀⠀⠀⠀
    ⠀⠀⠀⠀⣀⠔⠊⠁⠀⡠⠊⠀⡰⠁⢸⠀⢣⠀⠣⡀⠈⠢⢄⠀⠀⠀⠉⠒⠂⠀
    ⠀⠀⠐⠉⠀⠀⠀⢀⠔⠁⠀⢰⠁⠀⡎⠀⠸⡀⠀⠱⡀⠀⠀⠑⢄⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⢀⠔⠁⠀⠀⢠⠃⠀⠀⡇⠀⠀⢇⠀⠀⠘⡄⠀⠀⠀⠑⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⢀⠇⠀⠀⢸⠀⠀⠀⠘⢄⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠸⠀⠀⠀⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  `))
