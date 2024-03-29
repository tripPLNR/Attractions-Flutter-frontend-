import 'package:get_it/get_it.dart';
import 'package:triplaner/data/repositories/hive_repository.dart';
import 'package:triplaner/data/repositories/rest_api_auth_repository.dart';
import 'package:triplaner/data/repositories/rest_api_repository.dart';
import 'package:triplaner/domain/entities/login.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/domain/repositories/local_storage_repository.dart';
import 'package:triplaner/domain/stores/bottom_nav_store.dart';
import 'package:triplaner/domain/stores/currency_store.dart';
import 'package:triplaner/domain/stores/filter/filter_store_store.dart';
import 'package:triplaner/domain/stores/user_store.dart';
import 'package:triplaner/domain/stores/wishlist/wishlist_store.dart';
import 'package:triplaner/domain/usecases/change_password_usecase.dart';
import 'package:triplaner/domain/usecases/check_user_login_usecase.dart';
import 'package:triplaner/domain/usecases/create_account_usecase.dart';
import 'package:triplaner/domain/usecases/delete_account_usecase.dart';
import 'package:triplaner/domain/usecases/login_usecase.dart';
import 'package:triplaner/domain/usecases/logout_usecase.dart';
import 'package:triplaner/domain/usecases/save_new_currency_usecase.dart';
import 'package:triplaner/domain/usecases/start_currency_session_usecase.dart';
import 'package:triplaner/network/network_repository.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/forget_password/forget_password_navigator.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/login/login_navigator.dart';
import 'package:triplaner/presentation/pages/authentication/otp/otp_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/otp/otp_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/otp/otp_navigator.dart';
import 'package:triplaner/presentation/pages/authentication/reset_password/reset_password_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/reset_password/reset_password_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/reset_password/reset_password_navigator.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_cubit.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_initial_params.dart';
import 'package:triplaner/presentation/pages/authentication/signup/signup_navigator.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_cubit.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_initial_params.dart';
import 'package:triplaner/presentation/pages/confirmation/confirmation_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/about_us/about_us_cubit.dart';
import 'package:triplaner/presentation/pages/main/account/about_us/about_us_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/about_us/about_us_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/account_cubit.dart';
import 'package:triplaner/presentation/pages/main/account/account_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/account_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/change_password/change_password_cubit.dart';
import 'package:triplaner/presentation/pages/main/account/change_password/change_password_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/change_password/change_password_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/currencies/currencies_cubit.dart';
import 'package:triplaner/presentation/pages/main/account/currencies/currencies_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/currencies/currencies_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/privacy_policy/privacy_policy_cubit.dart';
import 'package:triplaner/presentation/pages/main/account/privacy_policy/privacy_policy_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/privacy_policy/privacy_policy_navigator.dart';
import 'package:triplaner/presentation/pages/main/account/terms_of_use/terms_of_use_cubit.dart';
import 'package:triplaner/presentation/pages/main/account/terms_of_use/terms_of_use_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/terms_of_use/terms_of_use_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_cubit.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_initial_params.dart';
import 'package:triplaner/presentation/pages/main/activites/activities_navigator.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_cubit.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_initial_params.dart';
import 'package:triplaner/presentation/pages/main/activites/calendar/calendar_navigator.dart';

