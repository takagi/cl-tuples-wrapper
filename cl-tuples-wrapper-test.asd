#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tuples-wrapper-test-asd
  (:use :cl :asdf))
(in-package :cl-tuples-wrapper-test-asd)

(defsystem cl-tuples-wrapper-test
  :author "Masayuki Takagi"
  :license "LLGPL"
  :depends-on (:cl-tuples-wrapper
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "package")
                 (:file "cl-tuples-wrapper"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
