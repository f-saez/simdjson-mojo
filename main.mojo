import sys.ffi
from collections import Optional

alias LIBNAME = "simdjson_c_api.so.3"
alias simdjson_version = fn() -> UInt32

@value
struct SIMDJSONVersion(Stringable, Formattable):
    var major: UInt32
    var minor: UInt32
    var revision: UInt32

    fn __init__(inout self, x : UInt32):        
        self.revision = x & 0xFF
        self.minor = (x & 0x00FF00) >> 8
        self.major = (x & 0xFF0000) >> 16

    fn __str__(self) -> String:
        return String.format_sequence(self)

    fn format_to(self, inout writer: Formatter):
        writer.write(self.major,".",self.minor,".",self.revision)

@value
struct SIMDJSON:
    var _handle : ffi.DLHandle
    var version : SIMDJSONVersion

    fn __init__(inout self, owned handle : ffi.DLHandle):
        self.version = SIMDJSONVersion( handle.get_function[simdjson_version]("simdjson_version")())
        self._handle = handle

    @staticmethod
    fn new() -> Optional[Self]:
        var result = Optional[Self](None)
        var handle = ffi.DLHandle(LIBNAME, ffi.RTLD.LAZY)
        if handle.__bool__():
            result = Optional[Self]( Self(handle) )
        else:
            print("Unable to load ",LIBNAME)
        return result  

fn main():
    var aaa = SIMDJSON.new()
    if aaa:
        json = aaa.take()
        print(json.version)
