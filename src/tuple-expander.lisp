
(in-package :cl-tuples-wrapper)

;; tuple-symbol

(defgeneric tuple-symbol (type-name expansion))

(defmethod tuple-symbol ((type-name symbol) (expansion (eql :def-tuple-values)))
  (cl-tuples::tuple-symbol type-name :def-tuple-values))

(defmethod tuple-symbol ((type-name symbol) (expansion (eql :def-new-tuple)))
  (cl-tuples::tuple-symbol type-name :def-new-tuple))

(defmethod tuple-symbol ((type-name symbol) (expansion (eql :def-tuple-maker)))
  (cl-tuples::tuple-symbol type-name :def-tuple-maker))

(defmethod tuple-symbol ((type-name symbol) (expansion (eql :def-tuple-maker*)))
  (cl-tuples::tuple-symbol type-name :def-tuple-maker*))

(defmethod tuple-symbol ((type-name symbol) (expansion (eql :def-tuple-getter)))
  (cl-tuples::tuple-symbol type-name :def-tuple-getter))

(defmethod tuple-symbol ((type-name symbol) (expansion (eql :def-tuple-setf*)))
  (cl-tuples::tuple-symbol type-name :def-tuple-setf*))


;; tuple-expansion-fn

(defgeneric tuple-expansion-fn (type-name expansion))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-values)))
  (cl-tuples::tuple-expansion-fn type-name :def-tuple-values))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-new-tuple)))
  (cl-tuples::tuple-expansion-fn type-name :def-new-tuple))

(defun accessor-name (name e &key asterisk package)
  (intern (concatenate 'string (string name) "-" (string e) (when asterisk "*"))
          (if package package *package*)))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-accessor)))
  `(progn
     ,@(loop
          for i from 0 below (tuple-size type-name)
          for e in (cl-tuples::tuple-elements type-name)
          collect `(defmacro ,(accessor-name type-name e) (tuple)
                     (cl-tuples::construct-tuple-array-reference
                      ',type-name tuple ,i))))) 

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-accessor*)))
  `(progn
     ,@(loop
          for i from 0 below (tuple-size type-name)
          for e in (cl-tuples::tuple-elements type-name)
          collect
            `(defmacro ,(accessor-name type-name e :asterisk t) (tuple-values)
               (let ((varlist (cl-tuples::gensym-list ,(tuple-size type-name))))
                 `(multiple-value-bind ,varlist ,tuple-values
                    (declare (type ,',(cl-tuples::tuple-element-type type-name)
                                   ,@varlist))
                    (declare (ignorable ,@varlist))
                    ,(nth ,i varlist)))))))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-setter)))
  (cl-tuples::tuple-expansion-fn type-name :def-tuple-setter))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-maker)))
  (cl-tuples::tuple-expansion-fn type-name :def-tuple-maker))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-maker*)))
  (cl-tuples::tuple-expansion-fn type-name :def-tuple-maker*))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-getter)))
  (cl-tuples::tuple-expansion-fn type-name :def-tuple-getter))

(defmethod tuple-expansion-fn ((type-name symbol)
                               (expansion (eql :def-tuple-setf*)))
  (cl-tuples::tuple-expansion-fn type-name :def-tuple-setf*))
