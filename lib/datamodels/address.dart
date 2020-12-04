//import 'dart:wasm';

class Address {
  String placeName;
  double latitude;
  double longtitude;
  String placeId;
  Stream placeFormattedAddress;

  Address({
    this.placeId,
    this.latitude,
    this.longtitude,
    this.placeName,
    this.placeFormattedAddress,
  });
}
