import 'package:flutter/material.dart';
import 'package:quiz_assignment_2/qna.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App 101',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: const Color(0xFF000000),
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
      ),
      home: MyHomePage(title: 'Better than Safe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  int score = 0;
  List<Widget> answers_list = []; //declaring a widget list

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int randomNumber = random.nextInt(100);

    q_n_a object1 = new q_n_a();

    List<String> quests = object1.quest();

    List<String> ans = object1.ans();

    String current_quest = quests[index];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(current_quest,
                  style: TextStyle(fontSize: 25.0, color: Colors.white)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                    // width: MediaQuery.of(context).size.width,
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.1 * 1,
                  color: Colors.green,
                  child: TextButton(
                      onPressed: () => {
                            setState(() {
                              if (ans[index] == 'Yes') {
                                answers_list.add(Icon(Icons.check,
                                    color: Colors.green, size: 20));
                                index++;
                                score++;
                                current_quest = quests[index];
                              } else {
                                answers_list.add(Icon(Icons.close,
                                    color: Colors.red, size: 20));
                                index++;
                                current_quest = quests[index];
                              }
                              if (index > 14) {
                                // answers_list.add(Icon(Icons.favorite,
                                //     color: Colors.red, size: 20));
                                answers_list.add(
                                  Text('Score: $score',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10)),
                                );
                              }
                            })
                          },
                      child: Text(
                        "Yes",
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      )),
                )),
              ),
              Expanded(
                child: Container(
                    // width: MediaQuery.of(context).size.width,
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.1 * 1,
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () => {
                            setState(() {
                              if (ans[index] == 'Yes') {
                                answers_list.add(Icon(Icons.close,
                                    color: Colors.red, size: 20));
                                index++;
                                current_quest = quests[index];
                              } else {
                                answers_list.add(Icon(Icons.check,
                                    color: Colors.green, size: 20));
                                index++;
                                score++;
                                current_quest = quests[index];
                              }
                              if (index > 14) {
                                // answers_list.add(Icon(Icons.favorite,
                                //     color: Colors.red, size: 20));
                                answers_list.add(
                                  Text('Score: $score',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10)),
                                );
                              }
                            })
                          },
                      child: Text(
                        "No",
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      )),
                )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: answers_list,
          )
        ])
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
