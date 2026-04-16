import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WealthProjectionChart extends StatelessWidget {
  final double monthlySavings;

  const WealthProjectionChart({
    super.key,
    required this.monthlySavings,
  });

  @override
  Widget build(BuildContext context) {

    List<FlSpot> spots = [];

    for (int year = 0; year <= 10; year++) {
      double value = monthlySavings * 12 * year;
      spots.add(FlSpot(year.toDouble(), value));
    }

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text("${value.toInt()}y");
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 4,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}