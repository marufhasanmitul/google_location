import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationData? myLocation;

  void getLocation() async {
    myLocation = await Location.instance.getLocation();
    setState(() {});
    print(myLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("My Location"),
            Text(" ${myLocation?.latitude ?? ''} "),
            Text("${myLocation?.longitude ?? ''} "),
          ],
        ),
      ),




      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getLocation();
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
