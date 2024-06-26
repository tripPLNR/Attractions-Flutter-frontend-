import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/domain/entities/user.dart';

abstract class LocalStorageRepository {
  Future<bool> saveAccessToken(String token);

  Future<String> getAccessToken();

  Future<User?> getUser();

  Future<bool> saveUser(User user);
  Future<bool> saveCurrency(AppCurrency currency);
  Future<AppCurrency> getCurrency();


  Future<bool> saveRecentSearch({required String search});

  Future<List<String>> getRecentSearches();

  Future<bool> clearRecentSearch();

  /// logout
  Future<bool> clearAll();
}
