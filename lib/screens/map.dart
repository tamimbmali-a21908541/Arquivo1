import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot_saver/shared/config.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
            tag: 'map',
            child: Center(
              child: Stack(
                children: [
                  GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(38.7440722, -9.2009352),
                        zoom: 12,
                      ),
                      markers: lisbonParks
                          .map((e) => Marker(
                              markerId: MarkerId(e.id.toString()),
                              position: e.location))
                          .toSet()),
                  Positioned(
                    top: AppBar().preferredSize.height + 10,
                    left: MediaQuery.of(context).size.width * 0.01,
                    child: IconButton.filled(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                ],
              ),
            )));
  }
}
