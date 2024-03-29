import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:triplaner/domain/entities/site.dart';
import 'package:triplaner/util/app_style.dart';
import 'package:triplaner/util/map_sheet.dart';

import '../../../../widgets/site_detail_divider.dart';
import 'site_detail_heading.dart';

class MapWidget extends StatefulWidget {
  Site site;

  MapWidget({Key? key, required this.site}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng get productLatLng =>
      LatLng(widget.site.latitude ?? 0, widget.site.longitude ?? 0);

  @override
  Widget build(BuildContext context) {
    CameraPosition kGooglePlex = CameraPosition(
      target: productLatLng,
      // target: LatLng(33.697879,-111.8931192),
      zoom: 14.4746,
    );
    moveToLocation();
    return InkWell(
      onTap: () {
        MapsSheet.show(
          context: context,
          lat: productLatLng.latitude,
          long: productLatLng.longitude,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SiteDetailHeading(
            title:"Location",
          ),
          IgnorePointer(
            ignoring: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 178.h,
                child: GoogleMap(
                  initialCameraPosition: kGooglePlex,
                  zoomControlsEnabled: false,
                  onTap: null,
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId("123"),
                      position: productLatLng,
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "${widget.site.productAddress}",
            style: AppStyle.siteDetailSubHeading(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SiteDetailDivider(),
        ],
      ),
    );
  }

  // Method to move the camera to the specified location
  Future<void> moveToLocation() async {
    if (_controller.isCompleted) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(productLatLng),
      );
    }
  }
}
