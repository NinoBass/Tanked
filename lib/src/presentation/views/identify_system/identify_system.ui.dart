import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:tanked/src/domain/controllers/identify_system.controller.dart';
import 'package:tanked/src/presentation/global_widgets/appbar.ui.dart';
import 'package:tanked/src/presentation/global_widgets/button.ui.dart';
import 'package:tanked/src/presentation/global_widgets/loader.ui.dart';
import 'package:tanked/src/presentation/global_widgets/textfield.ui.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';

class IdentifySystemView extends GetView<IdentifySystemController> {
  const IdentifySystemView({
    Key? key,
  }) : super(key: key);

  @override
  IdentifySystemController get controller =>
      Get.put(IdentifySystemController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: controller.loading
            ? const TankedLoaderUi(message: 'Connecting to your system...')
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
                                  'Identify your system',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                    color: dark,
                                    height: 2.0,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Enter your phone number and the model number of your water level monitoring and control system.',
                                  style: TextStyle(
                                    color: dark.withOpacity(0.6),
                                    height: 1.5,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 36),
                                Text(
                                  'Phone number',
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
                                              'NGR ',
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
                                        controller: controller.phoneController,
                                        labelText: "Enter phone number",
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(
                                            11,
                                          ),
                                        ],
                                        validators:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                            errorText:
                                                "An 11 digit phone number is needed to proceed",
                                          ),
                                          FormBuilderValidators.maxLength(
                                            11,
                                            errorText:
                                                "Phone number must be 11 characters",
                                          ),
                                          FormBuilderValidators.minLength(
                                            11,
                                            errorText:
                                                "Phone number must be 11 characters",
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  'Model number',
                                  style: TextStyle(
                                    color: dark.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                CustomTextField(
                                  controller: controller.modelNumberController,
                                  labelText: "Enter model number e.g WLMS0001",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(
                                      8,
                                    ),
                                  ],
                                  validators: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText:
                                          "An 8 digit model number is needed to proceed",
                                    ),
                                    FormBuilderValidators.maxLength(
                                      8,
                                      errorText:
                                          "Model number must be 8 characters",
                                    ),
                                    FormBuilderValidators.minLength(
                                      8,
                                      errorText:
                                          "Model number must be 8 characters",
                                    ),
                                  ]),
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
                                  text: 'Next',
                                  onPressed: () =>
                                      controller.identifySystem(context),
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
      ),
    );
  }
}
