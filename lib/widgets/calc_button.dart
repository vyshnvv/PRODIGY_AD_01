import 'package:calculator/utils/colors.dart';
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  const CalcButton({super.key, required this.onTap, required this.btnText});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnText == "AC" || btnText == "C"
            ? secondaryColor4
            : btnText == "="
                ? secondaryColor5
                : primaryColor2,
        shape: CircleBorder(),
      ),
      child: Text(
        btnText,
        style: TextStyle(
            color: secondaryColor1,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.06),
      ),
    );
  }
}
