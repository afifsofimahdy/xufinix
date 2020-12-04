import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ufinix/datamodels/address.dart';
import 'package:ufinix/dataprovider/appdata.dart';
import 'package:ufinix/globalvariable.dart';
import 'package:ufinix/helpers/requesthelper.dart';
import 'package:provider/provider.dart';

class HelperMethods {
  static Future<String> findCordinateAdress(Position position, context) async {
    String placeAddress = "";

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestHelper.getRequest(url);
    if (response != "failed") {
      placeAddress = response["results"][0]["formatted_address"];

      Address pickupAddress = new Address();

      pickupAddress.latitude = position.longitude;
      pickupAddress.longtitude = position.longitude;
      pickupAddress.placeName = placeAddress;

      Provider.of<AppData>(
        context,
        listen: false,
      ).updatePickupAddress(pickupAddress);
    }
    return placeAddress;
  }
}
