import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tanked/src/domain/controllers/success_page.controller.dart';
import 'package:tanked/src/presentation/global_widgets/button.ui.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';
import 'package:tanked/src/presentation/resources/icons.res.dart';

class SuccessfullyConfiguredSystemView extends GetView<SuccessPageController> {
  const SuccessfullyConfiguredSystemView({
    Key? key,
  }) : super(key: key);

  @override
  SuccessPageController get controller => Get.put(SuccessPageController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: context.height * .15),
                FadeIn(
                  delay: const Duration(milliseconds: 50),
                  duration: const Duration(milliseconds: 500),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: SvgPicture.asset(
                      successIconCircle,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                FadeInUp(
                  delay: const Duration(milliseconds: 50),
                  duration: const Duration(milliseconds: 400),
                  child: const Text(
                    'System configured successfully',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: dark,
                      height: 2.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                FadeInUp(
                  delay: const Duration(milliseconds: 50),
                  duration: const Duration(milliseconds: 500),
                  from: 75,
                  child: Text(
                    'You can now interact with the system',
                    style: TextStyle(
                      color: dark.withOpacity(0.6),
                      height: 1.5,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: transparent,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            width: double.infinity,
            child: TankedButtonUi(
              text: 'Take me home',
              onPressed: controller.takeMeHome,
              backgroundColor: dark,
            ),
          ),
        ),
      ),
    );
  }
}
