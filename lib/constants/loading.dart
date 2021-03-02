import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sandtonchurchapp/constants/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

           decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  // color: AppConstants.darkblue,
      color: Colors.black12,
                ),
      child: Center(
        child: SpinKitThreeBounce(
          color: AppConstants.darkblue,
          size: 50.0,
        ),
      ),
    );
  }
}