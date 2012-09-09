#|
  This file is a part of cl-archive project.
  Copyright (c) 2012 zqwell (zqwell.ss@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-archive-test-asd
  (:use :cl :asdf))
(in-package :cl-archive-test-asd)

(defsystem cl-archive-test
  :author "zqwell"
  :license ""
  :depends-on (:cl-archive
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "cl-archive"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
