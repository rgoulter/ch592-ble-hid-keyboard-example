{ lib
, stdenv
, fetchurl
, hidapi
, libusb1
, runtimeShell
, mrs_toolchain_version ? "1.90"
, mrs_toolchain_hash ? "sha256-PO7uddJg0L2Ugv7CYLpIyRKAiE+8oXU0nG3NAdYse6g="
}:

stdenv.mkDerivation rec {
  pname = "libmcuupdate";
  version = mrs_toolchain_version;

  src = fetchurl {
    url = "http://file.mounriver.com/tools/MRS_Toolchain_Linux_x64_V${mrs_toolchain_version}.tar.xz";
    hash = mrs_toolchain_hash;
  };

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/lib
    cp -r beforeinstall/libmcuupdate.so $out/lib/
  '';

  preFixup = ''
    find $out -type f | while read f; do
      patchelf "$f" > /dev/null 2>&1 || continue
      patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f" || true
      patchelf --set-rpath ${lib.makeLibraryPath [ "$out" stdenv.cc.cc hidapi libusb1 ]} "$f" || true
    done
  '';

  meta = {
  };
}
