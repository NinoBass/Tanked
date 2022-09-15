import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';

class TankedLoaderUi extends StatelessWidget {
  final String message;
  const TankedLoaderUi({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitWave(
            color: tankedGreen,
            size: 40.0,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: TextStyle(
              color: dark.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }
}
