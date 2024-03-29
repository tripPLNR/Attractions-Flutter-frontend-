import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:triplaner/presentation/widgets/custom_blur_background.dart';
import 'package:triplaner/presentation/widgets/custom_button.dart';
import 'package:triplaner/util/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsSheet {
  static void show({
    required BuildContext context,
    required double lat,
    required double long,
  }) async {
  //  final availableMaps = await MapLauncher.installedMaps;

    if (!context.mounted) return;

    showCupertinoModalPopup(
      context: context,
      //isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: CupertinoActionSheet(
              title: const Text('Open in'),
              cancelButton: CupertinoActionSheetAction(
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                mapTile(title: "Google Maps", context: context,onTap: (){
                  _launchGoogleMaps(lat, long);
                }),
                Platform.isAndroid?const SizedBox():mapTile(title: "Apple Maps", context: context,onTap: (){
                  _launchAppleMaps(lat, long);
                }),
                mapTile(title: "Waze", context: context,onTap:(){
                _launchWaze(lat, long);
                }),
              ]),
        );
      },
    );
  }

  static CupertinoActionSheetAction mapTile(
      {required String title,
      required BuildContext context,
      required VoidCallback onTap}) {
    return CupertinoActionSheetAction(
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
        ));
  }

  // Function to launch Apple Maps with specific coordinates
  static _launchAppleMaps(double latitude, double longitude) async {
    String url = 'https://maps.apple.com/?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to launch Google Maps with specific coordinates
  static _launchGoogleMaps(double latitude, double longitude) async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to launch Waze with specific coordinates
  static _launchWaze(double latitude, double longitude) async {
    String url = 'https://waze.com/ul?ll=$latitude,$longitude&navigate=yes';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
