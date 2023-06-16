import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIITTER',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'HIITTER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _start = 10; 
  late Timer _timer;

  void _startTimer() {
      _timer = Timer.periodic(
        const Duration(seconds: 1), 
        (timer) => setState(() {
          if(_start < 1) {
            timer.cancel();
          } else {
            _start--;
          }
        })
        );
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _start = 10;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_start',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ButtonBar(
                    children: <Widget>[
                      IconButton(onPressed: _startTimer, icon: const Icon(Icons.play_circle_outline_rounded), iconSize: 64.0,),
                      IconButton(onPressed: _stopTimer, icon: const Icon(Icons.pause_circle_outline_rounded), iconSize: 64.0,),
                      IconButton(onPressed: _resetTimer, icon: const Icon(Icons.restart_alt_rounded), iconSize: 64.0,)
                    ],
                  ),
                )
              ],
            )
            
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
