import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/presentation/pages/main/activites/filter/widgets/duration_chip.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_style.dart';
import '../../../../widgets/bottom_sheet_appbar.dart';
import '../../../../widgets/custom_slider.dart';
import 'filter_cubit.dart';
import 'filter_initial_params.dart';
import 'filter_state.dart';
import 'widgets/activity_chip.dart';
import 'widgets/customer_review_chip.dart';
import 'widgets/price_chip.dart';

class FilterPage extends StatefulWidget {
  final FilterCubit cubit;

  const FilterPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterState();
}

class _FilterState extends State<FilterPage> {
  FilterCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<FilterCubit,FilterState>(
        bloc: cubit,
        builder: (context,state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BottomSheetAppbar(
                  title: "Filter",
                ),
                SizedBox(
                  height: 16.h,
                ),

                /// activities section
                Padding(
                  padding: AppConstant.bottomSheetHorizontalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activities",
                        style: AppStyle.bottomSheetHeading(context),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Wrap(
                        children: [
                          for(int index=0;index<cubit.activities.length;index++)
                          ActivityChip(
                            title: cubit.activities[index]['title'],
                            icon: cubit.activities[index]['icon'],
                            isSelected: state.selectedActivity.contains(cubit.activities[index]['title']),
                            onTap: (){
                              cubit.selectActivity(cubit.activities[index]['title']);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.h,),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                SizedBox(height: 16.h,),
                /// price section
                Padding(
                  padding: AppConstant.bottomSheetHorizontalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Range",
                        style: AppStyle.bottomSheetHeading(context),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomSlider(
                        min: state.priceMin,
                        max: state.priceMax,
                        onChange: (min,max){
                          cubit.updatePriceRange(min, max);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PriceChip(
                            title: "Min",
                            value: state.priceMin,
                          ),
                          PriceChip(
                            title: "Max",
                            value: state.priceMax,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 16.h,),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                SizedBox(height: 16.h,),


                /// duration section
                Padding(
                  padding: AppConstant.bottomSheetHorizontalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration",
                        style: AppStyle.bottomSheetHeading(context),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Wrap(
                        children: [
                          for(int index=0;index<cubit.durations.length;index++)
                            DurationChip(
                              title: cubit.durations[index],
                              isSelected: state.selectedDuration==cubit.durations[index],
                              onTap: (){
                                cubit.selectDuration(cubit.durations[index]);
                              },
                            ),
                        ],
                      )

                    ],
                  ),
                ),

                SizedBox(height: 16.h,),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                SizedBox(height: 16.h,),

                /// Customer reviews sorting
                Padding(
                  padding: AppConstant.bottomSheetHorizontalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer reviews",
                        style: AppStyle.bottomSheetHeading(context),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Wrap(
                        children: [
                          for(int index=0;index<cubit.customerReviewSorting.length;index++)
                            CustomerReviewChip(
                              title: cubit.customerReviewSorting[index],
                              isSelected: state.selectedCustomerReviewSorting==cubit.customerReviewSorting[index],
                              onTap: (){
                                cubit.selectReviewSorting(cubit.customerReviewSorting[index]);
                              },
                            ),
                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(height: 16.h,),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                SizedBox(height: 16.h,),
              ],
            ),
          );
        }
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(text: "CLEAR FILTERS", action: (){
              cubit.clearFilter();
            },isSecondaryButton: true,
            width: 167.h,
              height: 50.h,),
            CustomButton(text: "SHOW RESULTS", action: (){
              cubit.filterAction();
            },
              width: 167.h,
              height: 50.h,
            ),

          ],
        ),
      ),
    );
  }
}
