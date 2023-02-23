import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../model/apidata.dart';
import '../utils/my_constant.dart';
import '../widgets/show_title.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  // from second screen
  LatLng location = LatLng(13, 101.5);
  bool mapZoom = false;
  bool isClick = false;
  MapController mapController = MapController();
  List<String> mapLayer = ['https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}', 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}'];
  List<bool> mapLayerTms = [false, false];
  int mapLayerItem = 0;
  // from third screen
  List<APIData> apiData = [];
  List allLocPoint = [];
  final List<Marker> markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    var response = await http.get(Uri.parse(MyConstant.domain));
    var jsonData = jsonDecode(response.body);

    for (var u in jsonData) {
      APIData getData = APIData(u["id"].toInt(), u["geom"], u["descriptio"], DateTime.parse(u["time"]), u["copyright"], u["province"], u["stationnam"], u["rainfall_v"].toInt(),
          u["rainfall_u"], u["temperatur"].toInt(), u["temperat_1"], u["geojson"]);
      apiData.add(getData);
    }

    for (var i = 0; i < apiData.length; i++) {
      Map<String, dynamic> map = jsonDecode(apiData[i].geojson);
      allLocPoint.add(map['coordinates']);
    }
    // return allLocPoint;
    // print(allLocPoint);

    // Timer(Duration(seconds: 1), () {
    getmarkers();
    // });
    // for (var l = 0; l < apiData.length; l++) {
    //   print(apiData[l].rainfallValue.toString());
    // }
  }

  List<Marker> getmarkers() {
    // for (var l = 0; l < apiData.length; l++) {
    //   print(apiData[l].rainfallValue.toString());
    // }
    // for (var i in apiData) {
    for (var i = 0; i < apiData.length; i++) {
      // String allLocPoints = '';
      List allLocPoints = [];
      Map<String, dynamic> map = jsonDecode(apiData[i].geojson);
      allLocPoints = map['coordinates'];
      // print(apiData[i].geojson.toString());
      // print('$i >>>>  $allLocPoints');
      // print('>>>>  $allLocPoints');

      // if (i == i.geojson) {
      // for (var x in allLocPoints) {
      // print(x);
      // print('$i >>>>  $x');
      setState(() {
        var pointMarker = LatLng(allLocPoints[1].toDouble(), allLocPoints[0].toDouble());
        markers.add(
          Marker(
            point: pointMarker,
            // builder: (context) => const Icon(Icons.location_pin, color: Colors.green),
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              tooltip: 'Temperature ${apiData[i].temperatureValue} ${apiData[i].temperatureUnit}',
              onPressed: () {
                print(i);
              },
            ),
            // builder: (context) {

            //   return popu
            // },
          ),
        );
      });
      // }
      // }
    }

    //   for (var i in allLocPoint) {
    //     print(i);
    //     setState(() {
    //       var pointMarker = LatLng(i[1].toDouble(), i[0].toDouble());
    //       //add more markers here to place on map
    //       markers.add(
    //         Marker(
    //           point: pointMarker,
    //           // builder: (context) => const Icon(Icons.location_pin, color: Colors.red),
    //           builder: (context) => IconButton(
    //             icon: const Icon(
    //               Icons.location_on,
    //               color: Colors.red,
    //             ),
    //             // tooltip: 'Increase volume by 10',
    //             tooltip: '${pointMarker.latitude}${pointMarker.longitude}',
    //             onPressed: () {
    //               print(i);
    //             },
    //           ),
    //         ),
    //       );
    //     });
    //   }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowTitle(
          title: 'Fifth Screen',
          textStyle: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          createMap(),
          baseMapSwap(),
        ],
      ),
    );
  }

  FlutterMap createMap() {
    return FlutterMap(
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
          markers: markers,
        ),
      ],
    );
  }

  Positioned baseMapSwap() {
    return Positioned(
      top: 20,
      right: 20,
      child: FloatingActionButton.small(
        heroTag: Null,
        onPressed: () {
          print('baseMapSwap click');
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
    );
  }
}
