import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorage {
  final storage = const FlutterSecureStorage();

  saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  deleteToken() async {
    await storage.delete(key: "token");
  }

  getToken() async {
    return await storage.read(key: "token");
  }
}
