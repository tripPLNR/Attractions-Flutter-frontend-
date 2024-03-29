import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter/cupertino.dart';

class DeviceInfoService{


  Future<String> getDeviceId() async {
    String udid = await FlutterUdid.consistentUdid;
    debugPrint("Device id: $udid");
    return udid;
  }
}