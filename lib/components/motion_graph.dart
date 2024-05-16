// ignore_for_file: prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Motion sensor graph widget
class MotionSensorGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final List<BarChartGroupData> motionData = [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 0)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 2)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 5)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 8)]),
      BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 10)]),
    ];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 12,
        groupsSpace: 20,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
              // getTooltipColor: () => {Colors.transparent},
              ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String str = value.toString();
                const style = TextStyle(fontSize: 12, color: Colors.white);
                str = str + 'hr';
                return FittedBox(
                  child: Text(str, style: style, textAlign: TextAlign.center),
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String str = value.toString();
                const style = TextStyle(fontSize: 12, color: Colors.white);
                str = str + 'stp';
                return FittedBox(
                  child: Text(str, style: style, textAlign: TextAlign.center),
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: motionData,
      ),
    );
  }
}
