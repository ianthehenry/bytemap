(use judge)
(use ../src)

(deftest "union jack"
  (def canvas (new 10 5))
  (for x 0 20
    (draw canvas [x x])
    (draw canvas [x (- 20 x)]))

  (for x 0 20
    (draw canvas [10 x])
    (draw canvas [x 10]))

  (test-stdout (print-canvas canvas) `
    ⠑⢄⠀⠀⠀⡇⠀⠀⢀⠔
    ⠀⠀⠑⢄⠀⡇⢀⠔⠁⠀
    ⠤⠤⠤⠤⢵⣷⠥⠤⠤⠤
    ⠀⠀⢀⠔⠁⡇⠑⢄⠀⠀
    ⢀⠔⠁⠀⠀⡇⠀⠀⠑⢄
  `))

(deftest "fill"
  (def canvas (new 10 5))
  (for x 0 20
    (for y 0 20
      (draw canvas [x y])))

  (test-stdout (print-canvas canvas) `
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
  `))

(deftest "sine"
  (test-stdout (plot math/sin [40 10] math/pi 1) `
    ⠀⠀⠀⠀⠀⠀⢀⠤⠒⠒⠑⠒⠤⡀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠈⠢⡀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⡠⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⢀⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⡀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢄⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⡯⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⢉⠍
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠑⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠂⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠈⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠔⠁⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠑⠤⣀⡀⣀⣀⠤⠊⠀⠀⠀⠀⠀⠀
  `))

(deftest "plot should draw lines rather than individual points"
  (test-stdout (plot math/sin [10 10] math/pi 1 :axis false) `
    ⠀⠀⠒⠄⠀⠀⠀⠀⠀⠀
    ⠀⠈⠀⠠⠀⠀⠀⠀⠀⠀
    ⠀⠁⠀⠀⡀⠀⠀⠀⠀⠀
    ⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀
    ⠁⠀⠀⠀⠀⡀⠀⠀⠀⠈
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
    ⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠄⠀⠈⠀
    ⠀⠀⠀⠀⠀⠀⠠⣀⠁⠀
  `))
