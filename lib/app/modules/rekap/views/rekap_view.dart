import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RekapView extends StatelessWidget {
  const RekapView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data: tanggal dan total amount
    final List<Map<String, dynamic>> dummyData = [
      {"date": "24 Apr", "amount": 50000.0},
      {"date": "25 Apr", "amount": 30000.0},
      {"date": "26 Apr", "amount": 70000.0},
      {"date": "27 Apr", "amount": 20000.0},
    ];

    // Cari amount terbesar (buat maxY di chart)
    final double maxAmount = dummyData
        .map((e) => e["amount"] as double)
        .reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekap Transaksi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Grafik Transaksi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 1.6,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxAmount * 1.2,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= dummyData.length) {
                            return const SizedBox();
                          }
                          return Text(dummyData[index]["date"]);
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups:
                      dummyData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data["amount"],
                              color: Colors.blueAccent,
                              width: 22,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
