
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/data/repositories/hive_repository.dart';
import 'package:triplaner/navigation/app_navigator.dart';
import 'package:triplaner/presentation/pages/main/home/home_initial_params.dart';
import 'package:triplaner/presentation/pages/main/home/home_page.dart';
import 'package:triplaner/presentation/pages/splash/splash_initial_params.dart';
import 'package:triplaner/presentation/pages/splash/splash_page.dart';
import 'package:triplaner/util/app_colors.dart';
import 'package:triplaner/util/app_funtions.dart';

import 'firebase_options.dart';
import 'util/app_constant.dart';
import 'util/app_theme.dart';
import 'util/dependency/app_dependency.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// set orientation of mobile
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await HiveRepository.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// initialization of dependency injection
  AppDependency.initialize();

  /// run main
  runApp(
    ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: AppNavigator.navigatorKey,
            builder:  (BuildContext context, Widget? child) {
              Widget error = const Text('something went wrong');
              if (child is Scaffold || child is Navigator) {
                error = Scaffold(body: Center(child: error));
              }
              ErrorWidget.builder = (errorDetails) => error;

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.sp,), //set desired text scale factor here
                child: child!,
              );
            },
            title: AppConstant.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            home: SplashPage(
              cubit: getIt(param1: const SplashInitialParams()),
            ),

          );
        }),
  );
}


