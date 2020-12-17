import 'package:flutter/material.dart';
//import 'dart:async';

import 'package:geolocator/geolocator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

var fsConnect = FirebaseFirestore.instance;
var driverLatitude;
var driverLongitude;
void retrieveLocation() async {
  try {
    /* Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    print(position.longitude.toString() + "," + position.latitude.toString()); */

    var location = await fsConnect
        .collection('locations')
        .doc('TsCzEaOSvNzhh09kY0NX')
        .get();
    driverLatitude = location.data()['latitude'];
    driverLongitude = location.data()['longitude'];
    openMap(driverLatitude, driverLongitude);
  } catch (e) {
    print(e);
  }
}

void openMap(var driverLatitude, var driverLongitude) async {
  var url =
      'https://www.google.com/maps/search/?api=1&query=${driverLatitude},${driverLongitude}';
  print(url);
  if (await canLaunch(url))
    await launch(url);
  else
    print('sorry');
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "location Admin",
          ),
          backgroundColor: Colors.cyan,
        ),
        body: RaisedButton(
          onPressed: retrieveLocation,
          child: Text("recieve location data"),
        ),
      ),
    );
  }
}
