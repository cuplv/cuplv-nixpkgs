{ stdenv, fetchsvn, gmp, mpfr, ppl, openjdk, perl }:

stdenv.mkDerivation rec {
  name = "japron-${version}";
  version = "1097";
  src = fetchsvn {
    url = "svn://scm.gforge.inria.fr/svnroot/apron/apron/trunk";
    rev = version;
    sha256 = "134phk4wzrawrhixcphdlhd62h87h2hpq2yid91da35m7wqks27l";
  };
  buildInputs = [ gmp mpfr ppl openjdk perl ];

  configurePhase = ''
    ./configure -prefix $out -no-cxx
  '';
}
