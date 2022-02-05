import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_find_locations/model/place.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DetailPage extends StatefulWidget {

  final Place place;

  DetailPage({Key? key, required this.place}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(double.parse(widget.place.lat), double.parse(widget.place.lng)),
            zoom: 13
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return Text("© OpenStreetMap contributors");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(double.parse(widget.place.lat), double.parse(widget.place.lng)),
                  builder: (ctx) =>
                      Container(
                        child: Icon(Icons.location_on),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
