;; boring factorial function in j

(defun fact (n)
   (if (> n 1) (* n (fact (- n 1))) 1))

(defun main ()
   (printnum (fact 7))
   (endl))
