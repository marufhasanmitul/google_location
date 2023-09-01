import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapLocationScreen extends StatefulWidget {
  const MapLocationScreen({Key? key}) : super(key: key);

  @override
  State<MapLocationScreen> createState() => _MapLocationScreenState();
}

class _MapLocationScreenState extends State<MapLocationScreen> {
  LocationData? myLocation;
  double myLatitude=44.500000;
  double myLongitude=-89.500000;




  @override
  void initState() {
    super.initState();
    getLocation();
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map And Location'),
      ),
      body:GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(myLocation?.latitude?? myLatitude,myLocation?.longitude?? myLongitude),
          zoom: 15.0,
          bearing: 10,
          tilt: 10
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        trafficEnabled: false,
        markers: <Marker>{
          Marker(
              markerId: const MarkerId('custom-marker'),
              position:  LatLng(myLocation?.latitude?? myLatitude,myLocation?.longitude?? myLongitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              infoWindow: const InfoWindow(title: 'My current Location'),
              draggable: true,
              onDragStart: (LatLng lat){
                print(lat);
              }
          )
        },
      ) ,
    );
  }
}
