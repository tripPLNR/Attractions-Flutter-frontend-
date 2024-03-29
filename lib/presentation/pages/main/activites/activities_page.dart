import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/custom_chip.dart';
import 'package:triplaner/presentation/widgets/custom_single_child_scroll_view.dart';
import 'package:triplaner/presentation/widgets/site/site_card.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'activities_cubit.dart';
import 'activities_initial_params.dart';
import 'activities_state.dart';
import 'package:badges/badges.dart' as badges;

class ActivitiesPage extends StatefulWidget {
  final ActivitiesCubit cubit;

  const ActivitiesPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<ActivitiesPage> {
  ActivitiesCubit get cubit => widget.cubit;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.disposeAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesCubit, ActivitiesState>(
        bloc: cubit,
        listener: (context, state) {
          debugPrint("loading : ${state.loading}");
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: (!state.loading && state.sites.isEmpty)
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.background,
            appBar: CustomAppBar(
              title: state.title,
              actionFlex: 1,
              action: [
                // GestureDetector(
                //     onTap: cubit.openCalendarAction,
                //     child: SvgPicture.asset(AppAssets.circularCalendar)),
              ],
            ),
            body: (!state.loading && state.sites.isEmpty)
                ? Center(
                    child: SvgPicture.asset(
                      AppAssets.noRecordExist,
                    ),
                  )
                : CustomSingleChildScrollViewWithLoadMore(
                    isEmpty: state.sites.isEmpty,
                    enableScrollUp: true,
                    noMoreRecord: state.noMoreSites,
                    onScrollEndReached: () {
                      cubit.onScrollReachesEndGetRecord();
                    },
                    onLoadMore: () {
                      cubit.getNextRecordAccordingToFilter();
                    },
                    isLoadingMore: state.loadingMore,
                    filterAction:
                        cubit.initialParams.showFilterButton?cubit.openFilterPage:null,
                    child: Skeletonizer(
                      enabled: state.loading,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                AppConstant.screenPadding.copyWith(top: 15.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${state.totalActivities} activities found",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer),
                                ),
                                Visibility(
                                  visible: cubit.initialParams.showNearbyButton,
                                  child: GestureDetector(
                                      onTap: state.loading?null:cubit.getNearbyAttraction,
                                      child:
                                          SvgPicture.asset(AppAssets.nearbyGps)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ListView.builder(
                            itemCount: state.loading ? 5 : state.sites.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            itemBuilder: (context, index) {
                              Site site = state.loading
                                  ? Site.empty()
                                  : state.sites[index];
                              return SiteCard(
                                site: site,
                                isBookMarked: cubit.isBookMarked(site),
                                onBookMarkTap: () {
                                  cubit.onBookMarkTap(site);
                                },
                                onTap: () {
                                  cubit.onTapAction(site);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
