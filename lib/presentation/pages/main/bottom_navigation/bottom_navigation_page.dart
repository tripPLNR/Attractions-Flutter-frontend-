import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/pages/main/account/account_initial_params.dart';
import 'package:triplaner/presentation/pages/main/account/account_page.dart';
import 'package:triplaner/presentation/pages/main/search/search_initial_params.dart';
import 'package:triplaner/presentation/pages/main/search/search_page.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_initial_params.dart';
import 'package:triplaner/presentation/pages/main/wishlist/wishlist_page.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_funtions.dart';
import '../../../../util/dependency/app_dependency.dart';
import '../home/home_initial_params.dart';
import '../home/home_page.dart';
import 'bottom_navigation_cubit.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationPage extends StatefulWidget {
  final BottomNavigationCubit cubit;

  const BottomNavigationPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationPage> {
  BottomNavigationCubit get cubit => widget.cubit;

  List<Widget> pages = [
    HomePage(cubit: getIt(param1: const HomeInitialParams())),
    SearchPage(cubit: getIt(param1: const SearchInitialParams())),
    WishlistPage(cubit: getIt(param1: const WishlistInitialParams())),
    AccountPage(cubit: getIt(param1: const AccountInitialParams())),

  ];

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    AppFunctions.transparentStatusBar();

    return SafeArea(
      top: false,
      bottom: Platform.isAndroid,
      child: BlocBuilder<BottomNavigationCubit,BottomNavigationState>(
          bloc: cubit,
        builder: (context,state) {
          return Scaffold(
              extendBody: true,
            backgroundColor:Theme.of(context).colorScheme.background,
              body:Padding(
                padding: EdgeInsets.only(bottom: 65.h),
                child: pages.elementAt(state.selectedIndex),
              ),
              bottomNavigationBar: Container(
                height: Platform.isAndroid?72.h:80.h,
                // margin: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r)
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38.withOpacity(0.1),
                        spreadRadius: 0.r,
                        blurRadius: 10.r,
                        offset: Offset(0, -4),
                    )
                  ],
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r)
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      selectedFontSize: 11.sp,
                      unselectedFontSize: 11.sp,
                      selectedItemColor: Theme.of(context).colorScheme.primary,
                      unselectedItemColor: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                      items: <BottomNavigationBarItem>[
                        customBottomNavigationItem(state.selectedIndex==0?AppAssets.selectedHomeBottomNav:AppAssets.homeBottomNav, "Home", ),
                        customBottomNavigationItem(state.selectedIndex==1?AppAssets.selectedSearchBottomNav:AppAssets.searchBottomNav, "Search", ),
                        customBottomNavigationItem(state.selectedIndex==2?AppAssets.selectedWishlistBottomNav:AppAssets.wishlistBottomNav, "Wishlist", ),
                        customBottomNavigationItem(state.selectedIndex==3?AppAssets.selectedUserBottomNav:AppAssets.userBottomNav, "Account", ),
                      ],
                      type: BottomNavigationBarType.fixed,
                      currentIndex: state.selectedIndex,
                      selectedLabelStyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),

                      unselectedLabelStyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                      ),
                      onTap: cubit.changePage,
                      elevation: 10,
                    ),
                  ),
                ),
              ),
            );
        }
      ),
    );
  }

  customBottomNavigationItem(String path, String label) {
    return BottomNavigationBarItem(
      icon: BlocBuilder<BottomNavigationCubit,BottomNavigationState>(
        bloc: cubit,
        builder: (context,state) {
          return Padding(
            padding:  EdgeInsets.only(bottom: 4.h),
            child: SvgPicture.asset(
              path,
              height: 24.h,
              width: 24.h,
            ),
          );
        }
      ),
      label: label,
    );
  }
}
