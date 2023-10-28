import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/excludes_widget.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/includes_widget.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/overview_widget.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/site_detail_top.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/presentation/widgets/custom_star_rating.dart';
import 'package:triplaner/presentation/widgets/review_widget.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_style.dart';
import '../../../../util/app_assets.dart';
import '../../../widgets/site/site_mini_card.dart';
import 'site_detail_cubit.dart';
import 'site_detail_initial_params.dart';
import 'site_detail_state.dart';
import 'widgets/rating_widget.dart';
import 'widgets/site_detail_info.dart';
import 'widgets/site_detail_menu.dart';
import 'dart:math' as math;

class SiteDetailPage extends StatefulWidget {
  final SiteDetailCubit cubit;

  const SiteDetailPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SiteDetailPage> createState() => _SiteDetailState();
}

class _SiteDetailState extends State<SiteDetailPage> {
  SiteDetailCubit get cubit => widget.cubit;

  /// TODO: MOVE THIS TO CUBIT AND REFACTOR CODE
  final ScrollController _scrollController = ScrollController();
  double overViewStartingIndex = 0;
  double includesStartingIndex = 300;
  double excludesStartingIndex = 550;
  double ratingStartingIndex = 800;

  /// TODO: HAVE TO FIX THIS

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    _scrollController.addListener(() {
      // This function will be called whenever the user scrolls the view.
      double currentScrollPosition = _scrollController.position.pixels;
      debugPrint("CURRENT POSITION ==> : $currentScrollPosition");

      /// update appbar code
      if (currentScrollPosition >= 160) {
        debugPrint("changed status of appbar :");
        cubit.updateAppbarView(true);
      } else {
        cubit.updateAppbarView(false);
      }

      if (currentScrollPosition >= ratingStartingIndex) {
        cubit.updateSelectedMenu(3);
        cubit.getSimilarExperiences();
      } else if (currentScrollPosition >= excludesStartingIndex) {
        cubit.updateSelectedMenu(2);
      } else if (currentScrollPosition >= includesStartingIndex) {
        cubit.updateSelectedMenu(1);
      } else if (currentScrollPosition > overViewStartingIndex) {
        cubit.updateSelectedMenu(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SiteDetailCubit, SiteDetailState>(
          bloc: cubit,
          builder: (context, state) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  expandedHeight: 280.h,
                  collapsedHeight: 100.h,
                  automaticallyImplyLeading: false,
                  floating: false,
                  flexibleSpace: state.showAppbar
                      ? CustomAppBar(
                          title: '${state.site.title}',
                          actionFlex: 3,
                          action: [
                            SvgPicture.asset(
                              AppAssets.circularShare,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            SizedBox(width: 8.w,),
                            SvgPicture.asset(
                              AppAssets.circularBookmark,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ],
                        )
                      : SiteDetailTop(
                          images: state.site.images
                                  ?.map((e) => e.toJson().getImageUrl() ?? "")
                                  .toList() ??
                              [],
                        ),
                ),
                SliverToBoxAdapter(
                  child: SiteDetailInfo(
                    site: state.site,
                  ),
                ),
                SliverAppBar(
                  elevation: 0.0,
                  pinned: true,
                  primary: false,
                  automaticallyImplyLeading: false,
                  // backgroundColor: Colors.transparent,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  titleTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  titleSpacing: 0,
                  title: SiteDetailMenu(
                    menus: const [
                      "Overview",
                      "Includes",
                      "Excludes",
                      "Review"
                    ],
                    selectedIndex: state.selectedMenuIndex,
                    onTap: (index) async {
                      cubit.updateSelectedMenu(index);
                      _navigateToTabSection(index);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: AppConstant.screenPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OverviewWidget(
                              site: state.site,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            IncludesWidget(
                              site: state.site,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            ExcludesWidget(
                              site: state.site,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 22.h),
                              child: Text(
                                "This product is offered by our partner ${state.site.provider} ",
                                style: AppStyle.headingH2(context),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            RatingWidget(
                              site: state.site,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "See all reviews",
                                    style: TextStyle(
                                        letterSpacing: 0,
                                        color:
                                            Theme.of(context).primaryColor),
                                  )),
                            ),

                            /// TODO : SHOW ONLY 2 REVIEWS THERE
                            const ReviewWidget(),
                            const ReviewWidget(),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              "Cancellation policy",
                              style: AppStyle.headingH2(context),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "${state.site.cancellationPolicy?.description}",
                              style: AppStyle.headingH3(context),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 22.h),
                              child: Text(
                                "Similar experiences",
                                style: AppStyle.headingH2(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 335.h,
                        child: Skeletonizer(
                          enabled: state.loadingSimilarExperiences,
                          child: ListView.builder(
                            itemCount: state.loadingSimilarExperiences
                                ? 5
                                : state.similarExperiences.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            itemBuilder: (context, index) {
                              Site site = state.loadingSimilarExperiences
                                  ? Site.empty()
                                  : state.similarExperiences[index];
                              return SiteMiniCard(
                                site: site,
                                onTap: () {
                                  // scrollToPosition(0);
                                  cubit.similarExperienceTap(site);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),

                    ],
                  ),
                )
              ],
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: AppConstant.screenPadding.copyWith(bottom: 16.h,top: 10.h),
        child: CustomButton(
            text: "Check Availability", action: () {}),
      ),
    );
  }

  /// TODO: MOVE THIS TO CUBIT ALSO
  _navigateToTabSection(int index) {
    switch (index) {
      case 0:
        scrollToPosition(overViewStartingIndex);
        break;
      case 1:
        scrollToPosition(includesStartingIndex);
        break;
      case 2:
        scrollToPosition(excludesStartingIndex);
        break;
      case 3:
        scrollToPosition(ratingStartingIndex);
        break;
    }
  }

  scrollToPosition(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      // Adjust the duration as needed.
      curve: Curves.easeIn, // Use a different curve if desired.
    );
  }
}
