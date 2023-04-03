import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:remnevents/constants/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * .5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          // color: AppConstants.darkblue,
          color: Colors.black.withOpacity(0.05),
        ),
        child: Center(
          child: SpinKitThreeBounce(
            color: AppConstants.guava,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
