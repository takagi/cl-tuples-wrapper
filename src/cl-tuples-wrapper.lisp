#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-tuples-wrapper)

(defmacro def-tuple-values (type-name)
  (tuple-expansion-fn type-name :def-tuple-values))

(defmacro def-new-tuple (type-name)
  (tuple-expansion-fn type-name :def-new-tuple))

(defmacro def-tuple-accessor (type-name)
  (tuple-expansion-fn type-name :def-tuple-accessor))

(defmacro def-tuple-accessor* (type-name)
  (tuple-expansion-fn type-name :def-tuple-accessor*))

(defmacro def-tuple-setter (type-name)
  (tuple-expansion-fn type-name :def-tuple-setter))

(defmacro def-tuple-maker (type-name)
  (tuple-expansion-fn type-name :def-tuple-maker))

(defmacro def-tuple-maker* (type-name)
  (tuple-expansion-fn type-name :def-tuple-maker*))

(defmacro def-tuple-getter (type-name)
  (tuple-expansion-fn type-name :def-tuple-getter))

(defmacro def-tuple-setf* (type-name)
  (tuple-expansion-fn type-name :def-tuple-setf*))

(defmacro make-tuple-operations (type-name)
  `(progn
     (def-tuple-values ,type-name)
     (def-new-tuple ,type-name)
     (def-tuple-accessor ,type-name)
     (def-tuple-accessor* ,type-name)
     (def-tuple-setter ,type-name)
     (def-tuple-maker ,type-name)
     (def-tuple-maker* ,type-name)
     (def-tuple-getter ,type-name)
     (def-tuple-setf* ,type-name)))

(defmacro def-tuple-type (tuple-type-name &key tuple-element-type initial-element elements)
  `(eval-when (:compile-toplevel :execute :load-toplevel)
     (cl-tuples::make-tuple-symbol ',tuple-type-name ',tuple-element-type
                                   ',initial-element ',elements)
     (make-tuple-operations ,tuple-type-name)
     (def-tuple-documentation ,tuple-type-name)))
