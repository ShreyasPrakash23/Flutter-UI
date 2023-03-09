import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;
import 'dart:async';

class LiveChartWidget extends StatefulWidget {
  const LiveChartWidget({Key? key}) : super(key: key);
  @override
  _LiveChartWidgetState createState() => _LiveChartWidgetState();
}

class _LiveChartWidgetState extends State<LiveChartWidget> {
  int _counter1 = 0; //temp
  int _counter2 = 0; //humid
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  void _startTimer() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 5), updateDataSource);
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _counter1 = math.Random().nextInt(3) + 32;
        _counter2 = math.Random().nextInt(3) + 40;
      });
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 43),
      LiveData(2, 45),
      LiveData(3, 45),
      LiveData(4, 43),
      LiveData(5, 44),
      LiveData(6, 45),
      LiveData(7, 48),
      LiveData(8, 49),
      LiveData(9, 41),
    ];
  }

  int time = 10;
  updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60))));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slave device Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        children: [
          Container(
            height: 300,
            child: SfCartesianChart(
              series: [
                LineSeries<LiveData, int>(
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  dataSource: chartData,
                  xValueMapper: (LiveData data, _) => data.time,
                  yValueMapper: (LiveData data, _) => data.speed,
                ),
              ],
              primaryXAxis: NumericAxis(
                majorGridLines: MajorGridLines(width: 1),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 2,
                title: AxisTitle(text: 'Time(seconds)'),
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: MajorGridLines(width: 1),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 2,
                title: AxisTitle(text: 'Mositure content(%)'),
              ),
            ),
          ),
          //insert other containers here below
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black,
              ),

            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.thermostat, color: Colors.red, size: 120,),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text('Temperature : $_counter1 C'),
                ),
                Icon(Icons.water_drop, color: Colors.blue,size: 120,),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text('Humidity : $_counter2 %'),
                ),
              ],
            ),
          ),

          Container(

            margin: const EdgeInsets.only(top: 10),
            height: 400,
            width: 400,

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/farm.jpg'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black,
              ),

            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 250,
                  right: 100,
                  child: Center(
                    child: Column(
                      children: [
                         Icon(Icons.place, color: Colors.red, size: 60),
                        Text('Device - 1 (ID: 56xx21)'),
                      ],
                    ),
                ),
                ),
                Positioned(
                  bottom: 245,
                  right: 245,
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.place, color: Colors.black, size: 60),
                          Text('Device -2 (ID: 56XX27)'),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),

          Container(

            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black,
              ),

            ),
            margin: const EdgeInsets.only(top: 10),
            height: 75,
            width: 75,
            child: Center(
              child: Column(
                children: [
                  ImageIcon(
                    AssetImage('assets/soil.png'),
                    size: 120,
                  ),
                  Text('Soil type : red soil'),
                  ImageIcon(
                    AssetImage('assets/plant.png'),
                    size: 120,
                  ),
                  Text('Crop : Arecanut'),
                ],
              ),
            ),
          ),
          Container(

            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black,
              )
            ),
            margin: const EdgeInsets.only(top: 10),
            height: 75,
            width: 75,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Number of crops: 100'),
                  Text('Area of the plot: 120 sq m'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LiveData {
  final int time;
  final num speed;
  LiveData(this.time, this.speed);
}