import 'package:triplaner/presentation/pages/main/activites/filter/filter_cubit.dart';
import 'package:triplaner/presentation/pages/main/activites/filter/filter_initial_params.dart';
import 'package:triplaner/presentation/pages/main/activites/filter/filter_navigator.dart';
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
import 'package:triplaner/presentation/pages/main/site_detail/check_availability/check_availability_cubit.dart';
import 'package:triplaner/presentation/pages/main/site_detail/check_availability/check_availability_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/check_availability/check_availability_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/redirect_popup/redirect_popup_cubit.dart';
import 'package:triplaner/presentation/pages/main/site_detail/redirect_popup/redirect_popup_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/redirect_popup/redirect_popup_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/reviews/reviews_cubit.dart';
import 'package:triplaner/presentation/pages/main/site_detail/reviews/reviews_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/reviews/reviews_navigator.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_cubit.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_initial_params.dart';
import 'package:triplaner/presentation/pages/main/site_detail/site_detail_navigator.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_cubit.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_initial_params.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_navigator.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_cubit.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_initial_params.dart';
import 'package:triplaner/presentation/pages/no_internet/no_internet_navigator.dart';
import 'package:triplaner/presentation/pages/splash/splash_cubit.dart';
import 'package:triplaner/presentation/pages/splash/splash_initial_params.dart';
import 'package:triplaner/presentation/pages/splash/splash_navigator.dart';
import 'package:triplaner/util/services/deep_linking/deep_link_service.dart';
import 'package:triplaner/util/services/device_info/device_info_service.dart';
import 'package:triplaner/util/services/internet/internet_connection_service.dart';
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

    /// services
    getIt.registerSingleton<LocationService>(LocationService());
    getIt.registerSingleton<DeviceInfoService>(DeviceInfoService());

    // getIt.registerSingleton<InternetConnectionService>(
    //     InternetConnectionService(appNavigator: getIt())..onInit());

    /// register repos layer repository
    getIt.registerSingleton<NetworkRepository>(
        NetworkRepository(localStorageRepository: getIt())..initialize());
    getIt.registerSingleton<AuthRepository>(
        RestAPIAuthRepository(networkRepository: getIt()));
    getIt.registerSingleton<DatabaseRepository>(RestAPIRepository(
      networkRepository: getIt(),
      deviceInfoService: getIt(),
    ));

    /// deep linking

    getIt.registerSingleton<DeepLinkService>(
        DeepLinkService(databaseRepository: getIt()));

    /// stores
    getIt.registerSingleton<UserStore>(UserStore());
    getIt.registerSingleton<CurrencyStore>(CurrencyStore());

    getIt.registerSingleton<WishListStore>(WishListStore(
      databaseRepository: getIt(),
      snackBar: getIt(),
    ));
    getIt.registerSingleton<BottomNavStore>(BottomNavStore());
    getIt.registerSingleton<FilterStore>(
        FilterStore(databaseRepository: getIt()));

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
      wishListStore: getIt(),
    ));
    getIt.registerSingleton<CreateAccountUseCase>(CreateAccountUseCase(
      authRepository: getIt(),
      userStore: getIt(),
      localStorageRepository: getIt(),
      wishListStore: getIt(),
    ));

    getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(
      authRepository: getIt(),
      userStore: getIt(),
      localStorageRepository: getIt(),
      wishListStore: getIt(),
    ));
    getIt.registerSingleton<DeleteAccountUseCase>(DeleteAccountUseCase(
      databaseRepository: getIt(),
      authRepository: getIt(),
      userStore: getIt(),
      localStorageRepository: getIt(),
      wishListStore: getIt(),
    ));

    getIt.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase(
      databaseRepository: getIt(),
      authRepository: getIt(),
      userStore: getIt(),
      loginUseCase: getIt(),
    ));
    getIt.registerSingleton<SaveNewCurrencyUseCase>(SaveNewCurrencyUseCase(
      localStorageRepository: getIt(),
      databaseRepository: getIt(),
      currencyStore: getIt(),
    ));
    getIt.registerSingleton<StartCurrencySessionUseCase>(
        StartCurrencySessionUseCase(
      localStorageRepository: getIt(),
      databaseRepository: getIt(),
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
              startCurrencySessionUseCase: getIt(),
            ));
    getIt.registerSingleton<HomeNavigator>(HomeNavigator(getIt()));
    getIt.registerFactoryParam<HomeCubit, HomeInitialParams, dynamic>(
        (param1, param2) => HomeCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
              locationService: getIt(),
              wishListStore: getIt(),
              bottomNavStore: getIt(),
              userStore: getIt(),
              currencyStore: getIt(),
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
              userStore: getIt(),
              wishListStore: getIt(),
            ));

    getIt.registerSingleton<ActivitiesNavigator>(ActivitiesNavigator(getIt()));
    getIt.registerFactoryParam<
            ActivitiesCubit, ActivitiesInitialParams, dynamic>(
        (param1, param2) => ActivitiesCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
              userStore: getIt(),
              wishListStore: getIt(),
              filterStore: getIt(),
              locationService: getIt(),
            ));

    getIt.registerSingleton<SiteDetailNavigator>(SiteDetailNavigator(getIt()));
    getIt.registerFactoryParam<
            SiteDetailCubit, SiteDetailInitialParams, dynamic>(
        (param1, param2) => SiteDetailCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
              userStore: getIt(),
              wishListStore: getIt(),
            ));
    getIt.registerSingleton<BottomNavigationNavigator>(
        BottomNavigationNavigator(getIt()));
    getIt.registerFactoryParam<BottomNavigationCubit,
            BottomNavigationInitialParams, dynamic>(
        (param1, param2) => BottomNavigationCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              bottomNavStore: getIt(),
              deepLinkService: getIt(),
            ));
    getIt.registerSingleton<SearchNavigator>(SearchNavigator(getIt()));
    getIt.registerFactoryParam<SearchCubit, SearchInitialParams, dynamic>(
        (param1, param2) => SearchCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              databaseRepository: getIt(),
              userStore: getIt(),
              wishListStore: getIt(),
              localStorageRepository: getIt(),
            ));

    getIt.registerSingleton<WishlistNavigator>(WishlistNavigator(getIt()));
    getIt.registerFactoryParam<WishlistCubit, WishlistInitialParams, dynamic>(
        (param1, param2) => WishlistCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              userStore: getIt(),
              wishListStore: getIt(),
              databaseRepository: getIt(),
              currencyStore: getIt(),
            ));
    getIt.registerSingleton<AccountNavigator>(AccountNavigator(getIt()));
    getIt.registerFactoryParam<AccountCubit, AccountInitialParams, dynamic>(
        (param1, param2) => AccountCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              userStore: getIt(),
              logoutUseCase: getIt(),
              deleteAccountUseCase: getIt(),
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

    getIt.registerSingleton<FilterNavigator>(FilterNavigator(getIt()));
    getIt.registerFactoryParam<FilterCubit, FilterInitialParams, dynamic>(
        (param1, param2) => FilterCubit(
              navigator: getIt(),
              initialParams: param1,
              snackBar: getIt(),
              filterStore: getIt(),
            ));

    getIt.registerSingleton<CheckAvailabilityNavigator>(
        CheckAvailabilityNavigator(getIt()));
    getIt.registerFactoryParam<CheckAvailabilityCubit,
            CheckAvailabilityInitialParams, dynamic>(
        (param1, param2) => CheckAvailabilityCubit(
              navigator: getIt(),
              initialParams: param1,
            ));

    getIt.registerSingleton<ReviewsNavigator>(ReviewsNavigator(getIt()));
    getIt.registerFactoryParam<ReviewsCubit, ReviewsInitialParams, dynamic>(
        (param1, param2) => ReviewsCubit(
              navigator: getIt(),
              initialParams: param1,
              databaseRepository: getIt(),
              snackBar: getIt(),
            ));
    getIt.registerSingleton<PrivacyPolicyNavigator>(
        PrivacyPolicyNavigator(getIt()));
    getIt.registerFactoryParam<PrivacyPolicyCubit,
            PrivacyPolicyInitialParams, dynamic>(
        (param1, param2) => PrivacyPolicyCubit(
              navigator: getIt(),
              initialParams: param1,
            ));
    getIt.registerSingleton<AboutUsNavigator>(AboutUsNavigator(getIt()));
    getIt.registerFactoryParam<AboutUsCubit, AboutUsInitialParams, dynamic>(
        (param1, param2) => AboutUsCubit(
              navigator: getIt(),
              initialParams: param1,
            ));
    getIt.registerSingleton<ChangePasswordNavigator>(
        ChangePasswordNavigator(getIt()));
    getIt.registerFactoryParam<ChangePasswordCubit,
            ChangePasswordInitialParams, dynamic>(
        (param1, param2) => ChangePasswordCubit(
              navigator: getIt(),
              initialParams: param1,
              changePasswordUseCase: getIt(),
              snackBar: getIt(),
            ));
    getIt.registerSingleton<TermsOfUseNavigator>(TermsOfUseNavigator(getIt()));
    getIt.registerFactoryParam<
            TermsOfUseCubit, TermsOfUseInitialParams, dynamic>(
        (param1, param2) => TermsOfUseCubit(
              navigator: getIt(),
              initialParams: param1,
            ));
    getIt.registerSingleton<CalendarNavigator>(CalendarNavigator(getIt()));
    getIt.registerFactoryParam<CalendarCubit, CalendarInitialParams, dynamic>(
        (param1, param2) => CalendarCubit(
              navigator: getIt(),
              initialParams: param1,
            ));
    getIt.registerSingleton<NoInternetNavigator>(NoInternetNavigator(getIt()));
    getIt.registerFactoryParam<
            NoInternetCubit, NoInternetInitialParams, dynamic>(
        (param1, param2) => NoInternetCubit(
              navigator: getIt(),
              initialParams: param1,
            ));

    getIt.registerSingleton<CurrenciesNavigator>(CurrenciesNavigator(getIt()));
    getIt.registerFactoryParam<
            CurrenciesCubit, CurrenciesInitialParams, dynamic>(
        (param1, param2) => CurrenciesCubit(
              navigator: getIt(),
              initialParams: param1,
              localStorageRepository: getIt(),
              saveNewCurrencyUseCase: getIt(),
            ));
    getIt.registerSingleton<RedirectPopupNavigator>(
        RedirectPopupNavigator(getIt()));
    getIt.registerFactoryParam<RedirectPopupCubit,
            RedirectPopupInitialParams, dynamic>(
        (param1, param2) => RedirectPopupCubit(
              navigator: getIt(),
              initialParams: param1,
            ));

    getIt.registerSingleton<OtpNavigator>(OtpNavigator(getIt()));
    getIt.registerFactoryParam<OtpCubit, OtpInitialParams, dynamic>(
        (param1, param2) => OtpCubit(
              navigator: getIt(),
              initialParams: param1,
              authRepository: getIt(),
              snackBar: getIt(),
            ));

    getIt.registerSingleton<ResetPasswordNavigator>(
        ResetPasswordNavigator(getIt()));
    getIt.registerFactoryParam<ResetPasswordCubit,
            ResetPasswordInitialParams, dynamic>(
        (param1, param2) => ResetPasswordCubit(
              navigator: getIt(),
              initialParams: param1,
              authRepository: getIt(),
              snackBar: getIt(),
            ));
  }
}
