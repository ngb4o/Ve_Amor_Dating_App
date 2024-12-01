import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();

  factory EncryptionService() {
    return _instance;
  }

  EncryptionService._internal();

  // Lazy loading for encrypter
  late final encrypt.Encrypter _encrypter;
  late final encrypt.IV _iv;

  void init() {
    final encryptionKey = dotenv.env['ENCRYPTION_KEY'];
    final encryptionIV = dotenv.env['ENCRYPTION_IV'];

    if (encryptionKey == null || encryptionIV == null) {
      throw Exception('Encryption keys not found in environment variables');
    }

    final key = encrypt.Key.fromBase64(encryptionKey);
    _iv = encrypt.IV.fromBase64(encryptionIV);
    _encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  String encryptData(String data) {
    try {
      final encrypted = _encrypter.encrypt(data, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      throw 'Encryption failed: $e';
    }
  }

  String decryptData(String encryptedData) {
    try {
      final decrypted = _encrypter.decrypt64(encryptedData, iv: _iv);
      return decrypted;
    } catch (e) {
      throw 'Decryption failed: $e';
    }
  }

  bool isEncrypted(String data) {
    try {
      _encrypter.decrypt64(data, iv: _iv);
      return true;
    } catch (_) {
      return false;
    }
  }
}