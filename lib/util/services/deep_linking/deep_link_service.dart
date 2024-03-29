import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/domain/repositories/database_repository.dart';
import 'package:triplaner/util/app_funtions.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkService {
  DatabaseRepository databaseRepository;

  DeepLinkService({required this.databaseRepository});

  static String url = "";
  StreamSubscription? _sub;

  static Future<void> initialize() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      debugPrint("INITIAL LINK============> $initialLink");
      if (initialLink != null) {
        url = initialLink;
      }
    } on PlatformException catch (e) {
      print("ERROR: ${e.toString()}");
    }
  }

  Future<void> startListening(
      {required Function onStart,
      required Function(Site) onEnd,
      required Function(String) onError}) async {
    /// if app is in foreground and user tap on deep link
    _sub = linkStream.listen((String? link) async {
      if (link != null) {
        String siteId = AppFunctions.extractSiteIdFromLink(link);
        if (siteId.isNotEmpty) {
          try {
            onStart();
            Site site = await databaseRepository.getSiteById(id: siteId);
            onEnd(site);
          }catch(e){
            onError(e.toString());
          }
        }
      }
    }, onError: (err) {
      debugPrint("======> error while listening ${err.toString()}");
      onError(err);
    });

    /// if app was in terminated state and opened by deep link
    if (DeepLinkService.url.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 1500));
      String siteId = AppFunctions.extractSiteIdFromLink(DeepLinkService.url);
      DeepLinkService.url="";
      if (siteId.isNotEmpty) {
        try {
          onStart();
          Site site = await databaseRepository.getSiteById(id: siteId);
          onEnd(site);
        }catch(e){
          onError(e.toString());
        }
      }
    }
  }

  stopDeepLinkService() {
    _sub?.cancel();
  }
}
