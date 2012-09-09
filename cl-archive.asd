#|
  This file is a part of cl-archive project.
  Copyright (c) 2012 zqwell (zqwell.ss@gmail.com)
|#

#|
  Archive/Extract Library for Common Lisp.

  Author: zqwell (zqwell.ss@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-archive-asd
  (:use :cl :asdf))
(in-package :cl-archive-asd)

(defsystem cl-archive
  :version "0.1"
  :author "zqwell"
  :license "LLGPL"
  :depends-on (:cffi
               :alexandria
               :cl-ppcre
               :cl-fad
               :cl-annot)
  :components ((:module "src"
                :components
                ((:file "cl-archive"))))
  :description "Archive/Extract Library for Common Lisp."
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
  :in-order-to ((test-op (load-op cl-archive-test))))
