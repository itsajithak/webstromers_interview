import 'package:ajithkumar_interview/constants/appColors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String? buttonText;
  final Color? textColor;
  final Color? buttonColor;

  const CustomElevatedButton(
      {super.key,
      this.onPressed,
      this.buttonText,
      this.textColor,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(
                buttonColor ?? Colors.transparent)),
        onPressed: onPressed,
        child: Text(
          buttonText ?? '',
          style: TextStyle(color: textColor ?? AppColors.whiteColor),
        ));
  }
}
