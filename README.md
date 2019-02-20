# LEB128 Encoder/Decoder

This package offers easy-to-use methods that let you encode and decode LEB128 data. LEB128, which is short for **Little Endian Base 128**, is a code compression algorithm that is used in a variety of file formats. The most well-known are WebAssembly's binary `.wasm` and Android's `.dex` files.

## Usage

- You can call the `Leb128.encodeSigned()` method to convert a Dart `int` value into an LEB128 list of bytes. The list is a `Uint8List` object. Use this method for both positive and negative values.

- You can call the `Leb128.encodeUnsigned()` method to convert a Dart `int` value, which is positive, into an LEB128 list of bytes.

- You can call the `Leb128.decodeSigned()` method to convert a `Uint8List` object into a Dart `int` value. Use this method for signed LEB128 integers only.

- You can call the `Leb128.decodeUnsigned()` method to convert a `Uint8List` object into a Dart `int` value. Use this method for unsigned LEB128 integers only.

This package also offers two utility methods named`Leb128.decodeVarint7()` and `Leb128.decodeVaruint7()`, which are easier to use if you need to convert a single byte of data.
