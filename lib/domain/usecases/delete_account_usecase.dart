import 'package:triplaner/domain/entities/user.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';

import '../entities/login.dart';

class DeleteAccountUseCase {
  AuthRepository authRepository;
  DatabaseRepository databaseRepository;

  LocalStorageRepository localStorageRepository;
  UserStore userStore;
  WishListStore wishListStore;

  DeleteAccountUseCase({
    required this.authRepository,
    required this.userStore,
    required this.localStorageRepository,
    required this.wishListStore,
    required this.databaseRepository,
  });

  Future<bool> execute() async {

    /// delete record from database
    await databaseRepository.deleteAccount();

    /// reset user globally
    await userStore.setUser(User.empty());
    await wishListStore.setWishList([]);

    /// clear locale storage
    await localStorageRepository.clearAll();

    /// logout user from server
    await authRepository.logout();


    return true;
  }
}
