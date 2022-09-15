import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanked/src/data/local_data_source/local_data_source.impl.dart';
import 'package:tanked/src/routing/app_pages.dart';

class IdentifySystemController extends GetxController {
  final _userLocal = LocalDataSourceImpl();
  //getter and setters for loading state
  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool v) => _loading(v);

  //phone number controller
  final phoneController = TextEditingController();

  //model number controller
  final modelNumberController = TextEditingController();

  //form key
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    phoneController.text = "08083692937";
    modelNumberController.text = "WLMS0001";
  }

  void navigateToConfigureSystemView() => Get.toNamed(Routes.configureSystem);

  Future<void> identifySystem(BuildContext context) async {
    try {
      loading = true;
      FocusScope.of(context).unfocus();
      if (formKey.currentState!.validate()) {
        //save model number
        await _userLocal.saveModelNumber(modelNumberController.text);

        await Future.delayed(
          const Duration(seconds: 1),
        );

        navigateToConfigureSystemView();
        loading = false;
      }
    } finally {
      loading = false;
    }
  }
}
