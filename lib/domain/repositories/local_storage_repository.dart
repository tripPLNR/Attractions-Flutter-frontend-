import 'package:triplaner/domain/entities/user.dart';

abstract class LocalStorageRepository {
  Future<bool> saveAccessToken(String token);
  Future<String> getAccessToken();
  Future<User?> getUser();
  Future<bool> saveUser(User user);

  /// logout
  Future<bool> clearAll();
}
