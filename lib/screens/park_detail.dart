import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot_saver/shared/config.dart';
import 'package:spot_saver/shared/google_map_preview.dart';

class ParkDetail extends StatelessWidget {
  final int id;
  const ParkDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var park = lisbonParks.firstWhere((element) => element.id == id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                park.name,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                'Ocupação: ${park.occupancy}/${park.maxOccupancy} (${park.occupancyPercentage()}%)',
                style: const TextStyle(fontSize: 18),
              ),
              Text(park.extraInfo),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.03),
                child: GoogleMapPreview(
                  markers: {
                    Marker(
                        markerId: MarkerId(park.id.toString()),
                        position: park.location)
                  },
                  cameraPosition:
                      CameraPosition(target: park.location, zoom: 16),
                ),
              ),
              const Text(
                "Incidentes",
                style: TextStyle(fontSize: 20),
              ),
              if (park.incidents.isEmpty) const Text("Sem incidentes"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                    itemCount: park.incidents.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(park.incidents[index].description),
                        subtitle:
                            Text(park.incidents[index].getFormattedDate()),
                        trailing: Text(
                            "Severidade ${park.incidents[index].getSeverity()}"),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-incident/$id');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
