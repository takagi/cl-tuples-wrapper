#|
  This file is a part of cl-tuples-wrapper project.
  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-tuples-wrapper-test)

(plan nil)

(def-tuple-type vec3
    :tuple-element-type double-float
    :initial-element 0d0
    :elements (x y z)
    :simple-array t)

(def-tuple-type vec4
    :tuple-element-type double-float
    :initial-element 0d0
    :elements (x y z w)
    :simple-array t)


;; test tuple

(is (vec3-x (new-vec3)) 0d0 "new-vec3 and vec3-x")
(is (vec3-y (new-vec3)) 0d0 "vec3-y")
(is (vec3-z (new-vec3)) 0d0 "vec3-z")

(is (vec3-x (make-vec3 1d0 2d0 3d0)) 1d0 "make-vec3")

(is (vec3-x* (vec3-values* 1d0 2d0 3d0)) 1d0 "vec3-values* and vec3-x*")
(is (vec3-y* (vec3-values* 1d0 2d0 3d0)) 2d0 "vec3-y*")
(is (vec3-z* (vec3-values* 1d0 2d0 3d0)) 3d0 "vec3-z*")

(is (vec3-x (make-vec3* (vec3-values* 1d0 2d0 3d0)))
    1d0 "make-vec3*")

(is (vec3-x* (vec3* (make-vec3 1d0 2d0 3d9))) 1d0 "vec3*")

(is (let ((x (new-vec3)))
      (setf (vec3* x) (vec3-values* 1d0 2d0 3d0))
      (vec3-x x))
    1d0 "vec3-setf*")

(is (with-vec3* (vec3-values* 1d0 2d0 3d0) (x y z) x) 1d0 "with-vec3*")

(is (with-vec3 (make-vec3 1d0 2d0 3d0) (x y z) x) 1d0 "with-vec3")


;; test tuple-array

(is (vec3-x* (vec3-aref* (make-vec3-array 1) 0))
    0d0 "make-vec3-array and vec3-aref*")

(is (vec3-x (vec3-aref (make-vec3-array 1) 0)) 0d0 "vec3-aref")

(is (let ((xs (make-vec3-array 1)))
      (setf (vec3-aref* xs 0) (vec3-values* 1d0 2d0 3d0))
      (vec3-x (vec3-aref xs 0)))
    1d0 "vec3-array-setf*")

(is (let ((xs (make-vec3-array 1)))
      (setf (vec3-aref xs 0) (make-vec3 1d0 2d0 3d0))
      (vec3-x (vec3-aref xs 0)))
    1d0 "vec3-array-setf")

(is (vec3-array-dimensions (make-vec3-array 10)) 10 "vec3-array-dimensions")

(is (let ((xs (make-vec3-array 1)))
      (setf (vec3-aref xs 0) (make-vec3 1d0 2d0 3d0))
      (with-vec3-aref (xs 0 (x y z)) x))
    1d0 "with-tuple-aref")


(finalize)
