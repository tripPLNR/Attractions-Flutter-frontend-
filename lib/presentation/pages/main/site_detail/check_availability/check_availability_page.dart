import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/pages/main/site_detail/check_availability/widget/increment_decrement_widget.dart';
import 'package:triplaner/presentation/widgets/bottom_sheet_appbar.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/presentation/widgets/custom_horizontal_date_picker.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_style.dart';
import 'check_availability_cubit.dart';
import 'check_availability_initial_params.dart';
import 'check_availability_state.dart';
import 'widget/time_chip.dart';

class CheckAvailabilityPage extends StatefulWidget {
  final CheckAvailabilityCubit cubit;

  const CheckAvailabilityPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CheckAvailabilityPage> createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailabilityPage> {
  CheckAvailabilityCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CheckAvailabilityCubit,CheckAvailabilityState>(
        bloc: cubit,
        builder: (context,state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BottomSheetAppbar(
                title: "Check Availability",
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: AppConstant.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Date",style: AppStyle.bottomSheetSubHeading(context),),
                    SizedBox(
                      height: 18.h,
                    ),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(AppAssets.selectDate,height: 40.h,width: 40.h,),
                    //     SizedBox(width: 10.w,),
                    //     Expanded(child: CustomHorizontalDatePicker(
                    //       onDateSelect: (date){
                    //         debugPrint(date.toString());
                    //       },
                    //     )),
                    //   ],
                    // ),
                    SizedBox(
                      height: 17.h,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text("Select Time",style: AppStyle.bottomSheetSubHeading(context),),
                    SizedBox(
                      height: 18.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeChip(
                          title: "Morning",
                          subTitle: "6 AM - 12 PM",
                          isSelected: false,
                        ),
                        TimeChip(
                          title: "Afternoon",
                          subTitle: "12PM - 5 PM",
                          isSelected: true,
                        ),
                        TimeChip(
                          title: "Evening",
                          subTitle: "5 PM - 12 AM",
                          isSelected: false,
                        ),


                      ],
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text("Select Guests",style: AppStyle.bottomSheetSubHeading(context),),
                    SizedBox(
                      height: 18.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Adults",style: AppStyle.bottomSheetSubHeading(context),),
                        IncrementDecrementWidget(
                          onDecrement: cubit.onAdultDecrement,
                          onIncrement: cubit.onAdultIncrement,
                          value: state.adultCount,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Children",style: AppStyle.bottomSheetSubHeading(context),),
                        IncrementDecrementWidget(
                          onDecrement:cubit.onChildrenDecrement,
                          onIncrement: cubit.onChildrenIncrement,
                          value: state.childrenCount,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text("Available Options (0)",style: AppStyle.bottomSheetSubHeading(context),),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
              )
            ],
          );
        }
      ),
      bottomNavigationBar: Container(
        padding: AppConstant.screenPadding.copyWith(bottom: 10.h),
        child: CustomButton(
          text: "Back", action: (){
            Navigator.pop(context);
        },
        ),
      ),
    );
  }
}
