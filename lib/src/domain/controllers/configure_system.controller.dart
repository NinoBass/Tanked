import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanked/src/data/enums/dimensions.enum.dart';
import 'package:tanked/src/data/local_data_source/local_data_source.impl.dart';
import 'package:tanked/src/routing/app_pages.dart';

class ConfigureSystemController extends GetxController {
  final _userLocal = LocalDataSourceImpl();

  //getter and setters for loading state
  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool v) => _loading(v);

  //height controller
  final heightController = TextEditingController();

  //width controller
  final radiusController = TextEditingController();

  //form key
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    heightController.text = "28";
    radiusController.text = "14.5";
  }

  String? get modelNumber => _userLocal.getModelNumber();

  void navigateToSuccessPage() =>
      Get.toNamed(Routes.successfullyConfiguredSystem);

  Future<void> showSuccessPage(BuildContext context) async {
    try {
      loading = true;
      FocusScope.of(context).unfocus();
      if (formKey.currentState!.validate()) {
        _userLocal.saveTankDimensions(
          <String, String>{
            TankDimension.height.name: heightController.text,
            TankDimension.radius.name: radiusController.text,
          },
        );

        await Future.delayed(
          const Duration(seconds: 1),
        );

        navigateToSuccessPage();
        loading = false;
      }
    } finally {
      loading = false;
    }
  }
}
