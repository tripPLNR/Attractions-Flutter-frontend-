import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';

import '../entities/login.dart';

class LoginUseCase{
  AuthRepository authRepository;
  LocalStorageRepository localStorageRepository;
  WishListStore wishListStore;
  UserStore userStore;
  LoginUseCase({required this.authRepository,required this.userStore,required this.localStorageRepository,required this.wishListStore});

  Future<bool> execute({required String email,required String password,bool isGoogle=false,bool isApple=false}) async {
    Login login;
    if(isGoogle){
      login=await authRepository.loginWithGoogle();
    }else if(isApple){
      login=await authRepository.loginWithApple();
    }else {
      login = await authRepository.loginWithEmailAndPassword(email: email, password: password);
    }
    /// set user globally
    await userStore.setUser(login.user!);

    /// TODO: SAVE LOCALLY
    await localStorageRepository.saveUser(login.user!);
    await localStorageRepository.saveAccessToken(login.token!);

    wishListStore.getWishList();
    /// TODO: TIMER FOR REFRESH TOKEN
    return true;
  }
}