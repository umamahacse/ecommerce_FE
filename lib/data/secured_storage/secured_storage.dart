import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _keyFirstName = 'userFirstName';
  final String _keyLastName = 'userLastName';
  final String _keyAccessToken = 'userAccessToken';
  final String _keyEmail = 'userEmail';


  /// User First Name
  Future setUserFirstName(String userFirstname) async {
    await storage.write(key: _keyFirstName, value: userFirstname);
  }

  Future<String?> getUserFirstName() async {
    return await storage.read(key: _keyFirstName);
  }


  /// User Last Name
  Future setUserLastName(String userLastname) async {
    await storage.write(key: _keyLastName, value: userLastname);
  }

  Future<String?> getUserLastName() async {
    return await storage.read(key: _keyLastName);
  }

  /// AccessToken
  Future setAccessToken(String accessToken) async {
    await storage.write(key: _keyAccessToken, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: _keyAccessToken);
  }

  /// Email
  Future setUserEmail(String userEmail) async {
    await storage.write(key: _keyEmail, value: userEmail);
  }

  Future<String?> getUserEmail() async {
    return await storage.read(key: _keyEmail);
  }

}