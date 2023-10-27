import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triplaner/domain/entities/user.dart';

class UserStore extends Cubit<User>{

  UserStore():super(User.empty());

  setUser(User user){
    emit(user);
  }
}