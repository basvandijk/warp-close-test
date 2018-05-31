{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  haskellPackagesOrig = if compiler == "default"
                        then pkgs.haskellPackages
                        else pkgs.haskell.packages.${compiler};

  haskellPackages = haskellPackagesOrig.override {
    overrides = self: super: with pkgs.haskell.lib; {

      ################################################################################

      # warp = dontCheck (super.callCabal2nix "warp" ((pkgs.fetchFromGitHub {
      #   owner = "yesodweb";
      #   repo = "wai";
      #   rev = "warp/3.0.13.1";
      #   sha256 = "0ymm3gr8l3b7kbsa9ib2sahh3wgmh2syjpzx9xnlrr5cv5h4ggm1";
      # }) + "/warp") {});

      # wai = dontCheck (super.callCabal2nix "wai" ((pkgs.fetchFromGitHub {
      #   owner = "yesodweb";
      #   repo = "wai";
      #   rev = "warp/3.0.13.1";
      #   sha256 = "0ymm3gr8l3b7kbsa9ib2sahh3wgmh2syjpzx9xnlrr5cv5h4ggm1";
      # }) + "/wai") {});

      ################################################################################

      # warp = dontCheck (super.callCabal2nix "warp" ((pkgs.fetchFromGitHub {
      #   owner = "yesodweb";
      #   repo = "wai";
      #   rev = "warp/3.1.0";
      #   sha256 = "1xsn08xqcfqqfbr1innj210hrxcp6pllyn1xs2h8gf7w2qsxhc4h";
      # }) + "/warp") {});

      # wai = doJailbreak (dontCheck (super.callCabal2nix "wai" ((pkgs.fetchFromGitHub {
      #   owner = "yesodweb";
      #   repo = "wai";
      #   rev = "warp/3.1.0";
      #   sha256 = "1xsn08xqcfqqfbr1innj210hrxcp6pllyn1xs2h8gf7w2qsxhc4h";
      # }) + "/wai") {}));

      # http2 = dontCheck (super.callCabal2nix "http2" ((pkgs.fetchFromGitHub {
      #   owner = "kazu-yamamoto";
      #   repo = "http2";
      #   rev = "v1.1.0";
      #   sha256 = "0amwrzyv2iv6az93viqa8dn5qlracmy1g2ydvycks93pw8mc4s9b";
      # })) {});

      # bytestring-builder = dontCheck (super.callCabal2nix "bytestring-builder" ((pkgs.fetchFromGitHub {
      #   owner = "lpsmith";
      #   repo = "bytestring-builder";
      #   rev = "v0.10.6.0.0";
      #   sha256 = "1dpaw6pyvcw16kqb62cdwbgxra3zi6436qg6d5x3n5cid1jx4fgg";
      # })) {});

      ################################################################################

      # warp = dontCheck (super.callCabal2nix "warp" ((pkgs.fetchFromGitHub {
      #   owner = "yesodweb";
      #   repo = "wai";
      #   rev = "warp/3.2.0";
      #   sha256 = "0ckw40i7193c420107ji20305qc9z9nrchgsy5a3i9a3pxq8cksl";
      # }) + "/warp") {});

      # http2 = dontCheck (super.callCabal2nix "http2" ((pkgs.fetchFromGitHub {
      #   owner = "kazu-yamamoto";
      #   repo = "http2";
      #   rev = "v1.4.5";
      #   sha256 = "0dlmwqjp2a1jinwl9b3x963ydkkn54j045ldqh62qycjaz0s6zrh";
      # })) {});

      ################################################################################

      warp = dontCheck (super.callCabal2nix "warp" ((pkgs.fetchFromGitHub {
        owner = "yesodweb";
        repo = "wai";
        rev = "warp-3.2.22";
        sha256 = "0l2rz1s75a7r8imkgcyx2jp2j2rc6708yq4xal6mcbja5034fxvy";
      }) + "/warp") {});

      bsb-http-chunked = super.callCabal2nix "bsb-http-chunked" (pkgs.fetchFromGitHub {
        owner = "sjakobi";
        repo = "bsb-http-chunked";
        rev = "v0.0.0.2";
        sha256 = "189bi5dg59dl5661dlrw9my4xb939xm9bmyh5jj2qc8gd9j6nhbd";
      }) {};

      ################################################################################

      warp-close-test = super.callCabal2nix "warp-close-test" ./. {};
    };
  };

  drv = haskellPackages.warp-close-test;

in

  if pkgs.lib.inNixShell then drv.env else drv
