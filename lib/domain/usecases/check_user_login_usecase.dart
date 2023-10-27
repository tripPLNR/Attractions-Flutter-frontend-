import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';

import '../entities/login.dart';

class CheckUserLoginUseCase{
  AuthRepository authRepository;
  LocalStorageRepository localStorageRepository;
  UserStore userStore;
  CheckUserLoginUseCase({required this.authRepository,required this.userStore,required this.localStorageRepository});

  Future<void> execute() async {
    User? user=await localStorageRepository.getUser();
    if(user!=null){
      userStore.setUser(user);
    }
  }
}