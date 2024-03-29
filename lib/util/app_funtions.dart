
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:share_plus/share_plus.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_colors.dart';
import 'package:triplaner/util/app_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {
  /// launch url in browser
  static launchUrlInBrowser(String url) async {
    try{
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    catch(e){
      throw '${e.toString()}';
    }
  }

  void _launchMap({required double latitude,required double longitude}) async {
    // Provide latitude and longitude to open in maps
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  /// launch url in browser
  static void openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'info@tripPLNR.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Insightful input',
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
      )
  );
  }


  static String extractSiteIdFromLink(String link) {
    Uri uri = Uri.parse(link);
    String id = uri.queryParameters['site_id'] ?? '';
    return id;
  }

  static shareSite(Site site) {
      Share.share('Checkout this exciting attraction on tripplnr.\n\nhttps://tripplnr.com/site?site_id=${site.id}');
  }

  static customImageProvider(String? imgUrl){
    return CachedNetworkImageProvider(
        (imgUrl??"").isEmpty?AppConstant.placeHolderImage:imgUrl!,
        errorListener: (val){
          debugPrint("ERROR WHILE READING IMAGE : $val");
        }
    );
  }


}