(define (square x)
  (* x x))

(define (abs-diff x y)
  (abs (- x y)))

(define (fractional-diff x y)
  (/ (abs-diff x y) y))

(define (average x y)
  (/ (+ x y) 2))

