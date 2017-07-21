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

  # Place jars in /share/java instead of /lib
  patches = [ ./java-prefix.patch ];

  configurePhase = ''
    ./configure -prefix $out -no-cxx -absolute-dylibs
  '';

  # Set either LD_LIBRARY_PATH (for Linux) or DYLD_LIBRARY_PATH (for
  # Darwin).  This puts the .so libraries in JNI's search path.
  libpath = ''
    mkdir -p $out/nix-support
    cat <<EOF > $out/nix-support/setup-hook
  '' + (if stdenv.isDarwin then ''
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$out/lib
  '' else ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$out/lib
  '') + ''
    EOF
  '';

  # Change particular installed libraries from *.so to *.dylib so that
  # JNI can find them on Darwin.  (See comments in script for details)
  dylibs =
    if stdenv.isDarwin
    then ''
      sh ${./fix-dylibs.sh}
    ''
    else "";

  postInstall = libpath + dylibs;

  meta = {
    description = "Java bindings for APRON";

    longDescription = "Java bindings for APRON, a library dedicated to
    the static analysis of the numerical variables of a program by
    Abstract Interpretation";

    homepage = http://apron.cri.ensmp.fr/library/;
    license = stdenv.lib.licenses.lgpl3;
    platforms = stdenv.lib.platforms.all;
  };

}
