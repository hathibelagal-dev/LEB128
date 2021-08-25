import 'dart:typed_data';

import 'package:leb128/leb128.dart';
import 'package:test/test.dart';

void main() {
  test('Leb128.encodeSigned() works on small values', () {
    var value = 23;
    expect(Leb128.encodeSigned(value), equals([23]));
  });

  test('Leb128.encodeSigned() works on large values', () {
    var value = 251234323;
    expect(Leb128.encodeSigned(value), equals([147, 144, 230, 247, 0]));
  });

  test('Leb128.encodeSigned() works on small values', () {
    var value = Uint8List.fromList([23]);
    expect(Leb128.decodeSigned(value), equals(23));
  });

  test('Leb128.decodeSigned() works on large values', () {
    var value = Uint8List.fromList([147, 144, 230, 247, 0]);
    expect(Leb128.decodeSigned(value), equals(251234323));
  });

  test('Leb128.encodeUnsigned() works on small values', () {
    var value = 23;
    expect(Leb128.encodeUnsigned(value), equals([23]));
  });

  test('Leb128.encodeUnsigned() works on large values', () {
    var value = 251234323;
    expect(Leb128.encodeUnsigned(value), equals([147, 144, 230, 119]));
  });

  test('Leb128.decodeUnsigned() works on small values', () {
    var value = Uint8List.fromList([23]);
    expect(Leb128.decodeUnsigned(value), equals(23));
  });

  test('Leb128.decodeUnsigned() works on large values', () {
    var value = Uint8List.fromList([147, 144, 230, 119]);
    expect(Leb128.decodeUnsigned(value), equals(251234323));
  });

  test('Leb128.decodeVarint7() works on small values', () {
    var value = 23;
    expect(Leb128.decodeVarint7(value), equals(23));
  });

  test('Leb128.decodeVaruint7() works on small values', () {
    var value = 23;
    expect(Leb128.decodeVaruint7(value), equals(23));
  });
}
