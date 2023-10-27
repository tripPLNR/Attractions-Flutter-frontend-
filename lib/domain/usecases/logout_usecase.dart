import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';

import '../entities/login.dart';

class LogoutUseCase{
  AuthRepository authRepository;
  LocalStorageRepository localStorageRepository;
  UserStore userStore;
  LogoutUseCase({required this.authRepository,required this.userStore,required this.localStorageRepository});

  Future<bool> execute() async {

    /// reset user globally
    await userStore.setUser(User.empty());

    /// clear locale storage
    await localStorageRepository.clearAll();

    /// logout user from server
    await authRepository.logout();

    return true;
  }
}