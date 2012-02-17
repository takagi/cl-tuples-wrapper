#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tuples-wrapper
  (:use :cl
        :cl-tuples
        :alexandria)
  (:export :def-tuple-type))
