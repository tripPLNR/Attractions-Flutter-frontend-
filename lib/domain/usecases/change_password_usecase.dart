import 'package:flutter/cupertino.dart';
import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/domain/usecases/login_usecase.dart';

import '../entities/login.dart';

class ChangePasswordUseCase {
  AuthRepository authRepository;
  DatabaseRepository databaseRepository;
  LoginUseCase loginUseCase;
  UserStore userStore;
  ChangePasswordUseCase({
    required this.authRepository,
    required this.userStore,
    required this.databaseRepository,
    required this.loginUseCase,

  });

  Future<bool> execute({required String currentPassword,required String newPassword}) async {

    debugPrint("CURRENT PASSWORD : $currentPassword");
    debugPrint("NEW PASSWORD : $newPassword");

    await databaseRepository.changePassword(currentPassword: currentPassword, newPassword: newPassword);
    await loginUseCase.execute(email: userStore.state.email!, password: newPassword);

    return true;
  }
}
