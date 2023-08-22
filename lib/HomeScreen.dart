import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gooogle Location")
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(25.740580, 89.261140),
            zoom: 11.0

        ),

      ),
    );
  }
}
