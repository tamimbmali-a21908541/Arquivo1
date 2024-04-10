import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot_saver/models/incident.dart';
import 'package:intl/intl.dart';

class Park {
  final String name;
  int occupancy;
  final int maxOccupancy;
  final String extraInfo;
  List<Incident> incidents;
  DateTime lastUpdated;
  final LatLng location;
  final int id;

  double occupancyPercentage() {
    return (occupancy / maxOccupancy) * 100;
  }

  Park({
    required this.name,
    required this.occupancy,
    required this.maxOccupancy,
    required this.extraInfo,
    required this.incidents,
    required this.lastUpdated,
    required this.location,
    required this.id,
  });

  void updateOccupancy(int newOccupancy) {
    occupancy = newOccupancy;
    lastUpdated = DateTime.now();
  }

  void addIncident(Incident incident) {
    incidents.add(incident);
    lastUpdated = DateTime.now();
  }

  String getLastUpdatedFormatted() {
    return DateFormat("dd/MM/yyyy HH:mm").format(lastUpdated);
  }
}
