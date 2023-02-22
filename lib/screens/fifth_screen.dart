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
  LatLng location = LatLng(13, 101.5);
  // LatLng location2 = LatLng(13.5, 101.5);
  bool mapZoom = false;
  MapController mapController = MapController();
  // List<Marker> ssss = [];
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
    getmarkers();
  }

  List<Marker> getmarkers() {
    for (var i in allLocPoint) {
      setState(() {
        var pointMarker = LatLng(i[1].toDouble(), i[0].toDouble());
        //markers to place on map
        markers.add(
          Marker(
            point: pointMarker,
            builder: (context) => const Icon(Icons.location_pin, color: Colors.red),
          ),
        ); //add more markers here
      });
    }
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
            markers: markers,
            // Marker(
            //   point: location,
            //   builder: (context) => const Icon(
            //     Icons.location_pin,
            //     color: Colors.red,
            //   ),
            // ),
            // Marker(
            //   point: LatLng(6.65, 100.083333),
            //   builder: (context) => const Icon(
            //     Icons.location_pin,
            //     color: Colors.green,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
