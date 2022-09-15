// ignore_for_file: annotate_overrides, overridden_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';

class TankedButtonUi extends ElevatedButton {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final bool loading;

  TankedButtonUi({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.loading = false,
  }) : super(
          key: key,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            onPrimary: textColor ?? Colors.white,
            primary: backgroundColor ?? dark,
            minimumSize: const Size(88, 64),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          onPressed: onPressed,
          child: loading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: const TextStyle(
                    fontFamily: "BRFirmaMedium",
                  ),
                ),
        );
}
