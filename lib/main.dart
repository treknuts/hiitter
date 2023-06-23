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
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("HIITTER"),
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
        elevation: 0.75,
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(height: 220.0),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                      child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: _startTimer,
                        icon: const Icon(Icons.play_arrow_rounded),
                        iconSize: 62.0,
                      ),
                      IconButton(
                        onPressed: _stopTimer,
                        icon: const Icon(Icons.pause),
                        iconSize: 62.0,
                      ),
                      IconButton(
                        onPressed: _resetTimer,
                        icon: const Icon(Icons.restore_outlined),
                        iconSize: 62.0,
                      )
                    ],
                  ))
                ],
              )
            ],
          ),
        ));
  }
}

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBar();
}

class _MyNavigationBar extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_fill_rounded),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pause_circle_outline_rounded),
          label: 'Pause',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restart_alt_rounded),
          label: 'Restart',
          backgroundColor: Colors.purple,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
