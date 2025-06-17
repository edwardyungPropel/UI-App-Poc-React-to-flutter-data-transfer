import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Function to decrypt AES-encrypted text (ECB Mode, No IV)
  String decryptAES(String encryptedText) {
    try {
      final keyString = '0123pr6789abcdef0123456789abcdef'; // 32-byte key
      final key = encrypt.Key.fromUtf8(keyString);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.ecb, padding: null), // Use ECB mode
      );

      final decrypted = encrypter.decrypt64(encryptedText);

      return decrypted;
    } catch (e) {
      return "Decryption Error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract encrypted data from the URL
    final uri = Uri.base;
    final encryptedText = uri.queryParameters["name"] ?? "";
    final age = uri.queryParameters["age"] ?? "No Age";

    final decryptedData =
    encryptedText.isNotEmpty ? decryptAES(encryptedText) : "No Data";

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Web - AES Decryption")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🔒 Encrypted Data (Base64): $encryptedText",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text("🔓 Decrypted Data: $decryptedData",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("📅 Age: $age", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
