library leb128;

// Copyright 2019 Ashraff Hathibelagal. All rights reserved.
// Use of this source code is governed by the Apache license, which can be
// found in the LICENSE file.

import 'dart:typed_data';

/// This class contains static methods you can use to encode and decode
/// integers that follow LEB128 compression format.
class Leb128 {
  /// Converts a list of bytes that represent an LEB128 unsigned integer
  /// into an ordinary integer. The optional argument specifies the number of
  /// bits in the integer. For example, while dealing with a varuint7, the
  /// second argument would be 7.
  static int decodeUnsigned(Uint8List bytes, {int n = 64}) {
    int result = 0;
    int shift = 0;
    int i = 0;
    while (true) {
      int byte = bytes[i++] & 0xff;
      result |= (byte & 0x7f) << shift;
      if ((byte & 0x80) == 0) break;
      shift += 7;
    }
    return result;
  }

  /// Converts a list of bytes that represent an LEB128 signed integer
  /// into an ordinary integer.  The optional argument specifies the number of
  /// bits in the integer. For example, while dealing with a varint32, the
  /// second argument would be 32.
  static int decodeSigned(Uint8List bytes, {int n = 64}) {
    int result = 0;
    int shift = 0;
    int i = 0;
    while (true) {
      int byte = bytes[i];
      result |= ((byte & 0x7f) << shift);
      shift += 7;
      if ((byte & 0x80) == 0) {
        break;
      } else {
        i += 1;
      }
    }
    if ((shift < n) && (bytes[i] & 0x40) != 0) {
      result |= (~0 << shift);
    }
    return result;
  }

  /// Converts an ordinary integer into a list of bytes that contains an
  /// LEB128 unsigned integer. The size of the integer is decided automatically.
  static Uint8List encodeUnsigned(int value) {
    int size = (value.toRadixString(2).length / 7.0).ceil();
    List<int> parts = List.empty(growable: true);
    int i = 0;
    while (i < size) {
      int part = value & 0x7f;
      value >>= 7;
      parts.add(part);
      i += 1;
    }
    for (var i = 0; i < parts.length - 1; i++) parts[i] |= 0x80;
    return Uint8List.fromList(parts);
  }

  /// Converts an ordinary integer into a list of bytes that contains an
  /// LEB128 signed integer. The size of the integer is decided automatically.
  static Uint8List encodeSigned(int value) {
    bool more = true;
    List<int> parts = List.empty(growable: true);
    while (more) {
      int byte = value & 0x7f;
      value >>= 7;
      if (value == 0 && (byte & 0x40) == 0)
        more = false;
      else if (value == -1 && (byte & 0x40) > 0)
        more = false;
      else {
        byte |= 0x80;
      }
      parts.add(byte);
    }
    return Uint8List.fromList(parts);
  }

  /// Utility method that decodes a varint7 value. Using this is
  /// easier because you don't have to convert your byte into a
  /// [Uint8List] object first.
  static decodeVarint7(int byte) {
    Uint8List input = Uint8List.fromList([byte]);
    return decodeSigned(input);
  }

  /// Utility method that decodes a varuint7 value. Using this is
  /// easier because you don't have to convert your byte into a
  /// [Uint8List] object first.
  static decodeVaruint7(int byte) {
    Uint8List input = Uint8List.fromList([byte]);
    return decodeUnsigned(input);
  }
}
