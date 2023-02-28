import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:project_template_flutter/utils/my_dialog.dart';

import '../model/apidata.dart';
import '../model/marker_popup.dart';
import '../utils/my_constant.dart';
import '../widgets/show_title.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
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
  // add in fourth screen
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
      // defined u["..."] follow your api field
      APIData getData = APIData(u["id"].toInt(), u["geom"], u["descriptio"], DateTime.parse(u["time"]), u["copyright"], u["province"], u["stationnam"], u["rainfall_v"].toInt(),
          u["rainfall_u"], u["temperatur"].toInt(), u["temperat_1"], u["geojson"]);
      apiData.add(getData);
    }

    for (var i = 0; i < apiData.length; i++) {
      Map<String, dynamic> map = jsonDecode(apiData[i].geojson);
      allLocPoint.add(map['coordinates']);
    }

    Timer(const Duration(seconds: 1), () {
      getmarkers();
    });
  }

  List<Marker> getmarkers() {
    for (var i = 0; i < apiData.length; i++) {
      List allLocPoints = [];
      Map<String, dynamic> map = jsonDecode(apiData[i].geojson);
      allLocPoints = map['coordinates'];

      setState(
        () {
          var pointMarker = LatLng(allLocPoints[1].toDouble(), allLocPoints[0].toDouble());
          markers.add(
            Marker(
              point: pointMarker,
              builder: (context) => const Icon(Icons.location_pin, color: Colors.green),
            ),
          );
        },
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowTitle(
          title: 'Fourth Screen',
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
              TileLayer(
                wmsOptions: WMSTileLayerOptions(
                  baseUrl:
                      'https://gistdaportal.gistda.or.th/data/rest/services/GFlood/GFlood_Inno_WMS_FloodArea/MapServer/export?dpi=96&transparent=true&format=png32&bboxSR=102100&imageSR=102100&f=image&layers=0',
                ),
                minZoom: 6,
                opacity: 0.5,
                backgroundColor: Colors.transparent,
              ),
              MarkerLayer(
                markers: markers,
              ),
            ],
          ),
          Positioned(
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          setState(() {
            mapController.move(location, 6.0);
          });
        },
        child: Icon(
          Icons.refresh,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
