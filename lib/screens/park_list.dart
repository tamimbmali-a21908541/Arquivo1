import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_saver/shared/config.dart';

class ParkListScreen extends StatefulWidget {
  const ParkListScreen({super.key});

  @override
  State<ParkListScreen> createState() => _ParkListScreenState();
}

class _ParkListScreenState extends State<ParkListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Parques'),
      ),
      body: const ParkList(),
    );
  }
}

class ParkList extends StatelessWidget {
  final int itemCount;
  const ParkList({
    super.key,
    this.itemCount = -1,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount == -1 ? lisbonParks.length : itemCount,
        itemBuilder: (context, index) {
          var currentPark = lisbonParks[index];
          return ListTile(
            title: Text(currentPark.name),
            subtitle: Text(
              '${currentPark.maxOccupancy - currentPark.occupancy} vagas\n${currentPark.getLastUpdatedFormatted()}',
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.push('/park-detail/${currentPark.id}');
            },
          );
        });
  }
}
