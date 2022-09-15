import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanked/src/data/local_data_source/local_data_source.impl.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';
import 'package:tanked/src/routing/app_pages.dart';

class OnboardingController extends GetxController {
  final _userLocal = LocalDataSourceImpl();
  final currentPage = 0.0.obs;

  final pageViewController = PageController();

  bool get hasConfiguredSystem => _userLocal.hasConfiguredSystem();

  final introBgColors = <Color>[
    tankedGreen,
    yellowColor,
    deepBlue,
  ];
  void navigateToIdentifySystemView() {
    // if (hasConfiguredSystem) {
    //   Get.offAllNamed(Routes.home);
    //   return;
    // }

    Get.toNamed(Routes.identifySystem);
    return;
  }
}
