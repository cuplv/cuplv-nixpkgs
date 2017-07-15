{ stdenv, fetchsvn, gmp, mpfr, ppl, jdk, perl, fixDylibs ? true }:

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

  # Maybe we don't need "-absolute-dylibs"?  Needs testing on Darwin.
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

  # Change installed libraries from *.so to *.dylib so that JNI can
  # find them on Darwin.  (Needs testing...)
  dylibs =
    if (stdenv.isDarwin && fixDylibs)
    then ''
      sh ${./fix-dylibs.sh}
    ''
    else "";

  postInstall = libpath + dylibs;

}
