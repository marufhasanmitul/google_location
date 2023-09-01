import 'dart:async';

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
  late StreamSubscription _streamSubscription;

  void getLocation() async {
    await Location.instance.requestPermission(); //User getLocation Permission
    await Location.instance.hasPermission().then((permissionStatus) {
      print(permissionStatus);
    });
    myLocation = await Location.instance.getLocation();
    if(mounted){
      setState(() {});
    }


    print(myLocation);
  }

  void listenToMyLocation(){
    _streamSubscription=Location.instance.onLocationChanged.listen((location) {
      myLocation=location;

      if(mounted){
        setState(() {});
      }

      print(myLocation);
    });
  }

  void stopToListenLocation(){
    _streamSubscription.cancel();
    if(mounted){
      setState(() {});
    }
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              stopToListenLocation();
            },
            child: Icon(Icons.stop),
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: () {
              listenToMyLocation();
            },
            child: Icon(Icons.start_rounded),
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: () {
              getLocation();
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
