import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/city.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/presentation/pages/main/home/widgets/home_top.dart';
import 'package:triplaner/presentation/widgets/activity_widget.dart';
import 'package:triplaner/presentation/widgets/city_card.dart';

import 'package:triplaner/presentation/widgets/site/site_mini_card.dart';

import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_style.dart';
import '../../../widgets/stack_loader.dart';
import 'home_cubit.dart';
import 'home_state.dart';
import 'widgets/nearby_attraction_home_tour_button.dart';

class HomePage extends StatefulWidget {
  final HomeCubit cubit;

  const HomePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  HomeCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
     cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<HomeCubit, HomeState>(
            bloc: cubit,
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// home top
                        const HomeTop(),
                        SizedBox(
                          height: 22.h,
                        ),
                         NearbyAttractionHomeTourButton(
                           onGuidedTourTap:cubit.onGuidedTour,
                           onNearbyAttractionTap: cubit.onNearbyAttraction,
                         ),
                        title("Popular Destinations"),
                        SizedBox(
                          height: 170.h,
                          child: Skeletonizer(
                            enabled: state.loadingPopularGateways,
                            ignorePointers: state.loadingPopularGateways,
                            child: ListView.builder(
                              itemCount: state.loadingPopularGateways
                                  ? 10
                                  : state.cities.length,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                City city = state.loadingPopularGateways
                                    ? City.empty()
                                    : state.cities[index];
                                return CityCard(
                                  city: city,
                                  onTap: () {
                                    cubit.destinationTapAction(city);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        title("Sightseeing tours"),
                        SizedBox(
                          height: 335.h,
                          child: Skeletonizer(
                            enabled: state.loadingSiteSeeingTours,
                            ignorePointers: state.loadingSiteSeeingTours,
                            child: ListView.builder(
                              itemCount: state.loadingSiteSeeingTours?5:state.siteSeeingTours.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              itemBuilder: (context, index) {
                                Site site=state.loadingSiteSeeingTours?Site.empty():state.siteSeeingTours[index];
                                return miniSiteCard(
                                  site: site,
                                );
                              },
                            ),
                          ),
                        ),
                        title("Top Activities"),
                        SizedBox(
                          height: 116.h,
                          child: Skeletonizer(
                            enabled: state.loadingTopActivities,
                            child: ListView.builder(
                              itemCount: state.loadingTopActivities
                                  ? 10
                                  : state.topActivities.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              itemBuilder: (context, index) {
                                TopActivity topActivity = state.loadingTopActivities
                                    ? TopActivity.empty()
                                    : state.topActivities[index];
                                return ActivityWidget(
                                  topActivity: topActivity,
                                  onTap:(){
                                    cubit.activityAction(topActivity);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        title("Attractions worldwide"),
                        SizedBox(
                          height: 335.h,
                          child: Skeletonizer(
                            enabled: state.loadingAttractionWorldWide,
                            child: ListView.builder(
                              itemCount: state.loadingAttractionWorldWide?5:state.attractionsWorldWide.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              itemBuilder: (context, index) {
                                Site site=state.loadingAttractionWorldWide?Site.empty():state.attractionsWorldWide[index];
                                return miniSiteCard(
                                  site: site,
                                );
                              },
                            ),
                          ),
                        ),
                        title("Water adventures"),
                        SizedBox(
                          height: 335.h,
                          child:  Skeletonizer(
                            enabled: state.loadingWaterAdventures,
                            child: ListView.builder(
                              itemCount: state.loadingWaterAdventures?5:state.waterAdventures.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              itemBuilder: (context, index) {
                                Site site=state.loadingWaterAdventures?Site.empty():state.waterAdventures[index];
                                return miniSiteCard(
                                  site: site,
                                );
                              },
                            ),
                          ),
                        ),

                        title("More to explore", showSeeMore: true),
                        Skeletonizer(
                          enabled: state.loadingMoreToExplore,
                          child: AlignedGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemCount: state.loadingMoreToExplore?6:state.moreToExplore.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Site site=state.loadingMoreToExplore?Site.empty():state.moreToExplore[index];
                              return miniSiteCard(
                                site: site,
                                isGridView: true
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                   StackLoader(
                    show: state.stackLoading,
                     title: "Getting your location",
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget miniSiteCard({required Site site,bool isGridView=false}){
    return SiteMiniCard(
      gridviewMode:isGridView,
      site: site,
      onTap: (){
        cubit.onSiteTap(site);
      },
    );
  }

  Widget title(String title, {bool showSeeMore = false}) {
    return Padding(
      padding: AppConstant.screenPadding.copyWith(top: 24.h, bottom: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyle.headingH1(context),
          ),
          showSeeMore
              ? InkWell(
            onTap: (){
              cubit.seeMoreAction();
            },
                child: Row(
                    children: [
                      Text(
                        "See all",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 15.h,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
              )
              : const SizedBox()
        ],
      ),
    );
  }
}
