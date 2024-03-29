import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/app_currency.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/usecases/save_new_currency_usecase.dart';
import 'currencies_initial_params.dart';
import 'currencies_state.dart';
import 'currencies_navigator.dart';

class CurrenciesCubit extends Cubit<CurrenciesState> {
  CurrenciesNavigator navigator;
  CurrenciesInitialParams initialParams;
  SaveNewCurrencyUseCase saveNewCurrencyUseCase;
  LocalStorageRepository localStorageRepository;

  CurrenciesCubit({
    required this.navigator,
    required this.initialParams,
    required this.saveNewCurrencyUseCase,
    required this.localStorageRepository,

  }) : super(CurrenciesState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;


  List<AppCurrency> currenciesList = [
    AppCurrency(name: "US Dollar - \$", value: "USD"),
    AppCurrency(name: "British Pound - £", value: "GBP"),
    AppCurrency(name: "Euro - €", value: "EUR"),
    AppCurrency(name: "Australian Dollar - AUD", value: "AUD"),
    AppCurrency(name: "Canadian Dollar - CAD", value: "CAD"),
    AppCurrency(name: "New Zealand Dollar - NZD", value: "NZD"),
    AppCurrency(name: "Singapore Dollar - SGD", value: "SGD"),
  ];

  onInit(){
    getSelectedCurrencyFromLocalDb();
  }

  changeCurrency(AppCurrency currency) {
    emit(state.copyWith(selectedCurrency: currency));
    saveNewCurrencyUseCase.execute(selectedCurrency: currency);
    Navigator.pop(context);
  }

  getSelectedCurrencyFromLocalDb(){
    localStorageRepository.getCurrency().then((value){
      emit(state.copyWith(selectedCurrency: value));
    });
  }

  bool isSelected(AppCurrency currency) {
    return state.selectedCurrency == currency;
  }
}
