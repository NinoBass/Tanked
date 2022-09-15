import 'package:flutter/material.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';
import 'package:tanked/src/presentation/resources/images.res.dart';

List<Widget> indicator(double currentPage) => List<Widget>.generate(
      introContents.length,
      (index) => AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        height: currentPage.round() == index ? 16.0 : 7.0,
        width: 7.0,
        decoration: BoxDecoration(
          color: currentPage.round() == index
              ? tankedGreen
              : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );

List introContents = [
  {
    "header": "Receive updates in realtime",
    "description": "Keep track of your water level",
    "image": bg3,
    "alignment": Alignment.bottomCenter
  },
  {
    "header": "Remotely interact with your water system",
    "description": "Connect to your water system via the internet",
    "image": bg1,
    "alignment": Alignment.topRight,
  },
  {
    "header": "Remotely control your water system",
    "description": "Control your pumping machine on the go!",
    "image": bg4,
    "alignment": Alignment.bottomLeft
  }
];
