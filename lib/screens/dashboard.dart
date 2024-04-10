import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot_saver/screens/park_list.dart';
import 'package:spot_saver/shared/config.dart';
import 'package:spot_saver/shared/google_map_preview.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Spot Saver'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: GoogleMapPreview(
                cameraPosition: CameraPosition(
                  target: LatLng(
                      lisbonParks.map((e) => e.location.latitude).fold(
                              0.0,
                              (previousValue, element) =>
                                  previousValue + element) /
                          lisbonParks.length,
                      lisbonParks.map((e) => e.location.longitude).fold(
                              0.0,
                              (previousValue, element) =>
                                  previousValue + element) /
                          lisbonParks.length),
                  zoom: 12,
                ),
                markers: lisbonParks
                    .map((e) => Marker(
                        markerId: MarkerId(e.id.toString()),
                        position: e.location))
                    .toSet(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Lista de parques",
                        style: TextStyle(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push('/park-list');
                        },
                        child: const Row(
                          children: [
                            Text("Ver todos"),
                            Icon(Icons.arrow_right)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const ParkList(
                      itemCount: 4,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
