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
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: CustomAppBar(
              title: state.title,
              action: [
                SvgPicture.asset(
                  AppAssets.circularCalendar,
                  height: 40.h,
                  width: 40.w,
                ),
              ],
            ),
            body:CustomSingleChildScrollViewWithLoadMore(
                    isEmpty: state.sites.isEmpty,
                    enableScrollUp: true,
                    onLoadMore: () {
                      cubit.getMoreSitesFromEndpoint();
                    },
                    isLoadingMore: state.loadingMore,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),

                        /// top menu for filter and all other stuff
                        SizedBox(
                          height: 32.h,
                          child: Skeletonizer(
                            enabled: state.loading,
                            child: ListView.builder(
                              itemCount: cubit.menu.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              itemBuilder: (context, index) {
                                return CustomChip(
                                  title: cubit.menu[index]['title'],
                                  assetPath: cubit.menu[index]['iconPath'],
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: const Divider(
                            thickness: 1,
                            height: 0,
                          ),
                        ),
                        // Padding(
                        //   padding: AppConstant.screenPadding,
                        //   child: Text("250 activities ",style: TextStyle(
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w600
                        //   ),),
                        // ),
                        // SizedBox(height: 10.h,),
                        Skeletonizer(
                          enabled: state.loading,
                          child: ListView.builder(
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
                                onTap: () {
                                  cubit.onTapAction(site);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
