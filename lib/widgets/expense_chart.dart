import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseChart extends StatelessWidget {

  final double expenses;
  final double savings;

  const ExpenseChart({
    super.key,
    required this.expenses,
    required this.savings,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: expenses,
              color: Colors.red,
              title: "Expenses",
            ),
            PieChartSectionData(
              value: savings,
              color: Colors.green,
              title: "Savings",
            ),
          ],
        ),
      ),
    );
  }
}
