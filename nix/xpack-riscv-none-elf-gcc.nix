{ lib
, stdenv
, fetchurl
, runtimeShell
, xpack_toolchain_version ? "13.2.0-1"
, xpack_toolchain_hash ? "sha256-1+/1xdd4hzw9SG5dLIBbglgucwgfk+2zdaHvXYR2S0M="
}:

stdenv.mkDerivation rec {
  pname = "gcc-risc-v-elf";
  version = xpack_toolchain_version;

  src = fetchurl {
    url = "https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v${version}/xpack-riscv-none-elf-gcc-${version}-linux-x64.tar.gz";
    hash = xpack_toolchain_hash;
  };

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/
    cp -r * $out
  '';

  preFixup = ''
    find $out -type f | while read f; do
      patchelf "$f" > /dev/null 2>&1 || continue
      patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f" || true
    done
  '';

  meta = {
  };
}
