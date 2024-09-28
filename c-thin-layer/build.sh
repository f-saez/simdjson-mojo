$CC -march=native -O3 -std=c++17 -pthread -fPIC -shared simdjson_c_api.cpp simdjson.cpp -Wl,--emit-relocs -Wl,--as-needed -Wl,-O3 -Wl,--hash-style=gnu -Wl,--sort-common -Wl,-soname,simdjson_c_api.so.3 -Wl,-export-dynamic -o simdjson_c_api.so.3 -lc
mv simdjson_c_api.so.3 ..
