# bytemap

Bytemap is a library for making bitmaps out of braille characters (a braille character contains eight "bits").

```janet
(bytemap/plot math/sin [40 10] math/pi 1)

# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⢀⠴⠒⠚⠓⠒⢤⡀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠈⠢⡀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢆⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⢠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⡀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡷⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄
# ⠹⡉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⢉⠝⡏⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉
# ⠀⠘⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠊⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠈⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠁⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠑⢤⣀⣀⣀⣀⡴⠊⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# 
```

There are two ways to draw: `draw-point` and `draw-line`.

```janet
(def canvas (new 10 5))
(for x 0 20
  (draw-point canvas [x x])
  (draw-point canvas [x (- 20 x)]))

(for x 0 20
  (draw-point canvas [10 x])
  (draw-point canvas [x 10]))

(print-canvas canvas)

# ⠑⢄⠀⠀⠀⡇⠀⠀⢀⠔
# ⠀⠀⠑⢄⠀⡇⢀⠔⠁⠀
# ⠤⠤⠤⠤⢵⣷⠥⠤⠤⠤
# ⠀⠀⢀⠔⠁⡇⠑⢄⠀⠀
# ⢀⠔⠁⠀⠀⡇⠀⠀⠑⢄
```

# The grid

Bytemap draws onto a grid that looks like this:

```
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
```

Each character is 2x4 dots wide, but these dots are positioned as if they lie on a 3x6 grid: there is almost exactly one dot of space in between each character horizontally and two dots of space vertically.

You could choose to ignore the gaps, or you could try to take them into account and insert "phantom" dots in your grid that cannot actually be set. These two approaches have different tradeoffs: if you draw onto a 2x4 grid, straight lines won't actually look straight:

```
  2x4 grid      3x6 grid
⠑⢄⠀⠀⠀⡇⠀⠀⢀⠔   ⠑⡀⠀⠀⠀⡇⠀⠀⠀⡠ 
⠀⠀⠑⢄⠀⡇⢀⠔⠁⠀   ⠀⠀⠑⡀⠀⡇⠀⡠⠁⠀ 
⠤⠤⠤⠤⢵⣷⠥⠤⠤⠤   ⣀⣀⣀⣀⣑⣧⣁⣀⣀⣀ 
⠀⠀⢀⠔⠁⡇⠑⢄⠀⠀   ⠀⠀⠀⡠⠁⡇⠑⡀⠀⠀ 
⢀⠔⠁⠀⠀⡇⠀⠀⠑⢄   ⠀⡠⠁⠀⠀⡇⠀⠀⠑⡀ 
```

But if you draw onto a 3x6 grid, certain important dots might be missing. Here's what a radial pattern of straight lines looks like with each approach:

