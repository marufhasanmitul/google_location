import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GoogleMapController _googleMapController;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Location")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(25.740580, 89.261140),
            zoom: 15.0,
            bearing: 10,
            tilt: 10),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        trafficEnabled: false,

        onMapCreated: (GoogleMapController controller){
            print('On Map Created');
            _googleMapController=controller;
        },//when create Map call this Function Like zoom in zoom out Move


        compassEnabled: true,

        onTap: (LatLng l){
          print(l);

        },//Map tab information get like LatLng


        onLongPress: (LatLng l){
          print(l);
        },//Map LongPress information get like LatLng


        mapType: MapType.normal,


        // Add Marker

        markers: <Marker>{
            Marker(
              markerId: const MarkerId('custom-marker'),
              position: const LatLng(25.740457517166053,89.26102057099343),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              infoWindow: const InfoWindow(title: 'Bazar'),
              draggable: true,
              onDragStart: (LatLng lat){
                print(lat);
              }

          ),

            Marker(
              markerId: const MarkerId('custom-marker2'),
              position: const LatLng(25.740666505737824, 89.26811769604683),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
              infoWindow: const InfoWindow(title: 'Bazar'),
              draggable: true,
              onDragStart: (LatLng lat){
                print(lat);
              }

          ),




        },

        polylines: <Polyline>{
            Polyline(
              polylineId: PolylineId('PoliLine-id'),

              points: [
                LatLng(25.740457517166053,89.26102057099343),
                LatLng(25.740666505737824, 89.26811769604683)
              ],

              color: Colors.pink,

              width: 10,

              jointType: JointType.round,

              onTap: (){
                print("Taped");
              }



          ),

          
        },

        circles: <Circle>{
          Circle(
            circleId: CircleId('circle'),
            center: LatLng(25.740457517166053,89.26102057099343),
            strokeColor: Colors.purple,
            strokeWidth: 4,
            radius:200,
            fillColor: Colors.purple.shade100
          ),
          Circle(
              circleId: CircleId('circle2'),
              center:  LatLng(25.740666505737824, 89.26811769604683),
              strokeColor: Colors.purple,
              strokeWidth: 4,
              radius:200,
              fillColor: Colors.purple.shade100
          ),
        },







      ),
    );
  }
}
