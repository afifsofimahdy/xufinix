import 'package:flutter/cupertino.dart';
import 'package:ufinix/datamodels/address.dart';

class AppData extends ChangeNotifier {
  Address pickupAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }
}
