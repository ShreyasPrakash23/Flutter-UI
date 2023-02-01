import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerDisplay(),
    );
  }
}

class TimerDisplay extends StatefulWidget {
  @override
  _TimerDisplayState createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  int _counter1 = 0; //temp
  int _counter2 = 0; //humid
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _counter1 = math.Random().nextInt(40) + 32;
        _counter2 = math.Random().nextInt(50) + 35;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.device_thermostat, color:Colors.red, size:30.0),
              Container(
                margin: const EdgeInsets.only(top:8),
                child: Text('Temperature : $_counter1', style: TextStyle(fontSize:20, fontWeight:FontWeight.w400,color: Colors.blue)),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.water_drop, color:Colors.blue, size:30.0),
              Container(
                margin: const EdgeInsets.only(top:8),
                child: Text('Humidity : $_counter2', style: TextStyle(fontSize:20, fontWeight:FontWeight.w400,color: Colors.blue)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
