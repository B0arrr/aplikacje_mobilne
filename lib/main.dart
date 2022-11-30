// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'Data.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);

class _MyAppState extends State<MyApp> {
  var markers = <Marker>[];

  StreamSubscription<Position> positionStream = Geolocator
      .getPositionStream(locationSettings: locationSettings)
      .listen((Position? position) {

      });

  Future<void> fetchData() async {
    var response =
        await http.get(Uri.parse("http://10.0.2.2:5041/getwaypoints"));
    var data = Data.fromJson(jsonDecode(response.body));
    for (var waypoint in data.waypoints) {
      var point = LatLng(waypoint.lat, waypoint.long);
      markers.add(Marker(
        width: 80,
        height: 80,
        point: point,
        builder: (ctx) => Container(
          key: const Key('blue'),
          child: const FlutterLogo(),
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                      center: LatLng(49.817023276272735, 19.01334924059628),
                      zoom: 18),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(markers: markers),
                    CurrentLocationLayer()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
