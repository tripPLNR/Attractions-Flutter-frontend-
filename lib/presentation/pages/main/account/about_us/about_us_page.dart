import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triplaner/presentation/widgets/custom_appbar.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/util/app_theme.dart';
import 'about_us_cubit.dart';
import 'about_us_initial_params.dart';
import 'about_us_state.dart';

class AboutUsPage extends StatefulWidget {
  final AboutUsCubit cubit;

  const AboutUsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUsPage> {
  AboutUsCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "About Us",
        radius: BorderRadius.zero,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppAssets.aboutUsHeader),
            Padding(
              padding: AppConstant.screenPadding.copyWith(top: 20.h),
              child: Column(
                children: [
                  Text(
                    "Welcome to tripPLNR your premier resource for exploring the world's most captivating attractions and destinations. We are deeply committed to helping discerning travellers make well-informed decisions and crafting memorable experiences. ",
                    style: AppStyle.aboutUsTextStyle(context),
                    textAlign: TextAlign.center,
                  ),
                  SvgPicture.asset(AppAssets.ourMission),
                  Text(
                    "Our Mission",
                    style:
                        TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold,
                        fontFamily: AppTheme.montserratAlternates,
                        ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "At tripPLNR our mission is to empower travellers with the essential information to plan their dream adventures. We believe each journey should be characterised by discovery, wonder and joy. Whether you are a seasoned globetrotter or embarking on your inaugural expedition, we stand ready to serve as your steadfast companion on your voyage of exploration.",
                    style: AppStyle.aboutUsTextStyle(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "For inquiries, please reach out to us at:",
                    style: AppStyle.aboutUsTextStyle(context),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: (){
                      AppFunctions.openEmail();
                    },
                    child: Text(
                      "info@tripPLNR.com:",
                      style: AppStyle.aboutUsTextStyle(context).copyWith(
                        letterSpacing: 0,
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
