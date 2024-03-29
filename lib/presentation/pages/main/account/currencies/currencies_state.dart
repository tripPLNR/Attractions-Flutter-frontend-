import 'package:equatable/equatable.dart';
import 'package:triplaner/domain/entities/app_currency.dart';

import 'currencies_initial_params.dart';

class CurrenciesState extends Equatable{
  final bool loading;
  final AppCurrency selectedCurrency;

  const CurrenciesState(
      {required this.loading, required this.selectedCurrency});

  factory CurrenciesState.initial(
          {required CurrenciesInitialParams initialParams}) =>
      CurrenciesState(
          loading: false, selectedCurrency: AppCurrency.defaultCurrency());

  CurrenciesState copyWith({bool? loading, AppCurrency? selectedCurrency}) =>
      CurrenciesState(
        loading: loading ?? this.loading,
        selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [loading,selectedCurrency];

}
