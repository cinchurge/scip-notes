(require-extension test)

;
; Exercise 1.1: What is the result printed by the interpreter in response to
;               each expression?

10 ; => 10

(+ 5 3 4) ; => 12

(- 9 1) ; => 8

(/ 6 2) ; => 3

(+ (* 2 4) (- 4 6)) ; => 6

(define a 3) ; => nothing, sets a=3 in the environment

(define b (+ a 1)) ; => nothing, sets b=4 in the environment

(+ a b (* a b)) ; => 19

(= a b) ; => #f

(if (and (> b a) (< b (* a b)))
    b
    a) ; => 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) ; => 16

(+ 2 (if (> b a) b a)) ; => 6

; The below should be 16
(test 16 (* (cond ((> a b) a)
                  ((< a b) b)
                  (else -1))
            (+ a 1)))


;
; Exercise 1.2: Translate the expression into prefix form
;
(/ (+ 5
      4
      (- 2
         (- 3
            (+ 6
               (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))


;
; Exercise 1.3: Define a procedure that takes three numbers as arguments and
;               returns the sum of the squares of the two larger numbers
(define (square x) (* x x))
(define (sum-of-squares x y)
        (+ (square x) (square y)))
(define (sum-of-squares-of-largest-two x y z)
  (cond ((and (<= z y) (<= z x)) (sum-of-squares x y))
         ((and (<= y x) (<= y z)) (sum-of-squares x z))
         ((and (<= x y) (<= x z)) (sum-of-squares y z))
         (else (error "blah"))))

; Tests:
(test 4 (square 2))
(test 8 (sum-of-squares 2 2))
(test 13 (sum-of-squares-of-largest-two 1 2 3))
(test 13 (sum-of-squares-of-largest-two 3 2 1))
(test 13 (sum-of-squares-of-largest-two 3 1 2))
(test 2 (sum-of-squares-of-largest-two 1 1 1))
(test 5 (sum-of-squares-of-largest-two 2 1 1))


;
; Exercise 1.4: Describe the behavior of the following procedure:
;
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; The + or - operation is determined from whether b is positive or not.
; If b is positive, we have a + b, otherwise a - b.

; Tests:
(test 2 (a-plus-abs-b 1 1))
(test 2 (a-plus-abs-b 1 -1))


;
; Exercise 1.5: Describe the behavior of the following expressions
;               for applicative order and normal order
;
; (define (p) (p))
; (define (test* x y)
;   (if (= x 0) 0 y))
; (test* 0 (p))
;
; With applicative order, all arguments are evaluated before passing
; into the body of the procedure; and since (p) is an infinite-recursive
; procedure, the program will hang.
;
; With normal order, the arguments are merely subsituted into the
; body of the procedure and not evaluted until the entire procedure
; is fully expanded, resulting in the following expression:
;   (if (= 0 0) 0 (p))
; which will only evaluate the expression where the predicate is true,
; and returning 0. It will never reach the infinite-recursive (p) procedure
; and thus will not hang.
