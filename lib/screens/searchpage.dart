import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufinix/brand_colors.dart';
import 'package:ufinix/datamodels/prediction.dart';
import 'package:ufinix/dataprovider/appdata.dart';
import 'package:ufinix/globalvariable.dart';
import 'package:ufinix/helpers/requesthelper.dart';
import 'package:ufinix/widgets/BrandDivier.dart';
import 'package:ufinix/widgets/PredictionTile.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();
  var focusDestination = FocusNode();

  bool focused = false;
  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  List<Prediction> destinationPredictionList = [];

  void searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890";
      var response = await RequestHelper.getRequest(url);

      if (response == 'failed') {
        return;
      }
      if (response['status'] == 'OK') {
        var predictionJson = response['predictions'];

        var thisList = (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();
        setState(() {
          destinationPredictionList = thisList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();

    String address =
        Provider.of<AppData>(context).pickupAddress.placeName ?? "";
    pickupController.text = address;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 210,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 07))
              ],
            ),
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 20,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Stack(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Center(
                      child: Text(
                        "Pilih Tujuan",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Brand-Bold",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "images/pickicon.png",
                      height: 16,
                      width: 16,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: BrandColors.colorLightGrayFair,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          controller: pickupController,
                          decoration: InputDecoration(
                            hintText: "Lokasi awal",
                            fillColor: BrandColors.colorLightGrayFair,
                            filled: true,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 8,
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "images/desticon.png",
                      height: 16,
                      width: 16,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: BrandColors.colorLightGrayFair,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          onChanged: (value) {
                            searchPlace(value);
                          },
                          focusNode: focusDestination,
                          controller: destinationController,
                          decoration: InputDecoration(
                            hintText: "Tujuan Anda",
                            fillColor: BrandColors.colorLightGrayFair,
                            filled: true,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 8,
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
          (destinationPredictionList.length > 0)
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        prediction: destinationPredictionList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        BrandDivider(),
                    itemCount: destinationPredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
