;; A J program testing implementation of nested ifs and multiple comparisons
(defun test_ifs (n)
   (if (< n 10)
       (if (< n 5) 1 2)
       (if (< n 20) 3 4)))

(defun main ()
  (let a 3)
  (let b 7)
  (let c 13)
  (let d 105)

  (printnum (test_ifs a)) (endl)
  (printnum (test_ifs b)) (endl)
  (printnum (test_ifs c)) (endl)
  (printnum (test_ifs d)) (endl)
)