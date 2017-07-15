for f in $out/lib/*.so; do
    mv -- "$f" "${f%.so}.dylib"
done