```
             2x4 grid                           3x6 grid
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⢰⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⢰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠐⡄⠀⠀⠀⢱⠀⠀⠀⡜⠀⠀⠀⡰⠁⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠸⠀⠀⠀⡇⠀⠀⠀⢀⠁⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⡀⠀⠀⠀⠘⢄⠀⠀⠈⡆⠀⠀⡇⠀⠀⡰⠁⠀⠀⡠⠊⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢆⠀⠀⠀⡄⠀⠀⡇⠀⠀⠀⠁⠀⠀⠀⠔⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠈⠢⣀⠀⠀⠈⢆⠀⠀⢣⠀⠀⡇⠀⢠⠃⠀⢀⠜⠀⠀⠀⠀⢀⠀⠀  ⠀⠀⠀⠀⠀⠢⡀⠀⠀⠀⢢⠀⠀⢱⠀⠀⠀⠀⠀⠃⠀⠀⡠⠁⠀⠀⠀⠀⠀⠀ 
⠀⠠⢄⡀⠀⠀⠀⠑⢄⠀⠈⢢⠀⠸⡀⢸⠀⢠⠃⢀⠔⠁⠀⠀⣀⠤⠒⠁⠀⠀  ⠀⠀⡀⠀⠀⠀⠀⠑⡀⠀⠀⠱⠀⠀⠀⢠⠀⠀⠎⠀⢀⠁⠀⠀⠀⣀⠔⠁⠀⠀ 
⠀⠀⠀⠈⠑⠢⠤⣀⠀⠑⢄⡀⠣⡀⢇⢸⢀⠎⡰⠁⠀⡠⠔⠊⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠑⠢⣀⠀⠀⠈⢄⠀⠑⠀⢣⢸⠀⡜⢀⠊⠀⠀⡠⠊⠀⠀⠀⠀⠀⠀ 
⢀⣀⣀⠀⠀⠀⠀⠀⠉⠒⠢⢌⡢⡱⣸⣜⡮⢊⠤⠒⠉⣀⣀⡠⠤⠔⠒⠒⠉⠁  ⠀⠀⠀⠀⠀⠀⠀⠀⠈⠒⠤⡈⠢⠈⡈⡇⡜⠔⢀⠔⠉⠀⠀⠀⣀⠤⠤⠒⠊⠁ 
⠀⠀⠀⠉⠉⠉⠉⠉⠒⠒⠒⢒⣚⣽⢷⣿⣾⢗⣊⣉⣉⣀⡀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠉⠉⠉⠑⠒⠒⠒⠤⠤⠤⣀⣉⣪⣷⣶⠔⠒⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⢀⣀⡠⠤⠤⠒⠒⠊⠉⡡⠔⡞⣝⢿⢗⠭⡒⠤⢄⡀⠈⠉⠉⠉⠉⠑⠒⠂  ⠀⠀⠀⠀⠀⣀⡠⠤⠒⠊⠉⢀⠔⢉⡱⢻⢕⢍⠒⢄⠀⠀⠀⠈⠉⠉⠉⠒⠒⠒ 
⠀⠉⠁⠀⠀⠀⠀⢀⡠⠒⠉⡠⠊⡜⢸⠈⡆⢣⠈⠢⡀⠈⠑⠒⠤⣀⠀⠀⠀⠀  ⠀⠉⠀⠀⠀⠀⠀⠀⡠⠒⠁⢀⠊⢠⠀⠀⡀⢆⠈⢄⠀⠀⠑⠤⣀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⣀⠔⠊⠁⠀⡠⠊⠀⡰⠁⢸⠀⢣⠀⠣⡀⠈⠢⢄⠀⠀⠀⠉⠒⠂⠀  ⠀⠀⠀⠀⢀⠤⠊⠀⠀⠀⠔⠀⢀⠀⢸⠀⢣⠀⠣⠀⠀⠢⠀⠀⠀⠀⠉⠒⢄⠀ 
⠀⠀⠐⠉⠀⠀⠀⢀⠔⠁⠀⢰⠁⠀⡎⠀⠸⡀⠀⠱⡀⠀⠀⠑⢄⠀⠀⠀⠀⠀  ⠀⠀⠐⠁⠀⠀⠀⠀⡔⠀⠀⢀⠁⠀⢸⠀⠀⠀⠀⠱⠀⠀⠀⠑⡀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⢀⠔⠁⠀⠀⢠⠃⠀⠀⡇⠀⠀⢇⠀⠀⠘⡄⠀⠀⠀⠑⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⡠⠁⠀⠀⠀⠃⠀⠀⡇⠀⠀⢇⠀⠀⠘⡀⠀⠀⠀⠑⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⢀⠇⠀⠀⢸⠀⠀⠀⠘⢄⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⠀⠀⠃⠀⠀⠘⠀⠀⠀⠈⡀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠸⠀⠀⠀⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  
```

Although the lines on the right are better approximations of straight, there are lots of gaps when the lines happen to align with the phantom dots.

Ultimately, although the distortion of straight lines from the 2x4 grid representation is annoying, the lost information from the 3x6 dots is worse. Here's an example of plotting a sine wave:

```
  2x4 grid         3x6 grid
 ⠀⠀⠀⠀⠀⠀⢠⠲⡀⠀     ⠀⠀⠀⠀⠀⠀⠀⠒⠀⠀ 
 ⠀⠀⠀⠀⠀⠀⡇⠀⢇⠀     ⠀⠀⠀⠀⠀⠀⡸⠀⢸⠀ 
 ⠀⠀⠀⠀⠀⢰⠁⠀⠸⡀     ⠀⠀⠀⠀⠀⠀⠁⠀⠀⡀ 
 ⠀⠀⠀⠀⠀⡸⠀⠀⠀⡇     ⠀⠀⠀⠀⠀⢸⠀⠀⠀⡇ 
 ⠀⠀⠀⠀⠀⡇⠀⠀⠀⢣     ⠀⠀⠀⠀⠀⡎⠀⠀⠀⢸ 
 ⡇⠀⠀⠀⢰⠁⠀⠀⠀⠈     ⡇⠀⠀⠀⠀⠁⠀⠀⠀⠀ 
 ⢸⠀⠀⠀⡸⠀⠀⠀⠀⠀     ⢸⠀⠀⠀⢰⠀⠀⠀⠀⠀ 
 ⠈⡆⠀⠀⡇⠀⠀⠀⠀⠀     ⠀⡀⠀⠀⡇⠀⠀⠀⠀⠀ 
 ⠀⢇⠀⢸⠀⠀⠀⠀⠀⠀     ⠀⢇⠀⠀⠀⠀⠀⠀⠀⠀ 
 ⠀⠘⣄⠇⠀⠀⠀⠀⠀⠀     ⠀⠀⠀⡜⠀⠀⠀⠀⠀⠀ 
```

Because of this, Bytemap adopts the 2x4 grid exclusively.
