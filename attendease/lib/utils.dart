import 'dart:convert';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;


double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000; // Earth's radius in meters

  // Converting degrees to radians
  double dLat = _degreeToRadian(lat2 - lat1);
  double dLon = _degreeToRadian(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreeToRadian(lat1)) * cos(_degreeToRadian(lat2)) *
      sin(dLon / 2) * sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculating the distance
  return earthRadius * c;
}

// Helper function to convert degrees to radians
double _degreeToRadian(double degree) {
  return degree * pi / 180;
}





Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    String apiKey = 'AIzaSyDNuJFHTBoAJeSsDdJhyuQrpkDo5_bl6As'; // Replace with your actual API key
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'OK') {
        List<dynamic> results = data['results'];
        if (results.isNotEmpty) {
          String formattedAddress = results.first['formatted_address'];
          print('Formatted Address: $formattedAddress');
          return formattedAddress;
        } else {
          return ('No address components found');
        }
      } else {
        return('Geocoding request failed: ${data['status']}');
      }
    } else {
      return('Geocoding request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    return('Error getting address: $e');
  }
}