import 'package:leb128/leb128.dart';

void main() {
  var input = -9019283812387;

  // Encode the negative number shown above
  var output = Leb128.encodeSigned(input);

  // Print the individual bytes of the encoded
  // number in hex
  output.forEach((x) {
    print(x.toRadixString(16));
  });

  // Decode the LEB128 number into an ordinary integer and
  // print it
  print(Leb128.decodeSigned(output));

  // Quickly decode a varuint7
  print(Leb128.decodeVaruint7(0x08).toRadixString(16));
}
