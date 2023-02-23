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
  bool isClick = false;
  MapController mapController = MapController();
  List<String> mapLayer = ['https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}', 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}'];
  List<bool> mapLayerTms = [false, false];
  int mapLayerItem = 0;

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
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: location,
              zoom: 6,
              maxZoom: 20,
            ),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate: mapLayer[mapLayerItem],
                tms: mapLayerTms[mapLayerItem], // tms = Tile Map Service
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(13, 101.5),
                    builder: (context) => const Icon(
                      Icons.location_pin,
                      color: Colors.green,
                    ),
                  ),
                  // Marker(
                  //   point: LatLng(6.65, 100.083333),
                  //   builder: (context) => const Icon(
                  //     Icons.location_pin,
                  //     color: Colors.green,
                  //   ),
                  // ),
                  // Marker(
                  //   point: location,
                  //   builder: (context) => const Icon(
                  //     Icons.location_pin,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 20,
            child: FloatingActionButton.small(
              heroTag: Null,
              onPressed: () {
                print('click');
                isClick = !isClick;
                isClick
                    ? setState(() {
                        mapLayerItem = 1;
                      })
                    : setState(() {
                        mapLayerItem = 0;
                      });
              },
              child: const Icon(Icons.layers_rounded),
            ),
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
