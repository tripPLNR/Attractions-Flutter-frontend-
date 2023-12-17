import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/review_rating.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/excludes_widget.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/includes_widget.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/overview_widget.dart';
import 'package:triplaner/presentation/pages/main/site_detail/widgets/site_detail_top.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/presentation/widgets/review_widget.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_extentions.dart';
import 'package:triplaner/util/app_style.dart';
import '../../../../util/app_assets.dart';
import '../../../widgets/site/site_mini_card.dart';
import 'site_detail_cubit.dart';
import 'site_detail_initial_params.dart';
import 'site_detail_state.dart';
import 'widgets/check_availability_widget.dart';
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


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit.getAndSetOffsets();
  }

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cubit.popSite();
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<SiteDetailCubit, SiteDetailState>(
            bloc: cubit,
            builder: (context, state) {
              return CustomScrollView(
                controller: cubit.scrollController,
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    pinned: true,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    expandedHeight: 280.h,
                    collapsedHeight: AppConstant.appBarHeight,
                    automaticallyImplyLeading: false,
                    floating: false,
                    flexibleSpace: state.showAppbar
                        ? CustomAppBar(
                            title: '',
                            actionFlex: 3,
                            onBack: () {
                              cubit.popSite();
                            },
                            action: [
                              InkWell(
                                onTap: () {
                                  cubit.shareAction();
                                },
                                child: SvgPicture.asset(
                                  AppAssets.circularShare,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.onBookMarkTap(state.site);
                                },
                                child: SvgPicture.asset(
                                  cubit.isBookMarked(state.site)
                                      ? AppAssets.bookmarked
                                      : AppAssets.circularBookmark,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          )
                        : SiteDetailTop(
                            images: state.site.images
                                    ?.map(
                                        (e) => e.variants!.getUrlBySize() ?? "")
                                    .toList() ??
                                [],
                            isBookMarked: cubit.isBookMarked(state.site),
                            onBookMarkTap: () {
                              cubit.onBookMarkTap(state.site);
                            },
                            onShare: () {
                              cubit.shareAction();
                            },
                            onBack: () {
                              cubit.popSite();
                            },
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
                   // surfaceTintColor: Colors.red,
                    automaticallyImplyLeading: false,
                    // backgroundColor: Colors.transparent,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    titleTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                    titleSpacing: 0,
                    title: SiteDetailMenu(
                      menus: state.menus,
                      selectedIndex: state.selectedMenuIndex,
                      onTap: (index, menu) async {
                        cubit.updateSelectedMenu(index);
                        cubit.navigateToTabSection(menu);
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
                                key: cubit.overViewWidgetKey,
                                onTextCollapsed: (isTextCollapsed) {
                                  cubit.updateTextShowMore(isTextCollapsed);
                                },
                              ),
                              Visibility(
                                visible: state.menus.contains("Includes"),
                                child: IncludesWidget(
                                  key: cubit.includesWidgetKey,
                                  site: state.site,
                                ),
                              ),
                              Visibility(
                                visible: state.menus.contains("Excludes"),
                                child: ExcludesWidget(
                                  site: state.site,
                                  key: cubit.excludesWidgetKey,
                                ),
                              ),
                              CheckAvailabilityWidget(
                                onCustomDatePicker: cubit.selectDate,
                                selectedDate: state.checkAvailabilityDate,
                                onDateSelect: cubit.checkAvailabilityForDate,
                                onClear: cubit.clearCheckAvailabilityDate,
                              ),
                              RatingWidget(
                                site: state.site,
                                key: cubit.reviewWidgetKey,
                              ),
                              Skeletonizer(
                                enabled: state.loadingReviews,
                                child: ListView.builder(
                                  itemCount: state.loadingReviews
                                      ? 2
                                      : state.reviewsRatings.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.only(left: 8.w,right: 8.w,top: 22.h),
                                  itemBuilder: (context, index) {
                                    ReviewRating reviewRating =
                                        state.loadingReviews
                                            ? ReviewRating.empty()
                                            : state.reviewsRatings[index];
                                    return ReviewWidget(
                                      reviewRating: reviewRating,
                                      hideDivider: index==state.reviewsRatings.length-1,
                                    );
                                  },
                                ),
                              ),
                              Visibility(
                                visible: state.reviewsRatings.isNotEmpty,
                                child: Center(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: cubit.openReviewsPage,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 3.h),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                            borderRadius: BorderRadius.circular(5.r)
                                          ),
                                          child: Text(
                                            "See more reviews",
                                            style: TextStyle(
                                                letterSpacing: 0,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        height: 0,
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "Cancellation policy",
                                style: AppStyle.siteDetailHeading(context),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),

                              Text(
                                state.site.isRefundAvailable()?
                                "You can cancel these tickets up to 24 hours before the activity starts to get full refund.":"These tickets can't be cancelled or rescheduled.",
                                style: AppStyle.siteDetailSubHeading(context),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              const Divider(
                                thickness: 1,
                                height: 0,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 22.h),
                                    child: Text(
                                      "This product is offered by our partner ${state.site.provider} ",
                                      style: AppStyle.siteDetailHeading(context),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    height: 0,
                                  ),
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 22.h),
                                child: Text(
                                  "Similar experiences",
                                  style: AppStyle.siteDetailHeading(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppConstant.horizontalMiniCardHeight,
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
                                  isBookMarked: cubit.isBookMarked(site),
                                  onBookMarkTap: () {
                                    cubit.onBookMarkTap(site);
                                  },
                                  onTap: () {

                                    cubit.similarExperienceTap(site);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
     //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: AppConstant.screenPadding.copyWith(bottom: 16.h, top: 10.h),
          child: CustomButton(
              text: "BOOK NOW",
              height: 55.h,
              action: () {
                  cubit.checkAvailabilityAction();
              }),
        ),
      ),
    );
  }



}
