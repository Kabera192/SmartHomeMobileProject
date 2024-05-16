import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LightSensorGraph extends StatefulWidget {
  final Stream<double> lightStream;

  const LightSensorGraph({Key? key, this.lightStream = const Stream.empty()}) : super(key: key);

  @override
  _LightSensorGraphState createState() => _LightSensorGraphState();
}

class _LightSensorGraphState extends State<LightSensorGraph> {
  List<FlSpot> lightData = []; // List to store light sensor data

  @override
  void initState() {
    super.initState();
    // Listen to the light sensor data stream
    widget.lightStream.listen((lightLevel) {
      setState(() {
        // Add the new data point to the list
        // You can adjust the x-axis values based on your requirements
        lightData.add(FlSpot(lightData.length.toDouble(), lightLevel));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: LineChart(
        LineChartData(
          // Y-axis configuration
          minY: 0, // Minimum value on the y-axis
          maxY: 100, // Maximum value on the y-axis
          titlesData: FlTitlesData(
            // Title settings for the y-axis
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 20, // Interval between values on the y-axis
              getTitlesWidget: (value, meta) {
              String str = value.toString();
              const style = TextStyle(fontSize: 12, color: Colors.white);
              str = str + 'lux';
              return FittedBox(
                child: Text(str, style: style, textAlign: TextAlign.center),
                fit: BoxFit.fitWidth,
              );
            },
            ),
          ),
          ),
          // X-axis configuration (optional)
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
          ),
          // Line chart data
          lineBarsData: [
            LineChartBarData(
              spots: lightData,
              isCurved: true,
              color: Colors.blue, // Color of the line
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
