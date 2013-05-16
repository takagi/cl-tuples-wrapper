#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-tuples-wrapper)

(defmacro def-tuple-array-maker (type-name)
  (tuple-expansion-fn type-name :def-tuple-array-maker))

(defmacro def-tuple-aref* (type-name)
  (tuple-expansion-fn type-name :def-tuple-aref*))

(defmacro def-tuple-accessor (type-name)
  (tuple-expansion-fn type-name :def-tuple-accessor))

(defmacro def-tuple-accessor* (type-name)
  (tuple-expansion-fn type-name :def-tuple-accessor*))

(defmacro make-tuple-operations (type-name)
  `(progn
     (cl-tuples::def-tuple ,type-name)
     (cl-tuples::def-tuple-getter ,type-name)
     (cl-tuples::def-tuple-aref ,type-name)
     (cl-tuples::def-tuple-aref-setter*  ,type-name)
     (cl-tuples::def-tuple-aref-setter ,type-name)
     (cl-tuples::def-tuple-array-dimensions ,type-name)
     (cl-tuples::def-tuple-fill-pointer ,type-name)
     (cl-tuples::def-tuple-setf-fill-pointer ,type-name)
     (cl-tuples::def-with-tuple ,type-name)
     (cl-tuples::def-with-tuple* ,type-name)
     (cl-tuples::def-with-tuple-aref ,type-name)
     (cl-tuples::def-tuple-setter  ,type-name)
;     (cl-tuples::def-tuple-vector-push ,type-name)
;     (cl-tuples::def-tuple-vector-push-extend ,type-name)
;     (cl-tuples::def-tuple-vector-push* ,type-name)
;     (cl-tuples::def-tuple-vector-push-extend* ,type-name)
     (cl-tuples::def-new-tuple ,type-name)
     (cl-tuples::def-tuple-maker ,type-name)
     (cl-tuples::def-tuple-maker* ,type-name)
     (cl-tuples::def-tuple-setf*  ,type-name)
     (cl-tuples::def-tuple-array-setf*  ,type-name)
     (cl-tuples::def-tuple-array-setf ,type-name)
     (def-tuple-array-maker ,type-name)
     (def-tuple-aref* ,type-name)
     (def-tuple-accessor ,type-name)
     (def-tuple-accessor* ,type-name)))

(defmacro def-tuple-type (tuple-type-name &key tuple-element-type initial-element elements (simple-array nil))
  `(eval-when (:compile-toplevel :execute :load-toplevel)
     (make-tuple-symbol ',tuple-type-name ',tuple-element-type
                        ',initial-element ',elements ',simple-array)
     (make-tuple-operations ,tuple-type-name)))

(defmacro def-tuple-op (name param-list &body forms)
  `(cl-tuples:def-tuple-op ,name ,param-list ,@forms))

