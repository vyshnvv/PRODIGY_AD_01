import 'package:calculator/utils/colors.dart';
import 'package:flutter/material.dart';

class CalcButton2 extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  const CalcButton2({super.key, required this.onTap, required this.btnText});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08)),
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
