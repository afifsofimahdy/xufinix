import 'package:flutter/material.dart';
import 'package:ufinix/datamodels/prediction.dart';

import '../brand_colors.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  PredictionTile({this.prediction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: BrandColors.colorDimText,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  prediction.mainText,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: BrandColors.colorDimText,
                    fontFamily: "Brand-Bold",
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  prediction.secondaryText,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: BrandColors.colorDimText,
                  ),
                ),
                SizedBox(
                  height: 2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
