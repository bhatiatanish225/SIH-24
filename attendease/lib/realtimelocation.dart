import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RealTimeLocationMapWithPolyline extends StatefulWidget {
  @override
  _RealTimeLocationMapWithPolylineState createState() =>
      _RealTimeLocationMapWithPolylineState();
}

class _RealTimeLocationMapWithPolylineState
    extends State<RealTimeLocationMapWithPolyline> {
  GoogleMapController? _controller;
  Location _location = Location();
  LatLng _initialPosition = LatLng(37.7749, -122.4194); // Default to San Francisco
  List<LatLng> _polylineCoordinates = [];
  Polyline _polyline = Polyline(polylineId: PolylineId("route"));

  // Increased zoom levels
  final double _initialZoom = 50.0;
  final double _onLocationUpdateZoom = 20.0;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }
  void _initializeLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    LocationData _locationData = await _location.getLocation();
    setState(() {
      _initialPosition = LatLng(_locationData.latitude!, _locationData.longitude!);
      _polylineCoordinates.add(_initialPosition);
    });

    _location.onLocationChanged.listen((LocationData currentLocation) {
      LatLng newPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      setState(() {
        _polylineCoordinates.add(newPosition);
        _polyline = Polyline(
          polylineId: PolylineId("route"),
          points: _polylineCoordinates,
          color: Colors.blue,
          width: 5,
        );
        _controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: newPosition, zoom: _onLocationUpdateZoom),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-time Location Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: _initialZoom,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        polylines: Set<Polyline>.of([_polyline]),
      ),
    );
  }
}