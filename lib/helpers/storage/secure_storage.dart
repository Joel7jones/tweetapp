import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final _storage = const FlutterSecureStorage();

  set secItems(List<SecuredItem> value) => secItems = value;

  Future<String> read(String key) async {
    return await _storage.read(
            key: key,
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        "";
  }

  Future<void> get deleteAll async {
    try {
      await _storage.deleteAll(
          iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> addNewData(String key, String? value) async {
    try {
      await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
    } catch (e) {
      debugPrint('$e');
    }
  }

  IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
}

class SecuredItem {
  SecuredItem(this.key, this.value);

  final String key;
  final String value;
}
