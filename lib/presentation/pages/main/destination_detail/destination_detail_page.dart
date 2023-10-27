import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/attraction.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/entities/top_activity.dart';
import 'package:triplaner/presentation/widgets/activity_widget.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/site/site_tile.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_colors.dart';
import '../../../../util/app_constant.dart';
import '../../../../util/app_style.dart';
import '../../../widgets/custom_single_child_scroll_view.dart';
import '../../../widgets/site/site_mini_card.dart';
import 'destination_detail_cubit.dart';
import 'destination_detail_initial_params.dart';
import 'destination_detail_state.dart';

class DestinationDetailPage extends StatefulWidget {
  final DestinationDetailCubit cubit;

  const DestinationDetailPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetailPage> {
  DestinationDetailCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DestinationDetailCubit, DestinationDetailState>(
          bloc: cubit,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: CustomAppBar(
                title: "${state.city.name}",
                action: [
                  SvgPicture.asset(
                    AppAssets.circularCalendar,
                    height: 40.h,
                    width: 40.w,
                  ),
                ],
              ),
              body: CustomSingleChildScrollViewWithLoadMore(
                  isLoadingMore: state.loadingMoreUncover,
                  enableScrollUp: true,
                  onLoadMore: () {
                      cubit.getMoreUncover();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title("Popular Activities to do"),
                      SizedBox(
                        height: 116.h,
                        child: Skeletonizer(
                          enabled: state.loading,
                          child: ListView.builder(
                            itemCount: state.loading
                                ? 5
                                : state.popularGatewayDetail.activities?.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            itemBuilder: (context, index) {
                              TopActivity topActivity = state.loading
                                  ? TopActivity.empty()
                                  : state
                                      .popularGatewayDetail.activities![index];
                              return ActivityWidget(
                                topActivity: topActivity,
                                onTap: () {
                                  cubit.activityAction(topActivity);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Skeletonizer(
                        enabled: state.loading,
                        child: ListView.builder(
                            itemCount: state.loading
                                ? 3
                                : state
                                    .popularGatewayDetail.attractions?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, attractionsIndex) {
                              Attraction attraction = state.loading
                                  ? Attraction.empty()
                                  : state.popularGatewayDetail
                                      .attractions![attractionsIndex];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title("${attraction.name}"),
                                  SizedBox(
                                    height: 335.h,
                                    child: SizedBox(
                                      child: ListView.builder(
                                        itemCount: state.loading
                                            ? 3
                                            : attraction.sites?.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        itemBuilder: (context, index) {
                                          Site site = state.loading
                                              ? Site.empty()
                                              : attraction.sites![index];
                                          return SiteMiniCard(
                                            site: site,
                                            onTap: (){
                                              cubit.siteAction(site);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      // title("Sightseeing tours"),
                      // SizedBox(
                      //   height: 335.h,
                      //   child: ListView.builder(
                      //     itemCount: 10,
                      //     scrollDirection: Axis.horizontal,
                      //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                      //     itemBuilder: (context, index) {
                      //       return  SiteMiniCard(
                      //         site: Site.empty(),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // title("Things to do in ${state.city.name}"),
                      // SizedBox(
                      //   height: 335.h,
                      //   child: ListView.builder(
                      //     itemCount: 10,
                      //     scrollDirection: Axis.horizontal,
                      //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                      //     itemBuilder: (context, index) {
                      //       return  SiteMiniCard(
                      //         site: Site.empty(),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // title("Cultural experience"),
                      // SizedBox(
                      //   height: 335.h,
                      //   child: ListView.builder(
                      //     itemCount: 10,
                      //     scrollDirection: Axis.horizontal,
                      //     padding: EdgeInsets.symmetric(horizontal: 8.w),
                      //     itemBuilder: (context, index) {
                      //       return  SiteMiniCard(
                      //         site: Site.empty(),
                      //       );
                      //     },
                      //   ),
                      // ),
                      title("Uncover more"),
                      Skeletonizer(
                        enabled: state.loadingUncover,
                        child: ListView.builder(
                          itemCount: state.loadingUncover?5:state.unCoverMore.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          itemBuilder: (context, index) {
                            Site site=state.loadingUncover?Site.empty():state.unCoverMore[index];
                            return  SiteTile(
                              site: site,
                              onTap: (){
                                cubit.siteAction(site);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: AppConstant.screenPadding.copyWith(top: 15.h, bottom: 15.h),
      child: Text(
        title,
        style: AppStyle.headingH1(context),
      ),
    );
  }
}
