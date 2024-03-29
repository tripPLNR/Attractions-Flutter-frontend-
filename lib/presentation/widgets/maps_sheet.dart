// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'custom_blur_background.dart';
//
// class MapsSheet extends StatelessWidget {
//   const MapsSheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: CustomBlurBackground(
//         child: Padding(
//           padding:  EdgeInsets.only(top: 20.h),
//           child: Column(
//             children: <Widget>[
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ListTile(
//                         onTap: () => onMapTap(map),
//                         title: Text(map.mapName,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold
//                           ),
//                         ),
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(100.r),
//                           child: SvgPicture.asset(
//                             map.icon,
//                             height: 30.0,
//                             width: 30.0,
//                           ),
//                         ),
//                       ),
//                       Divider(
//                         thickness: 1,
//                         height: 1,
//                         color: Theme.of(context).colorScheme.secondary,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
