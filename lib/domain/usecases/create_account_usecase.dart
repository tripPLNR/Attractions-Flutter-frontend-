import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';

import '../entities/login.dart';

class CreateAccountUseCase{
  AuthRepository authRepository;
  UserStore userStore;
  LocalStorageRepository localStorageRepository;
  WishListStore wishListStore;
  CreateAccountUseCase({required this.authRepository,required this.userStore,required this.localStorageRepository,required this.wishListStore});

  Future<bool> execute({required String email,required String password,required String firstName,required String lastName}) async {
    Login login=await authRepository.createAccountWithEmailAndPassword(email: email, password: password,
    firstName: firstName,lastName: lastName
    );
    userStore.setUser(login.user!);
    /// TODO: SAVE LOCALLY
    localStorageRepository.saveUser(login.user!);
    localStorageRepository.saveAccessToken(login.accessToken!);

    wishListStore.getWishList();
    return true;
  }
}