import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _userName;

  String? get userName => _userName;

  Future<void> loadUserName() async {
    _userName = await _storage.read(key: 'name');
    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    await _storage.write(key: 'name', value: name);
    _userName = name;
    notifyListeners();
  }
}
