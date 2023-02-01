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
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  void initState() {
    super.initState();
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
  }

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
      body: Column(
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
          buttonSection,
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

Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildButtonColumn(Colors.blue, Icons.device_thermostat, 'temperature(C)', 36),
    _buildButtonColumn(Colors.blue, Icons.water_drop, 'Humidity(%)', 34),
  ],
);
Column _buildButtonColumn(Color color, IconData icon, String label, int val) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color, size: 30.0),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label + " : " + val.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}
