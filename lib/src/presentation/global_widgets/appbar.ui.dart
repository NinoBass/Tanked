import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tanked/src/presentation/global_widgets/back_button.ui.dart';
import 'package:tanked/src/presentation/resources/icons.res.dart';

class TankedAppbar extends AppBar {
  final bool showBackButton;

  @override
  Widget? get title => SvgPicture.asset(
        tankedIconCircle,
        fit: BoxFit.cover,
        width: 35,
        alignment: Alignment.bottomCenter,
      );
  @override
  double get leadingWidth => 80;

  @override
  Widget get leading =>
      showBackButton ? const TankedBackButton() : const SizedBox.shrink();

  TankedAppbar({
    Key? key,
    this.showBackButton = true,
  }) : super(
          key: key,
          leading: showBackButton
              ? const TankedBackButton()
              : const SizedBox.shrink(),
        );
}
