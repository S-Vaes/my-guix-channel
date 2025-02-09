(define-module (my-channel my-elixir)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (gnu packages elixir)
  #:use-module (gnu packages erlang)
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
             (commit "cad0a81791fef1661ca47fe6be271808a704b0be")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1a6rky71x3ihkw0sf93y6fan78swiqcz1nfad9parv7vba2vn2vv"))))
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

(define-public elixir-erlex-vendored
 (package
   (name "elixir-erlex-vendored")
   (version "1.0.0")
   (source
    (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/elixir-lsp/erlex")
            (commit "c0e448db27bcbb3f369861d13e3b0607ed37048d")))
      (file-name (git-file-name name version))
      (sha256
       (base32 "1k4grhm99qfjmvj72imjvmnxr94mgyrpf01dc28i66gr3692was2"))))
   (build-system mix-build-system)
   (arguments (list #:tests? #f))
   (synopsis "Converting Erlang style structs to Elixir style structs")
   (description "Tool for converting Erlang style structs to Elixir style structs")
   (home-page "https://github.com/elixir-lsp/erlex")
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
          elixir-erlex-vendored
          elixir-dialyxir))
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (add-before 'build 'setup-mix
          (lambda _
            (setenv "MIX_BUILD_ROOT" "_build")
            (setenv "MIX_DEPS_PATH" "deps")
            (setenv "MIX_ENV" "prod")))
        (replace 'build
          (lambda _
            ;; First get deps
            (invoke "mix" "deps.compile" "--no-deps-check")
            ;; Then compile everything
            (invoke "mix" "compile" "--no-deps-check")
            ;; Finally create release
            (invoke "mix" "elixir_ls.release")))
        (replace 'install
          (lambda* (#:key outputs #:allow-other-keys)
            (let* ((out (assoc-ref outputs "out"))
                   (bin (string-append out "/bin"))
                   (lib (string-append out "/lib")))
              (mkdir-p bin)
              (mkdir-p lib)
              (copy-recursively "release" lib)
              (copy-file "release/language_server.sh"
                        (string-append bin "/elixir-ls"))
              (copy-file "release/debug_adapter.sh"
                        (string-append bin "/elixir-debug-adapter"))
              (chmod (string-append bin "/elixir-ls") #o755)
              (chmod (string-append bin "/elixir-debug-adapter") #o755)
              (substitute* (string-append bin "/elixir-ls")
                (("exec \"\\$\\{dir\\}/launch.sh\"")
                 (string-append "exec " lib "/launch.sh")))
              (substitute* (string-append bin "/elixir-debug-adapter")
                (("exec \"\\$\\{dir\\}/launch.sh\"")
                 (string-append "exec " lib "/launch.sh")))
              (substitute* (string-append lib "/launch.sh")
                (("ERL_LIBS=\"\\$SCRIPTPATH:\\$ERL_LIBS\"")
                 (string-append "ERL_LIBS=" lib ":\\$ERL_LIBS"))
                (("exec elixir")
                 "exec elixir")
                (("echo \"\" \\| elixir")
                 "echo \"\" | elixir"))
              (substitute* (string-append lib "/exec.zsh")
                (("exec elixir")
                 "exec elixir"))
              #t))))))
   (synopsis "A frontend-independent IDE server for Elixir")
   (description
    "The Elixir Language Server provides a server that runs in the background,
providing IDEs, editors, and other tools with information about Elixir Mix projects.
It adheres to the Language Server Protocol, a standard for frontend-independent IDE
support. Debugger integration is accomplished through the similar VS Code Debug
Protocol.")
   (home-page "https://github.com/elixir-lsp/elixir-ls")
   (license license:expat)))

elixir-ls
