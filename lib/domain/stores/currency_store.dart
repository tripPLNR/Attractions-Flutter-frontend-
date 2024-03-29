import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/domain/entities/user.dart';

class CurrencyStore extends Cubit<bool>{

  CurrencyStore():super(false);

  /// we are making this and then we will make multiple listener on differen pages to listen this change
  /// and when change will occur, recall the apis.
  updateCurrency(){
    emit(!state);
  }
}