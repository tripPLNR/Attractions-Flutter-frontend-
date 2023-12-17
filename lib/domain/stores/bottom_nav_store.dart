import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavStore extends Cubit<int>{

  BottomNavStore():super(0);


  changeScreen(int index){
    emit(index);
  }
}