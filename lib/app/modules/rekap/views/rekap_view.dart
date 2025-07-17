import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/rekap/controllers/rekap_controller.dart';
import 'package:get/get.dart';

class RekapView extends GetView<RekapController> {
  const RekapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekap Transaksi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value == true) {
          return CircularProgressIndicator();
        }

        final income = controller.totalIncome.value;
        final expense = controller.totalExpense.value;
        final total = income + expense;

        if (total == 0) {
          return RefreshIndicator(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Persentase Pemasukan & Pengeluaran",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  AspectRatio(
                    aspectRatio: 1.6,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.grey,
                            value: 100,
                            title: "",
                            radius: 80,
                            titleStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onRefresh: () => controller.getSummary(),
          );
        }

        return RefreshIndicator(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Persentase Pemasukan & Pengeluaran",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                AspectRatio(
                  aspectRatio: 1.6,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.green,
                          value: income,
                          title:
                              "${((income / total) * 100).toStringAsFixed(1)}%",
                          radius: 80,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: expense,
                          title:
                              "${((expense / total) * 100).toStringAsFixed(1)}%",
                          radius: 80,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegend(Colors.green, "Pemasukan"),
                    const SizedBox(width: 16),
                    _buildLegend(Colors.red, "Pengeluaran"),
                  ],
                ),
              ],
            ),
          ),
          onRefresh: () => controller.getSummary(),
        );
      }),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
