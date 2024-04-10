import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPreview extends StatelessWidget {
  final CameraPosition cameraPosition;
  final Set<Marker> markers;
  const GoogleMapPreview(
      {super.key,
      this.markers = const <Marker>{},
      this.cameraPosition = const CameraPosition(
        target: LatLng(38.7440722, -9.2009352),
        zoom: 12,
      )});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Hero(
        tag: 'map',
        child: GoogleMap(
          markers: markers,
          onTap: (LatLng latLng) {
            context.push('/map');
          },
          initialCameraPosition: cameraPosition,
          compassEnabled: false,
          trafficEnabled: false,
          liteModeEnabled: false,
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          fortyFiveDegreeImageryEnabled: false,
          myLocationButtonEnabled: false, // Remove location button
        ),
      ),
    );
  }
}
