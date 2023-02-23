import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:project_template_flutter/utils/my_constant.dart';

import '../model/apidata.dart';
import '../widgets/show_title.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  Future getData() async {
    var response = await http.get(Uri.parse(MyConstant.domain));
    var jsonData = jsonDecode(response.body);
    List<APIData> apiData = [];
    for (var u in jsonData) {
      APIData getData = APIData(u["id"].toInt(), u["geom"], u["descriptio"], DateTime.parse(u["time"]), u["copyright"], u["province"], u["stationnam"], u["rainfall_v"].toInt(),
          u["rainfall_u"], u["temperatur"].toInt(), u["temperat_1"], u["geojson"]);
      apiData.add(getData);
    }
    // print(apiData.length);
    return apiData;
  }

  @override
  Widget build(BuildContext context) {
    List allLocPoint = [];
    return Scaffold(
      appBar: AppBar(
        title: ShowTitle(
          title: 'Third Screen',
          textStyle: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: const Center(
                child: Text('Loading...'),
              ),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              for (var i = 0; i < snapshot.data.length; i++) {
                Map<String, dynamic> map = jsonDecode(snapshot.data[i].geojson);
                allLocPoint.add(map['coordinates']);
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(snapshot.data[index].id.toString()),
                    title: Text('สถานี ${snapshot.data[index].stationname} จ.${snapshot.data[index].province}'),
                    subtitle: Text('พิกัด : ${allLocPoint[index].toString()}'),
                    trailing: Text('${snapshot.data[index].rainfallValue} ${snapshot.data[index].rainfallUnit}'),
                  );
                },
              );
            }
          }
          return const LinearProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(allLocPoint);
        },
        child: const Icon(Icons.outbond),
      ),
    );
  }
}
