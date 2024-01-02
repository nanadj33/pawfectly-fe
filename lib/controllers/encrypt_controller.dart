import 'package:encrypt/encrypt.dart';

final key = Key.fromUtf8('DGiWyWPDphjlOirWKSKI6UqshKBgfx6a'); //32 chars
final iv = IV.fromUtf8('d4lFRQqkmWldZwaf'); //16 chars

String encryptMyData(String text) {
  final e = Encrypter(AES(key, mode: AESMode.cbc));
  final encryptedData = e.encrypt(text, iv: iv);
  return encryptedData.base64;
}

String decryptMyData(String text) {
  final e = Encrypter(AES(key, mode: AESMode.cbc));
  final decryptedData = e.decrypt(Encrypted.fromBase64(text), iv: iv);
  return decryptedData;
}
