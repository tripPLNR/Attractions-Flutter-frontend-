import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/presentation/widgets/site/site_tile.dart';
import 'package:triplaner/util/app_constant.dart';

class WishListShimmer extends StatelessWidget {
  const WishListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 20,
        padding: AppConstant.screenPadding.copyWith(top: 20.h),
        itemBuilder: (context, index) {
          return SiteTile(site: Site.empty());
        },
      ),
    );
  }
}
