import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/search_location.dart';
import 'package:triplaner/domain/entities/search_suggestion.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/pages/main/search/widgets/recent_search_tile.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/presentation/widgets/custom_textfield.dart';
import 'package:triplaner/presentation/widgets/site/site_tile.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_style.dart';
import 'search_cubit.dart';
import 'search_initial_params.dart';
import 'search_state.dart';
import 'widgets/search_attraction_suggestion.dart';
import 'widgets/search_shimmer.dart';
import 'widgets/search_suggestion_tile.dart';

class SearchPage extends StatefulWidget {
  final SearchCubit cubit;

  const SearchPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  SearchCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
              appBar: CustomAppBar(
                title: '',
                height: 100.h,
                titleWidget: CustomTextField(
                  controller: cubit.txtSearch,
                  prefixPath: AppAssets.search,
                  suffixPath: state.showClearIcon ? AppAssets.close : null,
                  autoFocus: true,
                  suffixAction: () {
                    cubit.clearSearch();
                  },
                  onChange: (val) {
                    cubit.onSearchAction();
                  },
                  onSubmit: (val) {
                    cubit.onSearchAction();
                  },
                  label: "",
                  hint: "Search Destinations, Activities..........",
                  bottomPadding: 0,
                ),
              ),
              body:
              // state.loading
              //     ?
              //     // Load a Lottie file from your assets
              //     Center(child: Lottie.asset(AppAssets.searchAnimation,height: 250.h))
              //     :
              SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: state.suggestedSites.isNotEmpty ||
                                state.suggestedLocations.isNotEmpty ||
                                state.recentSearches.isNotEmpty,
                            child: GestureDetector(
                              onTap: () {
                                cubit.clearSearch();
                              },
                              child: Padding(
                                padding: AppConstant.screenPadding
                                    .copyWith(top: 20.h),
                                child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("Clear All")),
                              ),
                            ),
                          ),
                          state.loading
                              ? const SearchShimmer()
                              : state.suggestedLocations.isEmpty
                                  ? state.recentSearches.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  AppConstant.screenPadding,
                                              child: Text(
                                                "Recent searches",
                                                style:
                                                    AppStyle.headingH2(context),
                                              ),
                                            ),
                                            ListView.builder(
                                              itemCount:
                                                  state.recentSearches.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              itemBuilder: (context, index) {
                                                return RecentSearchTile(
                                                  search: state
                                                      .recentSearches[index],
                                                  onTap: () {
                                                    cubit.txtSearch.text = state
                                                        .recentSearches[index];
                                                    cubit.onSearchAction();
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      : Padding(
                                          padding: AppConstant.screenPadding
                                              .copyWith(top: 10.h),
                                          child: Text(
                                            "No result found.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiaryContainer,
                                                fontSize: 20.sp),
                                          ),
                                        )
                                  : ListView.builder(
                                      itemCount:
                                          state.suggestedLocations.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(top: 0.h),
                                      itemBuilder: (context, index) {
                                        SearchLocation searchLocation =
                                            state.suggestedLocations[index];
                                        return SearchSuggestionTile(
                                          searchSuggestion: searchLocation,
                                          onTap: () {
                                            cubit.onSuggestionTap(
                                                searchLocation);
                                          },
                                        );
                                      },
                                    ),
                          Skeletonizer(
                            enabled: state.loading,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.loading
                                  ? 8
                                  : state.suggestedSites.length,
                              itemBuilder: (context, index) {
                                Site site = state.loading
                                    ? Site.empty()
                                    : state.suggestedSites[index];
                                return SearchAttractionSuggestion(
                                  site: site,
                                  onTap: () {
                                    cubit.onSiteTap(site);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
        });
  }
}
