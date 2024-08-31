import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding; // Import geocoding package
import './utils.dart';

class LandingPage1 extends StatefulWidget {
  const LandingPage1({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage1> {
  bool isCheckedIn = false;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  Duration todayWorkDuration = Duration.zero;
  Duration weekWorkDuration = Duration.zero;
  String? currentOfficeLocation;

  // Variables for live location tracking
  GoogleMapController? _mapController;
  Location _location = Location();
  LatLng _currentPosition = LatLng(0, 0);
  LatLng _officeLocation = LatLng(37.7749, -122.4194); // Example office location
  List<LatLng> _polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _polylineCoordinates.add(_currentPosition);
          _updatePolylines();
          _updateMarkers();
          _checkProximityToOffice();
        });

        _mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition, zoom: 15.0),
        ));

        _getAddressFromLatLng(currentLocation.latitude!, currentLocation.longitude!);
      }
    });
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      currentOfficeLocation = await getAddressFromLatLng(latitude, longitude);

      setState(() {});
    } catch (e) {
      print(e); // Handle the error appropriately
    }
  }

  void _updatePolylines() {
    _polylines.clear();
    _polylines.add(Polyline(
      polylineId: PolylineId("route"),
      points: _polylineCoordinates,
      color: const Color.fromARGB(255, 247, 97, 3),
      width: 5,
    ));
  }

  void _updateMarkers() {
    _markers.clear();
    _markers.add(Marker(
      markerId: MarkerId("current_location"),
      position: _currentPosition,
      infoWindow: InfoWindow(title: "Current Location"),
    ));
    _markers.add(Marker(
      markerId: MarkerId("office_location"),
      position: _officeLocation,
      infoWindow: InfoWindow(title: "Office"),
    ));
  }

  void _checkProximityToOffice() {
    double distanceInMeters = calculateDistance(
      _currentPosition.latitude,
      _currentPosition.longitude,
      _officeLocation.latitude,
      _officeLocation.longitude,
    );

    if (distanceInMeters <= 200 && !isCheckedIn) {
      _checkIn();
    }
  }

  void _checkIn() {
    setState(() {
      isCheckedIn = true;
      checkInTime = DateTime.now();
      checkOutTime = null;
      currentOfficeLocation = "Checked in at ${_currentPosition.latitude.toStringAsFixed(4)}, ${_currentPosition.longitude.toStringAsFixed(4)}";
    });
    _showSnackBar('Checked in at $currentOfficeLocation');
  }

  void _checkOut() {
    if (isCheckedIn && checkInTime != null) {
      setState(() {
        isCheckedIn = false;
        checkOutTime = DateTime.now();
        Duration workDuration = checkOutTime!.difference(checkInTime!);
        todayWorkDuration += workDuration;
        weekWorkDuration += workDuration;
        currentOfficeLocation = null;
      });
      
           _showSnackBar('Checked out successfully');
    } else {
      _showSnackBar('You need to check in first');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}h ${twoDigitMinutes}m";
  }

  void _setLocationFromMap() async {
    final LatLng? selectedLocation = await _showLocationPicker();
    if (selectedLocation != null) {
      setState(() {
        _officeLocation = selectedLocation;
        _updateMarkers();
      });
    }
  }

  Future<LatLng?> _showLocationPicker() async {
    LatLng? selectedLocation;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick Location'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: double.maxFinite,
                height: 400,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 14.0,
                  ),
                  onTap: (LatLng position) {
                    selectedLocation = position;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {
                    if (selectedLocation != null)
                      Marker(
                        markerId: MarkerId("picked_location"),
                        position: selectedLocation!,
                        infoWindow: InfoWindow(title: "Picked Location"),
                      ),
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Confirm'),
              onPressed: () => Navigator.of(context).pop(selectedLocation),
            
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
    return selectedLocation;
  }

  void _setLocationManually() async {
    String locationText = _locationController.text;
    if (locationText.isNotEmpty) {
      try {
        List<geocoding.Location> locations = await geocoding.locationFromAddress(locationText);
        if (locations.isNotEmpty) {
          setState(() {
            _officeLocation = LatLng(locations.first.latitude, locations.first.longitude);
            _updateMarkers();
          });
        } else {
          _showSnackBar('Location not found');
        }
      } catch (e) {
        _showSnackBar('Error finding location');
      }
    } else {
      _showSnackBar('Please enter a location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _showSnackBar('Profile feature coming soon');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMapCard(),
              const SizedBox(height: 16),
              _buildStatusCard(),
              const SizedBox(height: 16),
              _buildLocationCard(),
              const SizedBox(height: 16),
              _buildQuickActionsCard(),
              const SizedBox(height: 16),
              _buildWorkingHoursCard(),
              const SizedBox(height: 16),
              _buildSetLocationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapCard() {
    return Card(
      child: SizedBox(
        height: 300,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 14.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          polylines: _polylines,
          markers: _markers,
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Current Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isCheckedIn ? 'Checked In' : 'Checked Out',
              style: TextStyle(
                fontSize: 24,
                color: isCheckedIn ? Colors.green : Colors.red,
              ),
            ),
            Text(isCheckedIn ? 'Office Location' : 'Not in office'),
            if (isCheckedIn && checkInTime != null)
              Text('Since ${DateFormat('hh:mm a').format(checkInTime!)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Check-in Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(currentOfficeLocation ?? 'No location set'),
              subtitle: isCheckedIn && checkInTime != null
                  ? Text('Checked in at ${DateFormat('hh:mm a').format(checkInTime!)}')
                  : const Text('Not checked in'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: isCheckedIn ? null : _checkIn,
                  icon: const Icon(Icons.login),
                  label: const Text('Check In'),
                ),
                ElevatedButton.icon(
                  onPressed: isCheckedIn ? _checkOut : null,
                  icon: const Icon(Icons.logout),
                  label: const Text('Check Out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Working Hours',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Today'),
              trailing: Text(_formatDuration(todayWorkDuration)),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('This Week'),
              trailing: Text(_formatDuration(weekWorkDuration)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetLocationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Enter Location',
                suffixIcon: Icon(Icons.location_searching),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _setLocationManually,
                  icon: const Icon(Icons.search),
                  label: const Text('Set Location'),
                ),
                ElevatedButton.icon(
                  onPressed: _setLocationFromMap,
                  icon: const Icon(Icons.map),
                  label: const Text('Pick on Map'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}