// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/modules/home/home_controller.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';

class FlChartWidget extends GetView<HomeController> {
  const FlChartWidget({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.expenseSpots.isNotEmpty ||
          controller.incomeSpots.isNotEmpty) {
        return LineChart(
          sampleData1(),
          duration: const Duration(milliseconds: 250),
        );
      } else {
        // Tampilkan indikator loading atau pesan lain jika data belum siap
        return Center(
          child: Text(
            'Data Masih Kosong, belum bisa tracking',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }
    });
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineBarsData: lineBarsData1(),
      titlesData: titlesData1(),
      borderData: borderData(),
      gridData: gridData(),
      lineTouchData: lineTouchData1(),
    );
  }

  LineTouchData lineTouchData1() {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.5),
      ),
    );
  }

  FlTitlesData titlesData1() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles(),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles(),
      ),
    );
  }

  List<LineChartBarData> lineBarsData1() {
    return [
      lineChartBarData1_1(),
      lineChartBarData1_2(),
    ];
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.white,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Rp 0';
        break;
      case 100000:
        text = 'Rp 100.000';
        break;
      case 500000:
        text = 'Rp 500.000';
        break;
      case 1000000:
        text = 'Rp 1.000.000';
        break;
      case 1500000:
        text = 'Rp 1.500.000';
        break;
      case 2000000:
        text = 'Rp 2.000.000';
        break;
      default:
        return Container();
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() {
    return SideTitles(
      getTitlesWidget: leftTitleWidgets,
      showTitles: true,
      interval: 500000,
      reservedSize: 100,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.white,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        value.toInt().toString(),
        style: style,
      ),
    );
  }

  SideTitles bottomTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: bottomTitleWidgets,
    );
  }

  FlGridData gridData() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      horizontalInterval: 500000,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 0.5,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 0.5,
        );
      },
    );
  }

  FlBorderData borderData() {
    return FlBorderData(
      show: true,
      border: Border(
        bottom: BorderSide(
          color: AppColor.contentColorWhite.withOpacity(0.5),
          width: 3,
        ),
        left: const BorderSide(color: Colors.transparent),
        right: const BorderSide(color: Colors.transparent),
        top: const BorderSide(color: Colors.transparent),
      ),
    );
  }

  LineChartBarData lineChartBarData1_1() {
    return LineChartBarData(
      color: AppColor.contentColorRed,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      spots: controller.expenseSpots,
    );
  }

  LineChartBarData lineChartBarData1_2() {
    return LineChartBarData(
      color: AppColor.contentColorGreen,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(
        show: true,
        color: AppColor.contentColorRed.withOpacity(0),
      ),
      spots: controller.incomeSpots,
    );
  }
}
