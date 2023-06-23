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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: IntervalCard(start: 5, title: "Run"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class IntervalCard extends StatefulWidget {
  final int start;
  final String title;
  const IntervalCard({Key? key, required this.title, required this.start})
      : super(key: key);

  @override
  State<IntervalCard> createState() => _IntervalCard();
}

class _IntervalCard extends State<IntervalCard> {
  late int _originalStart;
  late int _start;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _originalStart = widget.start;
    _start = widget.start;
  }

  void _startTimer() {
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start--;
              }
            }));
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _start = _originalStart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.title, style: const TextStyle(fontSize: 42.0)),
              _start == 0
                  ? const Text("Done", style: TextStyle(fontSize: 42.0))
                  : Text('$_start',
                      style: const TextStyle(
                          fontSize: 42.0, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ButtonBar(
                      children: <Widget>[
                        IconButton(
                          onPressed: _startTimer,
                          icon: const Icon(Icons.play_circle_outline_rounded),
                          iconSize: 64.0,
                        ),
                        IconButton(
                          onPressed: _stopTimer,
                          icon: const Icon(Icons.pause_circle_outline_rounded),
                          iconSize: 64.0,
                        ),
                        IconButton(
                          onPressed: _resetTimer,
                          icon: const Icon(Icons.restart_alt_rounded),
                          iconSize: 64.0,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
