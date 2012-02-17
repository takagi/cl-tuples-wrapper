#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

#|
  Author: Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tuples-wrapper-asd
  (:use :cl :asdf))
(in-package :cl-tuples-wrapper-asd)

(defsystem cl-tuples-wrapper
  :version "0.1-SNAPSHOT"
  :author "Masayuki Takagi"
  :license "LLGPL"
  :depends-on (:cl-tuples
               :alexandria)
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "tuple-expander")
                 (:file "documentation")
                 (:file "cl-tuples-wrapper"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (load-op cl-tuples-wrapper-test))))
