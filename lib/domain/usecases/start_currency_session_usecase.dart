import 'package:flutter/cupertino.dart';
import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/currency_store.dart';
import 'package:triplaner/util/services/device_info/device_info_service.dart';

import '../entities/login.dart';

class StartCurrencySessionUseCase{
  LocalStorageRepository localStorageRepository;
  DatabaseRepository databaseRepository;
  StartCurrencySessionUseCase({required this.localStorageRepository,required this.databaseRepository});

  Future<void> execute() async {
    /// get currency locally saved to start the session
    AppCurrency currency=await localStorageRepository.getCurrency();
    debugPrint("LOCALLY SAVED CURRENCY : ${currency.toJson()}");
    /// initialize currency session
    await databaseRepository.changeCurrency(currency: currency);
  }
}