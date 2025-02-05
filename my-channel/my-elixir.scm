(define-module (my-channel my-elixir)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages elixir-xyz)
  #:use-module (guix build-system mix)
  #:use-module ((guix licenses) #:prefix license:))

(define-public elixir-elixir-sense
  (package
    (name "elixir-elixir-sense")
    (version "1.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/elixir-lsp/elixir_sense")
             (commit "aec3b4ac7bf6731ee6e9506f2783a542820d4422")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1a6rky71x3ihkw0sf93y6fan78swiqcz1nfad9parv7vba2vn2vv"))))  ; Replace with actual hash
    (build-system mix-build-system)
    (arguments (list #:tests? #f))
    (synopsis "An API for Elixir projects that provides building blocks for code completion.")
    (description "An API for Elixir projects that provides building blocks for code completion, documentation, go/jump to definition, signature info and more via AST inspection and runtime introspection.")
    (home-page "https://github.com/elixir-lsp/elixir_sense")
    (license license:expat)))

(define-public elixir-jason-v
  (package
    (name "elixir-jason-v")
    (version "1.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/elixir-lsp/jason")
             (commit "f1c10fa9c445cb9f300266122ef18671054b2330")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0jvgc5swiaz1wjjgyzjwfs4iq6hnxnnmd2m5d1153pybbkbmp1r8"))))
    (build-system mix-build-system)
    (arguments (list #:tests? #f))
    (synopsis "Jason JSON library vendored for ElixirLS")
    (description "Vendored version of Jason JSON library")
    (home-page "https://github.com/elixir-lsp/jason")
    (license license:expat)))

(define-public elixir-erl2ex-vendored
 (package
   (name "elixir-erl2ex-vendored")
   (version "1.0.0")
   (source
    (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/elixir-lsp/erl2ex")
            (commit "073ac6b9a44282e718b6050c7b27cedf9217a12a")))
      (file-name (git-file-name name version))
      (sha256
       (base32 "13jhramm5gwv7sk2ih8h9fv1abycrspnrv67idc5halgpg62lvyb"))))
   (build-system mix-build-system)
   (arguments (list #:tests? #f))
   (synopsis "Erlang to Elixir code converter")
   (description "Tool for converting Erlang code to Elixir")
   (home-page "https://github.com/elixir-lsp/erl2ex")
   (license license:expat)))

(define-public elixir-path-glob-vendored
 (package
  (name "elixir-path-glob-vendored")
  (version "1.0.0")
  (source
   (origin
    (method git-fetch)
    (uri (git-reference
          (url "https://github.com/elixir-lsp/path_glob")
          (commit "965350dc41def7be4a70a23904195c733a2ecc84")))
    (file-name (git-file-name name version))
    (sha256
     (base32 "1jqbdnhsdjcamgzqi4y3lgk1xcj9bl0wi2agbzvsrm4pr45l97y2"))))
  (build-system mix-build-system)
  (propagated-inputs
    (list elixir-nimble-parsec))
  (arguments (list #:tests? #f))
  (description "File path globbing for Elixir")
  (synopsis "File path globbing for Elixir")
  (home-page "https://github.com/elixir-lsp/path_glob")
  (license license:expat)))

(define-public elixir-ls
  (package
   (name "elixir-ls")
   (version "0.26.4")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/elixir-lsp/elixir-ls")
           (commit "v0.26.4")))
     (file-name (git-file-name "elixir-ls" version))
     (sha256
      (base32 "08f6gr3ivrcs4k0hhvdb63szjvxyvlw2l9xv9615ryaywjm6jbf1"))))
   (build-system mix-build-system)
   (propagated-inputs
    (list elixir-elixir-sense
          elixir-jason-v
          elixir-erl2ex-vendored
          elixir-path-glob-vendored
          elixir-dialyxir ))
   (arguments (list #:tests? #f))
   (synopsis "The language server for Elixir that just works.")
   (description
    "Next LS is a developer tool to provide code intelligence for your text editor by implementing the Language Server Protocol. Still in heavy development, but early adopters are encouraged!")
   (home-page "https://github.com/elixir-lsp/elixir-ls")
   (license license:expat)))
