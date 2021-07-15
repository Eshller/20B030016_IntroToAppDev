import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          scaffoldBackgroundColor: const Color(0xFF000000),
          primaryColor: Colors.black),
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: const MyCalc(),
    );
  }
}

class MyCalc extends StatefulWidget {
  const MyCalc({Key? key}) : super(key: key);
  @override
  State<MyCalc> createState() => _MyCalc();
}

class _MyCalc extends State<MyCalc> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom();

  String equation = "0";
  String answer = "0";
  String expression = "";
  double questionFontSize = 38;
  double answerFontSize = 48;
  evaluate(String key) {
    setState(() {
      if (key == "C") {
        equation = "0";
        answer = "0";
        questionFontSize = 38;
        answerFontSize = 48;
      } else if (key == "⌫") {
        questionFontSize = 48;
        answerFontSize = 38;
        if (equation.length > 1) {
          equation = equation.substring(0, equation.length - 1);
        } else {
          equation = "0";
        }
      } else if (key == "=") {
        questionFontSize = 38;
        answerFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('√', 'sqrt');
        expression = expression.replaceAll('%', '*0.01');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          answer = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          answer = "Invalid Expression!";
        }
      } else {
        questionFontSize = 48;
        answerFontSize = 38;
        if (equation == "0") {
          equation = key;
        } else {
          equation = equation + key;
        }
      }
    });
  }

  Widget button(String text, double height, Color buttoncol, Color textcol) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * height,
      color: buttoncol,
      child: TextButton(
          style: flatButtonStyle,
          onPressed: () => evaluate(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 25.0, color: textcol),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(equation,
                  style: TextStyle(
                      fontSize: questionFontSize, color: Colors.white)),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Text(answer,
                  style:
                      TextStyle(fontSize: answerFontSize, color: Colors.white)),
            ),
          ),
          Divider(
            height: 0,
            thickness: 2,
            color: Colors.orange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        button("C", 1, Colors.black, Colors.orange),
                        button("⌫", 1, Colors.black, Colors.orange),
                        button("%", 1, Colors.black, Colors.orange),
                        button("÷", 1, Colors.black, Colors.orange)
                      ]),
                      TableRow(children: [
                        button("7", 1, Colors.black, Colors.white),
                        button("8", 1, Colors.black, Colors.white),
                        button("9", 1, Colors.black, Colors.white),
                        button("x", 1, Colors.black, Colors.orange)
                      ]),
                      TableRow(children: [
                        button("4", 1, Colors.black, Colors.white),
                        button("5", 1, Colors.black, Colors.white),
                        button("6", 1, Colors.black, Colors.white),
                        button("-", 1, Colors.black, Colors.orange)
                      ]),
                      TableRow(children: [
                        button("1", 1, Colors.black, Colors.white),
                        button("2", 1, Colors.black, Colors.white),
                        button("3", 1, Colors.black, Colors.white),
                        button("+", 1, Colors.black, Colors.orange)
                      ]),
                      TableRow(children: [
                        button("√", 1, Colors.black, Colors.orange),
                        button("0", 1, Colors.black, Colors.white),
                        button(".", 1, Colors.black, Colors.white),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 0),
                              // ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //     primary: Colors.amber,
                              //     onPrimary: Colors.white,
                              //     shape: const RoundedRectangleBorder(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(20)),
                              //     ),
                              //   ),
                              //   onPressed: () {},
                              //   child: const Text('=',
                              //       style: TextStyle(fontSize: 20)),
                              // ),
                              RawMaterialButton(
                                onPressed: () => evaluate("="),
                                elevation: 2.0,
                                fillColor: Colors.orange,
                                child: Icon(
                                  Icons.calculate,
                                  size: 35.0,
                                ),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              )
                            ],
                          ),
                        )
                        // height: MediaQuery.of(context).size.height * 0.1 * 1,
                        // color: Colors.black,
                        // child: TextButton(
                        //     style: ButtonStyle(
                        //         shape: MaterialStateProperty.all<
                        //                 RoundedRectangleBorder>(
                        //             RoundedRectangleBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(60.0),
                        //                 side:
                        //                     BorderSide(color: Colors.red)))),
                        //     onPressed: () {},
                        //     child: Text(
                        //       "heya",
                        //       style: TextStyle(
                        //           fontSize: 25.0, color: Colors.yellow),
                        //     )),
                      ]),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
