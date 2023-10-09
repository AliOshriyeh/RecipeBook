import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinkitCustomLoading extends StatelessWidget {
  final int typeNum;
  const SpinkitCustomLoading({Key? key, required this.typeNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (typeNum) {
      case 0:
        return const Center(
            child: SpinKitDoubleBounce(
          duration: Duration(seconds: 3),
          color: Colors.orange,
          size: 40,
        ));
      case 1:
        return const Center(
            child: SpinKitCubeGrid(
          duration: Duration(seconds: 5),
          color: Colors.orange,
          size: 40,
        ));
      case 2:
        return const Center(
            child: SpinKitPulse(
          duration: Duration(seconds: 3),
          color: Colors.orange,
          size: 40,
        ));
      case 3:
        return const Center(
            child: SpinKitRing(
          duration: Duration(seconds: 3),
          color: Colors.orange,
          size: 40,
        ));
      case 4:
        return const Center(
            child: SpinKitRipple(
          duration: Duration(seconds: 3),
          color: Colors.orange,
          size: 40,
        ));
      case 5:
        return const Center(
            child: SpinKitSquareCircle(
          duration: Duration(seconds: 3),
          color: Colors.orange,
          size: 40,
        ));
      case 6:
        return const Center(
            child: SpinKitChasingDots(
          duration: Duration(seconds: 3),
          color: Colors.orange,
          size: 40,
        ));
      case 7:
        return const Center(
            child: SpinKitFadingCircle(
          duration: Duration(seconds: 5),
          color: Colors.orange,
          size: 50,
        ));
      default:
        return const CircularProgressIndicator(color: Colors.red);
    }
  }
}
