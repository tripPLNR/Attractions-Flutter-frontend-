import 'package:get_it/get_it.dart';
import 'package:triplaner/data/repositories/hive_repository.dart';
import 'package:triplaner/data/repositories/rest_api_auth_repository.dart';
import 'package:triplaner/data/repositories/rest_api_repository.dart';
import 'package:triplaner/domain/entities/login.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/usecases/check_user_login_usecase.dart';
import 'package:triplaner/domain/usecases/create_account_usecase.dart';
import 'package:triplaner/domain/usecases/login_usecase.dart';
import 'package:triplaner/domain/usecases/logout_usecase.dart';
import 'package:triplaner/network/network_repository.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_navigator.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_cubit.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_initial_params.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/account_cubit.dart';
import 'package:triplaner/presentation/pages/main/account/account_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/account_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_cubit.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_initial_params.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_navigator.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_initial_params.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_navigator.dart';
import 'package:triplaner/presentation/pages/main/destination_detail/destination_detail_cubit.dart';
import 'package:triplaner/presentation/pages/main/destination_detail/destination_detail_initial_params.dart';
import 'package:triplaner/presentation/pages/main/destination_detail/destination_detail_navigator.dart';
import 'package:triplaner/presentation/pages/main/home/home_cubit.dart';
import 'package:triplaner/presentation/pages/main/home/home_initial_params.dart';
import 'package:triplaner/presentation/pages/main/home/home_navigator.dart';
import 'package:triplaner/presentation/pages/main/search/search_cubit.dart';
import 'package:triplaner/presentation/pages/main/search/search_initial_params.dart';
import 'package:triplaner/presentation/pages/main/search/search_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_cubit.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_cubit.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_initial_params.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_navigator.dart';
import 'package:triplaner/presentation/pages/splash/splash_cubit.dart';
import 'package:triplaner/presentation/pages/splash/splash_initial_params.dart';
import 'package:triplaner/presentation/pages/splash/splash_navigator.dart';
import 'package:triplaner/util/services/location/location_service.dart';

import '../../navigation/app_navigator.dart';
import '../alert/app_snackbar.dart';

final getIt = GetIt.instance;

class AppDependency {
  static initialize() {
    /// register app navigator
    getIt.registerSingleton<AppNavigator>(AppNavigator());
    getIt.registerSingleton<AppSnackBar>(AppSnackBar());

    /// local db
    getIt.registerSingleton<LocalStorageRepository>(HiveRepository());

    /// stores
    getIt.registerSingleton<UserStore>(UserStore());

    /// services
    getIt.registerSingleton<LocationService>(LocationService());

    /// register repos layer repository
    getIt.registerSingleton<NetworkRepository>(NetworkRepository());
    getIt.registerSingleton<AuthRepository>(
        RestAPIAuthRepository(networkRepository: getIt()));
    getIt.registerSingleton<DatabaseRepository>(
        RestAPIRepository(networkRepository: getIt()));

    /// useCases
    getIt.registerSingleton<CheckUserLoginUseCase>(CheckUserLoginUseCase(
      authRepository: getIt(),
      userStore: getIt(),
      localStorageRepository: getIt(),
    ));
    getIt.registerSingleton<LoginUseCase>(LoginUseCase(
      authRepository: getIt(),
      userStore: getIt(),
      localStorageRepository: getIt(),
    ));
    getIt.registerSingleton<CreateAccountUseCase>(CreateAccountUseCase(
      authRepository: getIt(),
      userStore: getIt(),
      localStorageRepository: getIt(),
    ));

    getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(
      authRepository: getIt(),
      userStore: getIt(),
      localStorageRepository: getIt(),
    ));

    /// register cubits
    ///
    getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
    getIt.registerFactoryParam<SplashCubit, SplashInitialParams, dynamic>(
        (param1, param2) => SplashCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              checkUserLoginUseCase: getIt(),
            ));
    getIt.registerSingleton<HomeNavigator>(HomeNavigator(getIt()));
    getIt.registerFactoryParam<HomeCubit, HomeInitialParams, dynamic>(
        (param1, param2) => HomeCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
              locationService: getIt(),
            ));

    getIt.registerSingleton<DestinationDetailNavigator>(
        DestinationDetailNavigator(getIt()));
    getIt.registerFactoryParam<DestinationDetailCubit,
            DestinationDetailInitialParams, dynamic>(
        (param1, param2) => DestinationDetailCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
            ));

    getIt.registerSingleton<ActivitiesNavigator>(ActivitiesNavigator(getIt()));
    getIt.registerFactoryParam<
            ActivitiesCubit, ActivitiesInitialParams, dynamic>(
        (param1, param2) => ActivitiesCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
            ));

    getIt.registerSingleton<SiteDetailNavigator>(SiteDetailNavigator(getIt()));
    getIt.registerFactoryParam<
            SiteDetailCubit, SiteDetailInitialParams, dynamic>(
        (param1, param2) => SiteDetailCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
            ));
    getIt.registerSingleton<BottomNavigationNavigator>(
        BottomNavigationNavigator(getIt()));
    getIt.registerFactoryParam<BottomNavigationCubit,
            BottomNavigationInitialParams, dynamic>(
        (param1, param2) => BottomNavigationCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
            ));
    getIt.registerSingleton<SearchNavigator>(SearchNavigator(getIt()));
    getIt.registerFactoryParam<SearchCubit, SearchInitialParams, dynamic>(
        (param1, param2) => SearchCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
            ));

    getIt.registerSingleton<WishlistNavigator>(WishlistNavigator(getIt()));
    getIt.registerFactoryParam<WishlistCubit, WishlistInitialParams, dynamic>(
        (param1, param2) => WishlistCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
            ));
    getIt.registerSingleton<AccountNavigator>(AccountNavigator(getIt()));
    getIt.registerFactoryParam<AccountCubit, AccountInitialParams, dynamic>(
        (param1, param2) => AccountCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              userStore: getIt(),
              logoutUseCase: getIt(),
            ));

    getIt.registerSingleton<LoginNavigator>(LoginNavigator(getIt()));
    getIt.registerFactoryParam<LoginCubit, LoginInitialParams, dynamic>(
        (param1, param2) => LoginCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              loginUseCase: getIt(),
            ));

    getIt.registerSingleton<SignupNavigator>(SignupNavigator(getIt()));
    getIt.registerFactoryParam<SignupCubit, SignupInitialParams, dynamic>(
        (param1, param2) => SignupCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              createAccountUseCase: getIt(),
            ));

    getIt.registerSingleton<ForgetPasswordNavigator>(
        ForgetPasswordNavigator(getIt()));
    getIt.registerFactoryParam<ForgetPasswordCubit,
            ForgetPasswordInitialParams, dynamic>(
        (param1, param2) => ForgetPasswordCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              authRepository: getIt(),
            ));

    getIt.registerSingleton<ConfirmationNavigator>(
        ConfirmationNavigator(getIt()));
    getIt.registerFactoryParam<ConfirmationCubit,
        ConfirmationInitialParams, dynamic>(
            (param1, param2) => ConfirmationCubit(
          navigator: getIt(),
          initialParams: param1,
        ));
  }
}
