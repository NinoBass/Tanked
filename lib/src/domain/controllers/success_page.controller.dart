import 'package:get/get.dart';
import 'package:tanked/src/routing/app_pages.dart';

class SuccessPageController extends GetxController {
  void takeMeHome() => Get.offAllNamed(Routes.home);
}
