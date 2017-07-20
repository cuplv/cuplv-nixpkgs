#for f in $out/lib/*.so; do
#    mv -- "$f" "${f%.so}.dylib"
#done

mv $out/lib/libjapron.so $out/lib/libjapron.dylib
cp $out/lib/libjgmp.so $out/lib/libjgmp.dylib
