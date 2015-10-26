(include "base.scm")

; We start with a value for the radicand (x) and a value for the guess. If the
; guess is good enough for our purposes, we are done; if not, we must repeat
; the process with an improved guess:

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

; A guess is improved by averaging it with the quotient of the radicand and the
; old guess:

(define (improve guess x)
  (average guess (/ x guess)))

; where

(define (average x y)
  (/ (+ x y) 2))

; and
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
