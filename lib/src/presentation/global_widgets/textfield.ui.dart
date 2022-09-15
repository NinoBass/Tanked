import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.labelText,
    this.enabled = true,
    this.suffix,
    this.inputFormatters,
    this.validators,
    this.maxLines = 1,
    this.hintText,
    this.readOnly = false,
    this.autoFocus = false,
    this.onTap,
    this.style,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool enabled;
  final bool autoFocus;
  final TextStyle? style;
  final TextEditingController controller;
  final String? Function(String?)? validators;
  final TextInputType keyboardType;
  final Widget? suffix;
  final int maxLines;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool showBorder = false;

  void showBorderMethod() {
    if (_focusNode.hasPrimaryFocus && mounted) {
      setState(() {
        showBorder = true;
      });
    } else {
      setState(() {
        showBorder = false;
      });
    }
  }

  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(showBorderMethod);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10.0),
            border: (_formFieldKey.currentState?.hasError ?? false)
                ? Border.all(
                    color: redColor,
                    width: .4,
                  )
                : showBorder
                    ? Border.all(
                        color: borderColor,
                        width: .4,
                      )
                    : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: TextFormField(
              key: _formFieldKey,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              controller: widget.controller,
              autofocus: widget.autoFocus,
              cursorColor: dark,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              focusNode: _focusNode,
              inputFormatters: widget.inputFormatters,
              validator: widget.validators,
              keyboardType: widget.keyboardType,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF000921),
                fontWeight: FontWeight.w500,
              ).merge(widget.style),
              decoration: InputDecoration(
                filled: true,
                errorStyle: const TextStyle(
                  fontSize: 0,
                  height: -30,
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: labelColor,
                ),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  color: labelColor,
                ),
                floatingLabelStyle: const TextStyle(
                  color: Color(0xFFA1A5AD),
                ),
                hintText: widget.hintText,
                labelText: widget.labelText,
                contentPadding: const EdgeInsets.fromLTRB(16, 18, 16, 17.5),
                suffixIcon: (_formFieldKey.currentState?.hasError ?? false)
                    ? const Icon(
                        Icons.warning_rounded,
                        size: 20,
                        color: redColor,
                      )
                    : widget.suffix,
              ),
              onChanged: (value) {},
            ),
          ),
        ),
        if (_formFieldKey.currentState?.hasError ?? false) ...[
          const SizedBox(height: 5),
          Text(
            _formFieldKey.currentState?.errorText ?? "",
            style: const TextStyle(
              color: redColor,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
