import 'dart:convert';
import 'package:aquae_florentis/data/network.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../domain/models/location-model.dart';
import 'package:location/location.dart';

class LocationService {
  static Future<Location?> askPermission() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location;
  }

  static Future<LocationModel> getLocationModel(
      {required final double long, required final double lat}) async {
    final GeoCode geoCode = GeoCode(apiKey: ValuesManager.MAP_API_KEY);
    final address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: long);

    final Map<dynamic, dynamic> addressJson = {
      "street address": address.streetAddress,
      "street number": address.streetNumber,
      "postal": address.postal,
      "region": address.region,
      "city": address.city,
      "country": address.countryName,
      "country code": address.countryCode
    };

    return LocationModel.fromJson(json: addressJson);
  }

  static Future<Map<dynamic, dynamic>> getLocationJson(
      {required final Location location}) async {
    LocationData locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${ValuesManager.MAP_API_KEY}");

    // send get request using url
    final response = await http.get(url);
    final locationJson = jsonDecode(response.body) as Map<dynamic, dynamic>;
    return locationJson;
  }

  static Future<Map<dynamic, dynamic>> getLocationJsonFromLatLng(
      {required final LatLng latlng}) async {
    final lat = latlng.latitude;
    final long = latlng.longitude;
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${ValuesManager.MAP_API_KEY}");

    // send get request using url
    final response = await http.get(url);
    final locationJson = jsonDecode(response.body) as Map<dynamic, dynamic>;
    return locationJson;
  }

  static String getLocationPreview(
      {required final double lat, required final double long}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$lat,$long&key=${ValuesManager.MAP_API_KEY}';
  }

  static Future<LatLng?> getLatLngFromPlace(
      {required final String placeId}) async {
        final url = Uri.https(
          "maps.googleapis.com",
          "maps/api/geocode/json",
          {
            "place_id":placeId,
            "key":ValuesManager.MAP_API_KEY
          }
        );
        final response = await NetworkService.getUri(uri: url);
        if(response!= null){
          final resultData = (jsonDecode(response) as Map<String,dynamic>)["results"][0];
          return LatLng(resultData["geometry"]["location"]["lat"], resultData["geometry"]["location"]["lng"]);
        }
        return null;
      }
}
