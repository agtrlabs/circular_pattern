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
  final List<String> dotList = ['A', 'B', 'C', 'D'];

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
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Your Input:\n${input}',
                style: TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 300,
            ),
            Expanded(
              child: Container(
                color: Colors.blue.shade200,
                child: CircularPattern(
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
                  },
                  dots: const [
                    PatternDot(value: 'A'),
                    PatternDot(value: 'K'),
                    PatternDot(value: 'M'),
                    PatternDot(value: 'L'),
                    PatternDot(value: 'E'),
                    PatternDot(value: 'B'),
                  ],
                  options: const CircularPatternOptions(
                    primaryTextStyle: TextStyle(
                      color: Color.fromARGB(255, 22, 22, 22),
                      fontFamily: 'Alegreya',
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _info() {}
}
