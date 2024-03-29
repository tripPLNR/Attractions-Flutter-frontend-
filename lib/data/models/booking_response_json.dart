import 'package:triplaner/domain/entities/booking_response.dart';

class BookingResponseJson {
  bool? isAvailable;
  String? redirectUrl;

  BookingResponseJson({this.isAvailable, this.redirectUrl});

  BookingResponseJson.fromJson(Map<String, dynamic> json) {
    isAvailable = json['isAvailable'];
    redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAvailable'] = this.isAvailable;
    data['redirectUrl'] = this.redirectUrl;
    return data;
  }
  BookingResponse toDomain(){
    return BookingResponse(
      isBookingAvailable: isAvailable??false,
      redirectUrl: redirectUrl??"https://tripplnr.com/"
    );
  }
}
