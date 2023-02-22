import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/show_title.dart';
// import 'package:latlong2/latlong.dart' as latLng;

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  LatLng location = LatLng(13, 101.5);
  bool mapZoom = false;
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowTitle(
          title: 'Second Screen',
          textStyle: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: location,
          zoom: 6,
          maxZoom: 20,
        ),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            tms: false, // tms = Tile Map Service
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: location,
                builder: (context) => const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('click');
          mapZoom = !mapZoom;
          if (mapZoom) {
            setState(() {
              mapController.move(location, 18.0);
            });
          } else {
            setState(() {
              mapController.move(location, 6.0);
            });
          }
        },
        child: Transform.rotate(
          angle: 0.7, // Unit in pi
          child: const Icon(Icons.navigation),
        ),
      ),
    );
  }
}
