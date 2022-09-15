import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:tanked/src/domain/controllers/configure_system.controller.dart';
import 'package:tanked/src/presentation/global_widgets/appbar.ui.dart';
import 'package:tanked/src/presentation/global_widgets/button.ui.dart';
import 'package:tanked/src/presentation/global_widgets/loader.ui.dart';
import 'package:tanked/src/presentation/global_widgets/textfield.ui.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';

class ConfigureSystemView extends GetView {
  const ConfigureSystemView({
    Key? key,
  }) : super(key: key);

  @override
  ConfigureSystemController get controller =>
      Get.put(ConfigureSystemController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: controller.loading
          ? TankedLoaderUi(
              message: 'Configuring ${controller.modelNumber ?? " "}',
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: TankedAppbar(),
              body: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              const Text(
                                'Configure your system',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                  color: dark,
                                  height: 2.0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Enter the height and radius of your water tank for accurate computation of its water level in realtime',
                                style: TextStyle(
                                  color: dark.withOpacity(0.6),
                                  height: 1.5,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 36),
                              Text(
                                'Height of tank in centimeters',
                                style: TextStyle(
                                  color: dark.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: SizedBox(
                                      height: 32.0,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'cm ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Icon(
                                            Icons.expand_more,
                                            color: tankedGreen,
                                            size: 22,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: controller.heightController,
                                      labelText:
                                          "Enter height of tank here (in cm)",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(
                                          6,
                                        ),
                                      ],
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Radius of tank in centimeters',
                                style: TextStyle(
                                  color: dark.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: SizedBox(
                                      height: 32.0,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'cm ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Icon(
                                            Icons.expand_more,
                                            color: tankedGreen,
                                            size: 22,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: controller.radiusController,
                                      labelText:
                                          "Enter radius of tank here (in cm)",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(
                                          6,
                                        ),
                                      ],
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: TankedButtonUi(
                                text: 'Configure system',
                                onPressed: () =>
                                    controller.showSuccessPage(context),
                                backgroundColor: dark,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
