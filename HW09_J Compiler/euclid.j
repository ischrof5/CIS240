;; this is a comment on euclid.j

;; using the recursive definition from wikipedia

(defun euclid (a b)
		(if (== b 0) a (euclid b (% a b)))
)