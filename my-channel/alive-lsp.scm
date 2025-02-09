(define-module (my-channel alive-lsp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages lisp)
  #:use-module ((guix licenses) #:prefix license:))

(define-public sbcl-alive-lsp
  (package
   (name "sbcl-alive-lsp")
   (version "0.2.8")                  ; We'll need to determine a proper version
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/nobody-famous/alive-lsp")
           (commit "939bb748cc1cdced6d5af764277abd4941d77db0")))
    (file-name (git-file-name "alive-lsp" version))
    (sha256
     (base32 "0xvvyj27kx6dsa6539fjh2l1ga5b78hqf4il8ckmp4mrzf30nqkn"))))
  (build-system asdf-build-system/sbcl)
  (inputs
   (list sbcl-usocket
         sbcl-cl-json
         sbcl-bordeaux-threads
         sbcl-flexi-streams))
  (home-page "https://github.com/nobody-famous/alive-lsp")
  (synopsis "Language Server for Alive: The Average Lisp VSCode Environment")
  (description "This is the language server for Alive: The Average Lisp VSCode Environment, providing features like autocompletion, go-to-definition, and more for Alive Lisp projects in VSCode.")
  (license license:expat)))

;; For other Lisp implementations (source package)
(define-public cl-alive-lsp
(sbcl-package->cl-source-package sbcl-alive-lsp))

(define-public ecl-alive-lsp
(sbcl-package->ecl-package sbcl-alive-lsp))
