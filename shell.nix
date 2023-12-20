{ pkgs ? import <nixpkgs> {}
, mrs_toolchain_version ? "1.90"
, mrs_toolchain_hash ? "sha256-PO7uddJg0L2Ugv7CYLpIyRKAiE+8oXU0nG3NAdYse6g="
}:

let
  libmcuupdate = pkgs.callPackage ./nix/libmcuupdate.nix {
    inherit 
      mrs_toolchain_version
      mrs_toolchain_hash;
  };
  mrs-toolchain = pkgs.callPackage ./nix/mrs-toolchain.nix {
    inherit 
      mrs_toolchain_version
      mrs_toolchain_hash;
  };
  xpack-riscv-none-embed-gcc-8_2 = pkgs.callPackage ./nix/xpack-riscv-none-embed-gcc-8.2.nix {
    xpack_toolchain_version = "8.2.0-3.1";
    xpack_toolchain_hash = "sha256-PUD6tQ662EJP+FdI8l0uruUPhqXVIiq9ekWi5JDx5PU=";
    ext = "tgz";
  };
  xpack-riscv-none-embed-gcc-8_3 = pkgs.callPackage ./nix/xpack-riscv-none-embed-gcc.nix {
    xpack_toolchain_version = "8.3.0-2.3";
    xpack_toolchain_hash = "sha256-cI0Mtf8S61rQcBU1lMT3dxzYbUtnIad7I/j+aVyPlAI=";
  };
  xpack-riscv-none-embed-gcc-10_1 = pkgs.callPackage ./nix/xpack-riscv-none-embed-gcc.nix {
    xpack_toolchain_version = "10.1.0-1.2";
    xpack_toolchain_hash = "sha256-xg3oiAzqnfIHst+CDTfOq44CtIeD5znCyM/h8qBv4xA=";
  };
  xpack-riscv-none-embed-gcc = pkgs.callPackage ./nix/xpack-riscv-none-embed-gcc.nix {
    xpack_toolchain_version = "10.2.0-1.2";
    xpack_toolchain_hash = "sha256-1yvc0e7kHcWiCKigOXa3DQFFEN61iQyehzjoBLoj+YU=";
  };
  xpack-riscv-none-elf-gcc-11_3 = pkgs.callPackage ./nix/xpack-riscv-none-elf-gcc.nix {
    xpack_toolchain_version = "11.3.0-1";
    xpack_toolchain_hash = "sha256-HJn7FXP/LtXe/85ky5a7knLzUfBUaExJ39WtQcbdgE0=";
  };
  xpack-riscv-none-elf-gcc-12_3 = pkgs.callPackage ./nix/xpack-riscv-none-elf-gcc.nix {
    xpack_toolchain_version = "12.3.0-2";
    xpack_toolchain_hash = "sha256-mSHWPARhGVSvAWucp0zVLBzLgygA0yHWfk5lHxYUbRY=";
  };
  xpack-riscv-none-elf-gcc = pkgs.callPackage ./nix/xpack-riscv-none-elf-gcc.nix {
    xpack_toolchain_version = "13.2.0-1";
    xpack_toolchain_hash = "sha256-1+/1xdd4hzw9SG5dLIBbglgucwgfk+2zdaHvXYR2S0M=";
  };
  python = pkgs.python3.withPackages (python-packages: with python-packages; [
    cbor2
    click
    cryptography
    intelhex
    pyyaml
  ]);
  wchisp = pkgs.callPackage ./nix/wchisp.nix {};
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    hidapi
    libjaylink
    libusb1
    mbedtls
    ncurses5
    cmake
    ccache
  ] ++ [
    libmcuupdate
    mrs-toolchain
    xpack-riscv-none-elf-gcc
    python
    wchisp
  ];
}
