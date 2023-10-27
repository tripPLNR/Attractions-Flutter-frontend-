import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triplaner/util/app_constant.dart';

import 'custom_button.dart';

class LoadMoreButton extends StatelessWidget {
  final VoidCallback onLoadMore;
  final bool isLoading;
  final bool isEmpty;

  const LoadMoreButton({Key? key,required this.onLoadMore,required this.isLoading,required this.isEmpty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: AppConstant.screenPadding.copyWith(bottom: 20.h,top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 5.h,
              width: 100.w,
              child: Divider(height: 0,thickness: 1,color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),)),
          CustomButton(
            text: isEmpty?"REFRESH":"LOAD MORE",
            action:onLoadMore,
            isLoading: isLoading,
            width: 89.w,
            height: 32.h,
          ),
          SizedBox(
              height: 5.h,
              width: 100.w,
              child: Divider(height: 0,thickness: 1,color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),)),

        ],
      ),
    );
  }
}
