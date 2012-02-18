#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-tuples)

(defun tuple-typespec* (type-name)
  "Return typespec of tuple as bounded array"
  (if (cl-tuples-wrapper::tuple-simple-array type-name)
      `(simple-array ,(tuple-element-type type-name) (,(tuple-size type-name)))
      `(vector ,(tuple-element-type type-name) ,(tuple-size type-name))))

(defun tuple-typespec** (type-name)
  "Return typespec of tuple as unbounded array"
  (if (cl-tuples-wrapper::tuple-simple-array type-name)
      `(simple-array ,(tuple-element-type type-name) *)
      `(vector ,(tuple-element-type type-name) *)))

#|
(define-compiler-macro tuple-typespec* (&whole form type-name-var)
  `(if (tuple-simple-array ,type-name-var)
       `(simple-array ,`,(tuple-element-type ,type-name-var)
                      ,`,(tuple-size ,type-name-var))
       ,form))

(define-compiler-macro tuple-typespec** (&whole form type-name-var)
  `(if (tuple-simple-array ,type-name-var)
       `(simple-array ,`,(tuple-element-type ,type-name-var) *)
       ,form))
|#
