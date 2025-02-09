(define-module (my-channel papyrus)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages lisp-check)
  #:use-module ((guix licenses) #:prefix license:))

(define-public sbcl-papyrus
  (package
    (name "sbcl-papyrus")
    (version "0.1.0")  ; You may want to adjust this version
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/tani/papyrus")
            (commit "fb9ca79")))
      (file-name (git-file-name "cl-papyrus" version))
      (sha256
       (base32 "1x5wmqjpxx1m7rvbspbv78h3him37n6klblp192yl0faz5v5p8x5"))))
    (build-system asdf-build-system/sbcl)
    (inputs
     (list sbcl-named-readtables))
    (native-inputs
     (list sbcl-fiveam))
    (home-page "https://github.com/tani/papyrus")
    (synopsis "Literate programming tool for Common Lisp")
    (description "Papyrus is a literate programming tool that supports
Common Lisp with Markdown, Org mode, and POD documentation formats.")
    (license license:expat)))  ; MIT license is called 'expat' in Guix

;; For other Lisp implementations
(define-public cl-papyrus
  (sbcl-package->cl-source-package sbcl-papyrus))

(define-public ecl-papyrus
  (sbcl-package->ecl-package sbcl-papyrus))
