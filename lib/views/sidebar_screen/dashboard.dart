import 'package:flutter/material.dart';
import 'package:expense_dashboard/model/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  static const String id = 'dashboard-page';

  final List<ExpenseModel> expenses;

  DashboardPage({Key? key, this.expenses = const []}) : super(key: key);

  double getTotalExpenses() {
    double total = 0;
    for (var e in expenses) {
      try {
        total += double.parse(e.amount);
      } catch (_) {}
    }
    return total;
  }

  Map<String, double> groupByDate() {
    Map<String, double> map = {};
    for (var e in expenses) {
      double val = 0;
      try {
        val = double.parse(e.amount);
      } catch (_) {}
      map[e.date] = (map[e.date] ?? 0) + val;
    }
    return map;
  }

  Map<String, double> groupByCategory() {
    Map<String, double> map = {};
    for (var e in expenses) {
      double val = 0;
      try {
        val = double.parse(e.amount);
      } catch (_) {}
      map[e.categories] = (map[e.categories] ?? 0) + val;
    }
    return map;
  }

  List<Color> getChartColors() {
    return [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.brown,
      Colors.cyan,
    ];
  }

  List<PieChartSectionData> buildPieSections(Map<String, double> data) {
    final colors = getChartColors();
    int i = 0;
    final total = data.values.fold(0.0, (a, b) => a + b);
    return data.entries.map((entry) {
      final value = entry.value;
      final percent = total == 0 ? 0 : (value / total) * 100;
      final color = colors[i % colors.length];
      i++;
      return PieChartSectionData(
        color: color,
        value: value,
        title: '${entry.key}\n${percent.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<BarChartGroupData> buildBarGroups(Map<String, double> data) {
    final sortedKeys = data.keys.toList()..sort();
    int x = 0;
    return sortedKeys.map((key) {
      final y = data[key]!;
      final group = BarChartGroupData(
        x: x++,
        barRods: [
          BarChartRodData(
            toY: y,
            width: 16,
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      );
      return group;
    }).toList();
  }

  Widget buildLegend(Map<String, double> data, List<Color> colors) {
    final total = data.values.fold(0.0, (a, b) => a + b);
    final entries = data.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(entries.length, (i) {
        final category = entries[i].key;
        final value = entries[i].value;
        final percent = total == 0 ? 0 : (value / total) * 100;
        final color = colors[i % colors.length];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(width: 12, height: 12, color: color),
              const SizedBox(width: 8),
              Text('$category - ${percent.toStringAsFixed(1)}%'),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = getTotalExpenses();
    final expensesByDate = groupByDate();
    final expensesByCategory = groupByCategory();
    final barGroups = buildBarGroups(expensesByDate);
    final chartColors = getChartColors();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Total Expenses'),
              subtitle: Text('\$${totalExpenses.toStringAsFixed(2)}'),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            'Expenses by Category',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: buildPieSections(expensesByCategory),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),

          const SizedBox(height: 20),

          buildLegend(expensesByCategory, chartColors),

          const SizedBox(height: 30),

          Text(
            'Expenses by Date',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (expensesByDate.values.isEmpty)
                    ? 0
                    : (expensesByDate.values.reduce((a, b) => a > b ? a : b)) *
                          1.2,
                barGroups: barGroups,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= expensesByDate.keys.length) {
                          return const SizedBox.shrink();
                        }
                        final dateLabel = expensesByDate.keys.toList()[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            dateLabel,
                            style: const TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      reservedSize: 60,
                    ),
                  ),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
