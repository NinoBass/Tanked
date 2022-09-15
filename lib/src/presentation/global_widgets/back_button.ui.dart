import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';
import 'package:tanked/src/presentation/resources/icons.res.dart';

class TankedBackButton extends StatelessWidget {
  const TankedBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Back",
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              SvgPicture.asset(
                backIcon,
                color: dark,
                height: 21,
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: dark,
                    fontSize: 16,
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
