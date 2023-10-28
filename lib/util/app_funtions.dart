
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:triplaner/util/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {
  /// launch url in browser
  static launchUrlInBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch $url');
    }
  }


  /// launch url in browser
  static void openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'lookouthelp@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Lookout Help',
      }),
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch $emailUri';
    }
  }


  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }


  static Future<String> convertFileToBase64(File file) async {
    Uint8List docImageBytes = await file.readAsBytes();
    String base64Image = base64.encode(docImageBytes);
    return base64Image;
  }

  static transparentStatusBar({bool blackText=false}) async {
  SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: blackText?Brightness.dark:Brightness.light
        //color set to transperent or set your own color
      )
  );
  }




// static primaryStatusBar() async {
  //   await FlutterStatusbarcolor.setStatusBarColor(AppColors.primaryColor);
  //   await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  // }
}