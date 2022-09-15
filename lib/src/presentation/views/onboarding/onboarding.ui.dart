import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tanked/src/domain/controllers/onboarding.controller.dart';
import 'package:tanked/src/presentation/global_widgets/button.ui.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';
import 'package:tanked/src/presentation/resources/images.res.dart';
import 'package:tanked/src/presentation/views/onboarding/widgets/intro_slides_indicator.dart';

class OnboardingView extends GetView {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  OnboardingController get controller => Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    // final reset = Get.arguments as int?;

    return Scaffold(
      // appBar: TankedAppbar(),
      body: ScrollConfiguration(
        //remove blue scroll glow color
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: PageView.builder(
          physics: const PageScrollPhysics(),
          controller: controller.pageViewController,
          itemCount: introContents.length,
          itemBuilder: (_, i) {
            controller.pageViewController.addListener(() {
              controller.currentPage.value =
                  controller.pageViewController.page!;
            });
            final pageContent = introContents[i] as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.introBgColors[i],
                      image: const DecorationImage(
                        image: AssetImage(
                          splashBgTransparent,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: SvgPicture.asset(pageContent["image"] as String),
                  ),
                ),
                const Divider(
                  color: dark,
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    pageContent['header'] as String,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: dark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    pageContent['description'] as String,
                    style: const TextStyle(
                      color: dark,
                      fontFamily: 'BRFirmaSemiBold',
                      fontSize: 32.0,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        notchMargin: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  height: 16,
                  child: Row(
                    children: indicator(
                      controller.currentPage.value,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (controller.currentPage.round() != introContents.length - 1)
                  SizedBox(
                    height: 64,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.pageViewController.animateToPage(
                              controller.pageViewController.page!.toInt() + 2,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.pageViewController.animateToPage(
                              controller.pageViewController.page!.toInt() + 1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                            );
                          },
                          customBorder: const CircleBorder(),
                          child: Hero(
                            tag: "intro",
                            transitionOnUserGestures: true,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: dark,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (controller.currentPage.round() == introContents.length - 1)
                  SizedBox(
                    height: 64,
                    child: Hero(
                      tag: "intro",
                      transitionOnUserGestures: true,
                      child: SizedBox(
                        width: double.infinity,
                        child: TankedButtonUi(
                          text: controller.hasConfiguredSystem
                              ? "Take me home"
                              : 'Get Started',
                          onPressed: controller.navigateToIdentifySystemView,
                          backgroundColor: dark,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
