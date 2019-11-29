import 'package:baas_study/utils/storage_util.dart';

class TokenUtil {
  static const TOKEN_KEY = 'token';

  static set(String token) {
    StorageUtil.set(TOKEN_KEY, token);
  }

  static get() {
    return StorageUtil.getString(TOKEN_KEY);
  }

  static remove() {
    StorageUtil.remove(TOKEN_KEY);
  }
}
