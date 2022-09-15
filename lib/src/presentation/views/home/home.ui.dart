import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanked/src/data/enums/dimensions.enum.dart';
import 'package:tanked/src/domain/controllers/home.controller.dart';
import 'package:tanked/src/presentation/global_widgets/button.ui.dart';
import 'package:tanked/src/presentation/global_widgets/gap.ui.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';
import 'package:tanked/src/presentation/resources/images.res.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  HomeController get controller => Get.put(HomeController());

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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(24),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.showGreetings()} Nino",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "BRFirmaMedium",
                          ),
                        ),
                        const Gap(4),
                        Text(
                          "How are you today?",
                          style: TextStyle(
                            color: dark.withOpacity(.6),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                    const Gap(4),
                    PopupMenuButton<int>(
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: dark,
                      ),
                      padding: EdgeInsets.zero,
                      splashRadius: 24,
                      constraints: const BoxConstraints(
                        minWidth: kMinInteractiveDimension,
                        minHeight: kMinInteractiveDimension,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      onSelected: (value) {
                        if (value == 1) {
                          Get.defaultDialog(
                            title: "Settings",
                            titleStyle: const TextStyle(
                              fontFamily: "BRFirmaSemiBold",
                            ),
                            titlePadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            content: Obx(
                              () => CheckboxListTile(
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.operateAutomatically.value =
                                        value;
                                  }
                                },
                                activeColor: yellowColor,
                                value: controller.operateAutomatically.value,
                                title: const Text(
                                  "Automatically Control Pump",
                                  style: TextStyle(
                                    color: tankedGreenDark,
                                    fontFamily: "BRFirmaMedium",
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        if (value == 2) {
                          controller.connectToAnotherSystem();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          padding: const EdgeInsets.fromLTRB(24, 32, 16, 16),
                          onTap: () {},
                          child: const Text(
                            "Settings",
                            style: TextStyle(
                              color: tankedGreenDark,
                              fontFamily: "BRFirmaMedium",
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          padding: const EdgeInsets.fromLTRB(24, 16, 16, 32),
                          onTap: () {},
                          child: const Text(
                            "Connect to another\nWLM system",
                            style: TextStyle(
                              color: tankedGreenDark,
                              fontFamily: "BRFirmaMedium",
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const Gap(40),
                const Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "BRFirmaSemiBold",
                  ),
                ),
                const Gap(16),
                const Text(
                  "- Realtime Water Level Updates",
                  style: TextStyle(
                    color: tankedGreenDark,
                  ),
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 72,
                      width: 120,
                      decoration: BoxDecoration(
                        color: deepBlue.withOpacity(.1),
                        image: const DecorationImage(
                          image: AssetImage(
                            pattern1,
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Height",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            controller.tankDimensions[TankDimension.height.name]
                                    ?.toString() ??
                                " ",
                            style: const TextStyle(
                              fontSize: 30,
                              color: deepBlue,
                              fontFamily: "BRFirmaBold",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 72,
                      width: 120,
                      decoration: BoxDecoration(
                        color: yellowColor.withOpacity(.1),
                        image: const DecorationImage(
                          image: AssetImage(
                            pattern2,
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Radius",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            controller.tankDimensions[TankDimension.radius.name]
                                    ?.toString() ??
                                " ",
                            style: const TextStyle(
                              fontSize: 30,
                              fontFamily: "BRFirmaBold",
                              color: yellowColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                const TankUi(),
                const Gap(32),
                const Text(
                  "- Pump Status and Control",
                  style: TextStyle(
                    color: tankedGreenDark,
                  ),
                ),
                const Gap(12),
                Obx(
                  () => Text(
                    "   - ${controller.pumpStatus.value} ${controller.waterFlowStatus.value}",
                  ),
                ),
                const Gap(12),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: TankedButtonUi(
                          text: "Start Pump",
                          loading: controller.startPumpIsInProgress.value,
                          onPressed:
                              controller.pumpIsOn ? null : controller.startPump,
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: TankedButtonUi(
                          text: "Stop Pump",
                          loading: controller.stopPumpIsInProgress.value,
                          onPressed:
                              controller.pumpIsOn ? controller.stopPump : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TankUi extends GetView<HomeController> {
  const TankUi({
    Key? key,
  }) : super(key: key);

  @override
  HomeController get controller => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Obx(
            () => WaveWidget(
              size: Size(
                context.width * .6,
                350,
              ),
              backgroundColor: grey,
              waveAmplitude: 0,
              config: CustomConfig(
                gradients: [
                  [deepBlue, yellowColor],
                ],
                durations: [12000],
                heightPercentages: [controller.tankWaterLevel.value],
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 4,
              width: context.width * .2,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(80),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
