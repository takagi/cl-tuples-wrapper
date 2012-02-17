#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-tuples-wrapper)

(defmacro def-tuple-documentation (type-name)
  `(progn
     (setf (documentation ',(tuple-symbol type-name :def-tuple-values)
                          'function)
           (format nil "Convert ~A forms to multiple values."
                   ,(string type-name)))
     (setf (documentation ',(tuple-symbol type-name :def-new-tuple)
                          'function)
           (format nil "Create an array suitable for holding a single ~A"
                   ,(string type-name)))
     ,@(loop
            for e in (cl-tuples::tuple-elements type-name)
            collect `(setf (documentation ',(accessor-name type-name e)
                                          'function)
                           (format nil "Return the element ~A of ~A"
                                   ,(string e) ,(string type-name))))
     ,@(loop
            for e in (cl-tuples::tuple-elements type-name)
            collect `(setf (documentation ',(accessor-name type-name e
                                                           :asterisk t)
                                          'function)
                           (format nil "Return the element ~A of ~A as multiple values" ,(string e) ,(string type-name))))
     (setf (documentation ',(tuple-symbol type-name :def-tuple-maker) 'function)
           (format nil "Create an array sutable for holding a single ~A and initialize it from a multiple-values form" ,(string type-name)))
     (setf (documentation ',(tuple-symbol type-name :def-tuple-maker*)
                          'function)
           (format nil "Create an array sutable for holding a single ~A and initialize it from a  form" ,(string type-name)))
     (setf (documentation ',(tuple-symbol type-name :def-tuple-getter) 'function)
           (format nil "Unpack array representation of an ~A and convert to multiple values." ,(string type-name)))
     
     ))
