(in-package :cl-tuples-wrapper)

(defgeneric tuple-expansion-fn (type-name expansion))

(defmethod tuple-expansion-fn ((type-name symbol) (expansion (eql :def-tuple-array-maker)))
  `(defun ,(cl-tuples::tuple-symbol type-name :def-tuple-array-maker) (dimensions &key adjustable (initial-element ,(cl-tuples::tuple-initial-element type-name))  (fill-pointer nil))
	 (the ,(cl-tuples::tuple-typespec** type-name)
	   (make-array (* ,(cl-tuples::tuple-size type-name) dimensions)
				   :adjustable adjustable
				   :initial-element initial-element
				   :fill-pointer (and fill-pointer
                                      (* ,(cl-tuples::tuple-size type-name)
                                         fill-pointer))
				   :element-type ',(cl-tuples::tuple-element-type type-name)))))

(defmethod tuple-expansion-fn ((type-name symbol) (expansion (eql :def-tuple-aref*)))
  "Create a macro that will index an array that is considered to be an array of tuples and extract an individual tuple as a value form"
  `(defmacro ,(cl-tuples::tuple-symbol type-name :def-tuple-aref*) (tuple-array array-index)
	 (let* ((varlist (cl-tuples::gensym-list ,(cl-tuples::tuple-size type-name)))
			(array-index-sym (gensym)))
	   `(let ((,array-index-sym (* ,',(cl-tuples::tuple-size type-name) ,array-index)))
		  (the ,',(cl-tuples::tuple-typespec type-name)
			(values ,@(let ((counter 0))
						   (mapcar #'(lambda (x)
									   (declare (ignore x))
									   (prog1
										   `(aref (the ,',(cl-tuples::tuple-typespec** type-name) ,tuple-array)
												  (+ ,counter ,array-index-sym))
										 (incf counter)))
								   varlist))))))))

(defun accessor-name (name e &key asterisk package)
  (intern (concatenate 'string (string name) "-" (string e) (when asterisk "*"))
          (if package package *package*)))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-accessor)))
  `(progn
     ,@(loop
          for i from 0 below (cl-tuples::tuple-size type-name)
          for e in (cl-tuples::tuple-elements type-name)
          collect `(defmacro ,(accessor-name type-name e) (tuple)
                     (cl-tuples::construct-tuple-array-reference
                      ',type-name tuple ,i))))) 

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-accessor*)))
  `(progn
     ,@(loop
          for i from 0 below (cl-tuples::tuple-size type-name)
          for e in (cl-tuples::tuple-elements type-name)
          collect
            `(def-tuple-op ,(accessor-name type-name e :asterisk t)
               ((vec ,type-name ,(cl-tuples::tuple-elements type-name)))
               (:return ,(cl-tuples::tuple-element-type type-name)
                        ,(nth i (cl-tuples::tuple-elements type-name)))))))
