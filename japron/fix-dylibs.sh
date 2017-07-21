# On Darwin, the JNI loader seems to need very particular libraries to
# be named ".dylib", while the libraries themselves depend on staying
# named ".so".
#
# Testing has indicated that these exact files with these exact names
# have to exist so that everyone can load what they expect to find.

mv $out/lib/libjapron.so $out/lib/libjapron.dylib
cp $out/lib/libjgmp.so $out/lib/libjgmp.dylib
