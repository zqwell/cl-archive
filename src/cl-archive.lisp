#|
  This file is a part of cl-archive project.
  Copyright (c) 2012 zqwell (zqwell.ss@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-archive
  (:use :cl :cl-annot.doc))
(in-package :cl-archive)

(cl-annot:enable-annot-syntax)

(cffi:define-foreign-library 7-zip32
  (:windows "7-zip32.dll"))
(cffi:use-foreign-library 7-zip32)

(cffi:defcfun ("SevenZip" seven-zip) :int
  (hwnd :unsigned-int)
  (cmd-line (:string :encoding :cp932))
  (output :pointer)
  (size :unsigned-int))

(cffi:defcfun ("SevenZipGetRunning" seven-zip-get-running) :boolean)

(defparameter *archive-parameter* "a -mx=5 -t7z \"~A\" ~{\"~A\" ~^ ~} -ms=off")
(defparameter *extract-parameter* "x \"~A\" -o\"~A\"")

(defun string-crlf->lf (string)
  (cl-ppcre:regex-replace-all (coerce (list #\return #\newline) 'string) string
                              (coerce (list #\newline) 'string)))

(defun %execute-7zip (parameter &rest args)
  (cffi:with-foreign-pointer (str 1024 str-size)
    (let ((result (seven-zip 0 (apply #'format nil parameter args)
                             str str-size)))
      (values result
              (string-crlf->lf
               (cffi:foreign-string-to-lisp str :encoding :cp932))))))

@export
@doc "Archive a 7-zip"
(defun 7zip-archive (7z-name &rest target-files)
  (%execute-7zip *archive-parameter* 7z-name target-files))

@export
@doc "Extract a 7-zip"
(defun 7zip-extract (7z-name output-dir)
  (%execute-7zip *extract-parameter* 7z-name output-dir))
