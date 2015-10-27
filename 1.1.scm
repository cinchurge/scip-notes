(require-extension test)

;;
;; 1.1 The elements of programming
;;

; (non-)distinction of procedures and data

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 1.1.1 Expressions
;;

; Lisp expressions:
; use prefix notation
; can be nested to arbitrary depth
; coding convention is to use pretty printing so it is more readable
; First mention of “repl": the read-eval-print loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 1.1.2 Naming and the environment
;;

; Variable definitions in Lisp: (define pi 3.14159)
; First mention of the environment: the internal memory of Lisp that keeps track of name-object associations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 1.1.3 Evaluating combinations
;;

; Emphasis that evaluation is a recursive process: the rules of evaluation are the same for subexpressions as it is for the main expression. Values “percolate” from the terminal nodes up to the final result.
; Evaluation of combinations will eventually end up as the evaluation of primitives, whose evaluation is based on
; The values of the numerals are the numbers they name
; The values of built-in operators are the machine instruction sequences that carry out the corresponding operations
; The values of other names are the objects associated with those names in the environment
; Emphasis of the importance of the environment as a “context” to evaluation
; Exceptions to the general rule of evaluation are called "special forms", such as “define”, which is not a primitive nor an expression

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 1.1.4 Compound procedures
;;

; Review of elements introduced so far:
; Numbers and arithmetic operations are primitive data and procedures
; Nesting of combinations provides a means of combining operations
; Definitions that associate names with values provide a limited means of abstraction
; General form for defining "compound procedures” (as opposed to “primitive procedures”):
; (define (<name> <formal parameters>)
;            <body>)
; For example, the “square” procedure would be defined as:
; (define (square x)
;            (* x x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 1.1.5 The substitution model for procedure application
;;

; Rule for evaluating compound procedures:
;   Evaluate the body of the procedure with each formal parameter replaced by the corresponding argument
; The process of substituting the arguments from the top down is the “substitution model” for procedure application. This model exists for pedagogical reasons, and doesn’t represent the actual implementation of the interpreter.
; 
; *Applicative order vs normal order*
; Applicative order: evaluate arguments then apply
; Normal order: fully expand then reduce
; For procedures that can be modeled with substitution and that yield legitimate , applicative order and normal order produce the same results

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 1.1.6 Conditional expressions and predicates
;;

; Case analyses: a special form in lisp that allows conditional execution
; (cond (<p1> <e1>)
;           (<p2> <e2>)
;           (<p3> <e3>)
;           …
;           (<pn> <en>))
; The expressions (<p> <e>) are clauses, where <p> is the predicate and <e> is the consequent expression
; 
; “if” is a special form that is a restricted type of conditional which is used when there are precisely two cases in the case analysis
; 
; Logical composition operations such as “and”, “or”, and “not" enable construction of compound predicates. “and” and “or” are actually special forms, since not all arguments are evaluated

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 1.1.7
;;

; Emphasis on the distinction between "declarative knowledge” (properties of
; things) and “imperative knowledge” (how to do things)
;
; Implementation of Newton's method for finding square roots:
;   Whenever we have a guess y for the value of the square root of a number
;   x, we can get a better guess by averaging y with x/y

(include "newtons_method.scm")

(test 4 (square 2))
(define (sqrt x)
  (sqrt-iter 1.0 x))
(test #t (< (abs-diff (sqrt 9) 3) 0.001))

; Emphasis that no special looping construct is needed to do iteration in
; scheme; recursively calling the same procedure is sufficient to acheive
; iteration. Efficiency-wise, this is acheived through "tail-recursion",
; or "tail call optimization" in the interpreter, which analyzes the code
; and decides whether or not to actually recurse or merely iterate.

;
; Exercise 1.6: Explain what would happen if "if" is implemented as an
;               ordinary procedure instead of a special form (such as the
;               one shown below, and used to implement sqrt-iter above.
;
; (define (new-if predicate then-clause else-clause)
;   (cond (predicate then-clause)
;         (else else-clause)))
; 
; Alyssa's implementation of sqrt-iter using new-if:
;
; (define (sqrt-iter guess x)
;   (new-if (good-enough? guess x)
;           guess
;           (sqrt-iter (improve guess x) x)))
;
; Due to applicative order, arguments passed into procedures are evaluated
; before being actually passed, meaning that the else-clause will be
; evaluated regardless of the truth value of the predicate. This will cause
; the new sqrt-iter to run indefinitely and hang forever.
;

;
; Exercise 1.7: Explain why our current impelmentation of good-enough? doesn't
;               work for either large or small numbers, and design an improved
;               version of sqrt-iter that bases the criterion between results
;               from subsequent iterations.
;
; Why it doesn't work for small numbers: floating point numbers have limited
; precision and are limited by the number of bits used. The precision for
; 16-bit floats is around 1e-4, while it is around 1e-8 for 32-bit floats.
; Our criterion of converging at a difference of 0.001 will clearly fail for
; numbers smaller than 1e-8.
;
; Why it doesn't work for large numbers: floating point arithemetic always
; have rounding error, which is approximately the magnitude of epsilon. For
; very large numbers, the error introduced in every operation is a fraction
; of the operands, thus for very large numbers, say > 1e8, we will have
; approximately unity error every operation, which will always be larger than
; our criterion. Since the value of the error depends on the operand, a set
; criterion will never be suitable for the full range of operands.

(include "newtons_method2.scm")

(define (sqrt x)
  (sqrt-iter 1.0 x))
(test #t (and (>= (sqrt 9) 3) (<= (sqrt 9) 3.001)))

(define t 1e100)
(define st (sqrt t))
(test #t (< (fractional-diff st 1e50) 0.001))

(define t 1e-320)
(define st (sqrt t))
(test #t (< (fractional-diff st 1e-160) 0.001))

;
; Exercise 1.8: Implement Newton's method for cube roots
;
(include "newtons_method2.scm")

(define (cube-root x)
  (cube-root-iter 1.0 x))

(test #t (< (fractional-diff (cube-root 8) 2) 0.001))
(test #t (< (fractional-diff (cube-root 27) 3) 0.001))
