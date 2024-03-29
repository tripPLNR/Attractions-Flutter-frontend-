import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SiteDetailMenu extends StatelessWidget {
  final List<String> menus;
  final int selectedIndex;
  final Function(int,String) onTap;

  const SiteDetailMenu({Key? key,required this.menus,required this.selectedIndex,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1,height: 0,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              children: [
                for(int index=0;index<menus.length;index++)
                  InkWell(
                      onTap: (){
                        onTap(index,menus[index]);
                      },
                      child: Column(
                        children: [
                          title(title: menus[index],isSelected: selectedIndex==index,context: context),
                          SizedBox(
                            width: 80.w,
                            child: Divider(
                              thickness: selectedIndex == index ? 2 : 0,
                              height: 0,
                              color: selectedIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ],
                      )),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        )
      ],
    );
  }

  Widget title({required String title,required bool isSelected,required BuildContext context}){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 11.h,horizontal: 8.w),
          child: Text(title,style: TextStyle(
            fontSize: 17.sp,
            color: isSelected?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w600,

          ),),
        ),
      ],
    );
  }
}
