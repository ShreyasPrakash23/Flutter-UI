import 'package:flutter/material.dart';
import 'package:flutter_app/liveChart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  const MyApp({Key ? key}) : super(key:key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Graphs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: LiveChartWidget(),
    );
  }
}
