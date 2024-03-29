class BookingResponse {
  bool? isBookingAvailable;
  String? redirectUrl;

  BookingResponse({this.isBookingAvailable, this.redirectUrl});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    isBookingAvailable = json['isBookingAvailable'];
    redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isBookingAvailable'] = this.isBookingAvailable;
    data['redirectUrl'] = this.redirectUrl;
    return data;
  }
  BookingResponse.empty(){
    isBookingAvailable=false;
    redirectUrl=null;
  }
}
