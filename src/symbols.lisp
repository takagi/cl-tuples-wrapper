#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-tuples-wrapper)

(defun make-tuple-symbol (type-name tuple-element-type tuple-initial-element elements simple-array)
  (assert (listp elements))
  (let*
      ((type-string (string-upcase (string  type-name)))
	   (type-name-sym (intern  type-string :tuple-types))
	   (value-name-sym (intern (concatenate 'string type-string "*") :tuple-types)))
    (progn
      (cl-tuples::make-tuple-symbol type-name tuple-element-type tuple-initial-element elements)
      (setf (get type-name-sym :simple-array) simple-array)
      (setf (get value-name-sym :simple-array) simple-array))))

(defun tuple-simple-array (type-name)
  "Return wheather to use simple-array or not"
  (assert (or (symbolp type-name) (stringp type-name)))
  (get (find-symbol (string-upcase (string type-name)) :tuple-types) :simple-array))
