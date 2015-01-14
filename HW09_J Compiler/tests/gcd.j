;; Test of GCD program

(defun gcd (a b)
   (if (== b 0) a (gcd b (% a b))))

(defun main ()
   (let a 1071)
   (let b 462)
   (printnum a) (endl)
   (printnum b) (endl)
   (printnum (gcd a b)) (endl)
)