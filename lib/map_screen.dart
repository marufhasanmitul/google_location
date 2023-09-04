import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  Location _location = Location();
  List<LatLng> _polylinePoints = [];
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _currentLocation = locationData;
        _polylinePoints.add(LatLng(locationData?.latitude?? 0.00, locationData?.longitude?? 0.00));
        _updateMarkers();
      });
    });

    _initCurrentLocation();
  }

  void _initCurrentLocation() async {
    try {
      final LocationData locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
      _updateMarkers();
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locationData?.latitude?? 0.00, locationData?.longitude?? 0.00),
            zoom: 15.0,
          ),
        ),
      );
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  void _updateMarkers() {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId("currentLocation"),
        position: LatLng(_currentLocation?.latitude?? 0.00, _currentLocation?.longitude?? 0.00),
        onTap: () {
          _showInfoWindow();
        },
      ),
    );
  }

  void _showInfoWindow() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My current location",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text("Latitude: ${_currentLocation?.latitude?.toStringAsFixed(6)}"),
              Text("Longitude: ${_currentLocation?.longitude?.toStringAsFixed(6)}"),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map App"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(0.0, 0.0),
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _markers,
            polylines: {
              Polyline(
                polylineId: PolylineId("route"),
                points: _polylinePoints,
                color: Colors.blue,
                width: 5,
              ),
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                _mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(_currentLocation?.latitude?? 0.00, _currentLocation?.longitude?? 0.00),
                      zoom: 15.0,
                    ),
                  ),
                );
              },
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}