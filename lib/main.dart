import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_saver/screens/add_incident.dart';
import 'package:spot_saver/screens/dashboard.dart';
import 'package:spot_saver/screens/map.dart';
import 'package:spot_saver/screens/park_detail.dart';
import 'package:spot_saver/screens/park_list.dart';

void main() {
  runApp(const AppStart());
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Spot Saver',
        routerConfig: GoRouter(
          initialLocation: '/dashboard',
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const Dashboard(),
            ),
            GoRoute(
              path: '/map',
              builder: (context, state) => const MapScreen(),
            ),
            GoRoute(
              path: '/park-list',
              builder: (context, state) => const ParkListScreen(),
            ),
            GoRoute(
              path: '/park-detail/:id',
              builder: (context, state) => ParkDetail(
                id: int.parse(state.pathParameters['id']!),
              ),
            ),
            GoRoute(
              path: '/add-incident/:id',
              builder: (context, state) => AddIncident(
                id: int.parse(state.pathParameters['id']!),
              ),
            ),
          ],
        ),
        theme: ThemeData(colorSchemeSeed: Colors.blue));
  }
}
