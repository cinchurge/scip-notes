(include "base.scm")

; We start with a value for the radicand (x) and a value for the guess. If the
; guess is good enough for our purposes, we are done; if not, we must repeat
; the process with an improved guess:

(define (sqrt-iter guess x)
  (define (sqrt-iter-impl guess x prev-guess)
    (if (good-enough? guess prev-guess)
        guess
        (sqrt-iter-impl (improve guess x) x guess)))
  (sqrt-iter-impl guess x (+ guess 1)))

; A guess is improved by averaging it with the quotient of the radicand and the
; old guess:

(define (improve guess x)
  (average guess (/ x guess)))

; where

(define (average x y)
  (/ (+ x y) 2))

; and

(define (good-enough? guess prev-guess)
  (< (/ (abs (- guess prev-guess)) prev-guess) 0.001))


;
; Implementation of cube-root
;
(define (cube-root-iter guess x)
  (define (cube-root-iter-impl guess x prev-guess)
    (if (good-enough? guess prev-guess)
        guess
        (cube-root-iter-impl (cube-root-improve guess x) x guess)))
  (cube-root-iter-impl guess x (+ guess 1)))

(define (cube-root-improve y x)
  (/ (+ (/ x (square y))
        (* 2 y))
     3))

