import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/site/site_tile.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_theme.dart';
import '../../../../domain/entities/site.dart';
import 'widgets/wishlist_shimmer.dart';
import 'wishlist_cubit.dart';
import 'wishlist_initial_params.dart';
import 'wishlist_state.dart';

class WishlistPage extends StatefulWidget {
  final WishlistCubit cubit;

  const WishlistPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistState();
}

class _WishlistState extends State<WishlistPage> {
  WishlistCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          hideBack: true,
          title: "Wishlist",
          centerTitle: true,
        ),
        body: BlocBuilder<WishlistCubit, WishlistState>(
            bloc: cubit,
            builder: (context, state) {
              return state.loading
                  ? const WishListShimmer()
                  : state.sites.isEmpty
                      ? Column(
                          children: [
                            SvgPicture.asset(AppAssets.noRecordFound),
                            cubit.isUserLoggedIn()
                                ? const SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      cubit.loginAction();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'login ',
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  AppTheme.montserratAlternates,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text:
                                                    'to save activities to wishlist',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiaryContainer))
                                          ]),
                                    ),
                                  )
                          ],
                        )
                      : ListView.builder(
                          itemCount: state.sites.length,
                          padding: AppConstant.screenPadding.copyWith(top: 8.h).copyWith(bottom: 65.h),
                          itemBuilder: (context, index) {
                            Site site = state.sites[index];
                            return Padding(
                              padding:  EdgeInsets.only(bottom: 13.h),
                              child: Slidable(
                              //    dragStartBehavior: DragStartBehavior.start,
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dragDismissible: false,
                                    dismissible: DismissiblePane(onDismissed: () {
                                      debugPrint("Dismissed");
                                    }),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) {
                                          cubit.shareSiteAction(site);
                                        },
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                        foregroundColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                        icon: Icons.share,
                                        label: 'Share',
                                      ),
                                      SlidableAction(
                                        onPressed: (_) {
                                          cubit.removeFromWishList(site);
                                        },
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        foregroundColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),

                                    ],
                                  ),
                                  child: SiteTile(
                                    site: site,
                                    isBookMarked: true,
                                    onTap: (){
                                      cubit.onSiteAction(site);
                                    },
                                    bottomMargin: 0,
                                    onBookMarkTap: (){
                                      cubit.removeFromWishList(site);
                                    },
                                  )),
                            );
                          },
                        );
            }));
  }
}
