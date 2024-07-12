import 'dart:math';
import 'package:calculator/utils/colors.dart';
import 'package:calculator/widgets/calc_button.dart';
import 'package:calculator/widgets/calc_button2.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String userInput = "";
  String result = "";

  List<String> btnList = [
    "AC",
    "( )",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "C",
    "=",
  ];

  void calculate(String symbol) {
    setState(() {
      var temp;
      if (symbol == "AC") {
        userInput = "0";
        result = "";
      } else if (symbol == "C") {
        if (userInput != "") {
          userInput = userInput.substring(0, userInput.length - 1);
          if (userInput.isEmpty) {
            userInput = "0";
          }
        } else {
          userInput = "0";
        }
      } else if (symbol == "( )") {
        if (userInput.contains("(")) {
          symbol = ")";
          userInput += symbol;
        } else {
          symbol = "(";
          userInput += symbol;
        }
      } else if (symbol == "=") {
        try {
          temp = userInput;
          if (temp.contains("√")) {
            var index = temp.indexOf("√");
            if (temp[index + 1] == "(") {
              var subexp = temp.substring(index + 2, temp.indexOf(")"));
              var parsed = inputParser(subexp);
              if (parsed.endsWith(".0")) {
                parsed = parsed.replaceAll(".0", "");
              }

              temp = temp.replaceRange(index, temp.indexOf(")") + 1,
                  sqrt(double.parse(parsed)).toStringAsPrecision(5));
              result = temp.replaceAll(".0", "");
            } else {
              temp = temp.replaceRange(index, index + 2,
                  sqrt(double.parse(temp[index + 1])).toStringAsPrecision(5));
            }
          }

          if (inputParser(temp) == "Infinity") {
            result = "cannot divide by zero";
          } else {
            if (inputParser(temp).endsWith(".0")) {
              result = inputParser(temp).replaceAll(".0", "");
            }
          }
        } catch (e) {
          result = "Format Error";
        }
      } else {
        if (userInput.length == 1) {
          userInput = "";
          userInput += symbol;
        } else {
          userInput += symbol;
        }
      }
    });
  }

  String inputParser(String exp) {
    var parsed = Parser().parse(exp);
    var evaluation = parsed.evaluate(EvaluationType.REAL, ContextModel());
    return evaluation.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(size.width * 0.01),
              alignment: Alignment.center,
              width: size.width,
              height: size.height * 0.28,
              decoration: BoxDecoration(
                  color: secondaryColor6,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5, left: 5),
                    alignment: Alignment.bottomRight,
                    height: size.height * 0.13,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userInput,
                          style: TextStyle(fontSize: 50),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: primaryColor2,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5, left: 5),
                    height: size.height * 0.13,
                    alignment: Alignment.bottomRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(result, style: TextStyle(fontSize: 50)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(size.height * 0.01,
                  size.height * 0.01, size.height * 0.01, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalcButton2(onTap: () => calculate("√"), btnText: "√"),
                  CalcButton2(onTap: () => calculate("^"), btnText: "^"),
                  CalcButton2(
                    onTap: () => calculate("!"),
                    btnText: "!",
                  ),
                  CalcButton2(onTap: () => calculate("log"), btnText: "log")
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: size.width * 0.97,
              margin: EdgeInsets.fromLTRB(0, size.height * 0.015, 0, 0),
              child: GridView.builder(
                  itemCount: btnList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 7,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CalcButton(
                        onTap: () => calculate(btnList[index]),
                        btnText: btnList[index]);
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
