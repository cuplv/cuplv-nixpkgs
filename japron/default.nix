{ stdenv, fetchsvn, gmp, mpfr, ppl, jdk, perl }:

stdenv.mkDerivation rec {
  name = "japron-${version}";
  version = "1097";
  src = fetchsvn {
    url = "svn://scm.gforge.inria.fr/svnroot/apron/apron/trunk";
    rev = version;
    sha256 = "134phk4wzrawrhixcphdlhd62h87h2hpq2yid91da35m7wqks27l";
  };
  buildInputs = [ gmp mpfr ppl jdk perl ];

  # Maybe we don't need "-absolute-dylibs"?
  configurePhase = ''
    ./configure -prefix $out -no-cxx -absolute-dylibs
  '';

  postInstall = ''
    mkdir -p $out/share/java
    cp $out/lib/*.jar $out/share/java   # */

    # This library path has to be set so that the jars can find the
    # .so files at runtime.  Setting it seems to obliterate the
    # pre-existing LD_LIBRARY_PATH even though we try to
    # append... TODO figure out how to avoid that
    mkdir -p $out/nix-support
    cat <<EOF > $out/nix-support/setup-hook
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$out/lib
    EOF
  '';
}
