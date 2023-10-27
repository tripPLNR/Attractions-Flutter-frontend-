import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FormatDate on DateTime{

  toDateTime(){
    return DateFormat('dd-MM-yyyy hh:mm a').format(this);
  }
  toTime(){
    return DateFormat('hh:mm a').format(this);
  }
  toDate(){
    return DateFormat('hh:mm a').format(this);
  }
  toDayNameAndDate(){
    final formatter = DateFormat('EEEE, dd MMM yyyy');
    final formattedDate = formatter.format(this);
    return formattedDate;
  }

}


extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}



extension FormatStringToDate on String{

  formatToDateTime(){
    return DateFormat('yyyy MM-dd').parse(this);
  }

  String toCamelCase(){
    if(this=="Other"){
      return "otherText";
    }
    List<String> words = toLowerCase().split(" ");
    String camelCase=words[0] + words.sublist(1).map((word) => word[0].toUpperCase() + word.substring(1)).join("").trim();
    return camelCase;
  }
}



extension TimeAgo on String {
  String timeAgo() {
    DateTime now = DateTime.now();
    DateTime time = DateTime.parse(this);

    Duration difference = now.difference(time);

    if (difference.inDays >= 365) {
      int years = difference.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      int months = difference.inDays ~/ 30;
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 7) {
      int weeks = difference.inDays ~/ 7;
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}



extension ImageUrlExtension on Map<String, dynamic> {
  String getImageUrl({int? width,int? height}) {
    width=width??674;
    height=height??446;
    final variants = this['variants'] as List<dynamic>;
    for (var variant in variants) {
      final variantWidth = variant['width'] as int;
      final variantHeight = variant['height'] as int;
      if (variantWidth == width && variantHeight == height) {
        return variant['url'] as String;
      }
    }
    return ''; // Return an empty string if no match is found.
  }
}
