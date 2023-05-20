import 'dart:typed_data';
import 'package:logger/logger.dart';
import 'package:leb128/leb128.dart';

void main() {
  int input = -9019283812387;
  Logger logger = Logger();

  // Encode the negative number shown above
  Uint8List output = Leb128.encodeSigned(input);

  // Print the individual bytes of the encoded
  // number in hex
  for (int i = 0; i < output.length; i++) {
    logger.i(output[i].toRadixString(16));
  }

  // Decode the LEB128 number into an ordinary integer and
  // print it
  logger.i(Leb128.decodeSigned(output));

  // Quickly decode a varuint7
  logger.i(Leb128.decodeVaruint7(0x08).toRadixString(16));
}
