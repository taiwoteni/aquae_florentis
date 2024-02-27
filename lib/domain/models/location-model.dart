class LocationModel {
  final Map<dynamic, dynamic> _json;
  const LocationModel.fromJson({required final Map<dynamic, dynamic> json})
      : _json = json;

  String get formmattedAddress => "${streetNumber()} ${streetAddress()}, ${city()}, ${state()}, ${country()}";

  String city() {
    return _json["city"];
  }

  String state() {
    return _json["region"];
  }
  String postalCode() {
    return _json["postal"];
  }
  String streetAddress() {
    return _json["street address"];
  }
  String streetNumber() {
    return _json["street number"];
  }
  String country() {
    return _json["country"];
  }
  String countryCode() {
    return _json["country code"];
  }
}
