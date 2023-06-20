# bytemap

Bytemap is a library for making bitmaps out of braille characters (a braille character contains eight "bits").

```janet
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
`)
```
