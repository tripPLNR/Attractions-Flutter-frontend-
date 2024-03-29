import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/currency_store.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/util/services/device_info/device_info_service.dart';

import '../entities/login.dart';

class SaveNewCurrencyUseCase {
  LocalStorageRepository localStorageRepository;
  DatabaseRepository databaseRepository;
  CurrencyStore currencyStore;

  SaveNewCurrencyUseCase({
    required this.localStorageRepository,
    required this.databaseRepository,
    required this.currencyStore,
  });

  Future<void> execute({required AppCurrency selectedCurrency}) async {
    /// save currency locally
    await localStorageRepository.saveCurrency(selectedCurrency);
    await databaseRepository.changeCurrency(currency: selectedCurrency);
    currencyStore.updateCurrency();
    /// call the endpoint to save this user setting locally
  }
}
