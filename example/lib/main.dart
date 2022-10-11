import 'package:circular_pattern/circular_pattern.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Pattern Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Circular Pattern Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = '';
  final List<String> dotList = ['1', '2', '3', '4', '5', '6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Your Input:\n$input',
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            Expanded(
              child: Container(
                color: Colors.blue.shade200,
                child: CircularPattern(
                  onChange: ((result) {
                    String text = '';
                    for (var element in result) {
                      text += element.value;
                    }
                    setState(() {
                      input = text;
                    });
                  }),
                  onStart: () {
                    setState(() {
                      input = '';
                    });
                  },
                  onComplete: (result) {
                    String text = '';
                    for (var element in result) {
                      text += element.value;
                    }
                    setState(() {
                      input = text;
                    });
                    Future.delayed(
                        const Duration(seconds: 2),
                        () => setState(() {
                              input = '';
                            }));
                  },
                  dots: dotList
                      .map<PatternDot>((e) => PatternDot(value: e))
                      .toList(),
                  options: const CircularPatternOptions(
                      primaryDotColor: Color(0xFFEEEEEE),
                      selectedDotColor: Color.fromARGB(255, 17, 123, 180),
                      primaryTextStyle: TextStyle(
                        color: Color.fromARGB(255, 22, 22, 22),
                        fontFamily: 'Alegreya',
                      ),
                      selectedTextStyle: TextStyle(
                        color: Color.fromARGB(255, 222, 222, 222),
                        fontFamily: 'Alegreya',
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
