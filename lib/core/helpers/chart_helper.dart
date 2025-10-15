/// ========================================================
/// Chart Helper - مساعد الرسوم البيانية
/// ========================================================
/// يحتوي على دوال مساعدة لإنشاء وتخصيص الرسوم البيانية
/// باستخدام مكتبة fl_chart
/// ========================================================

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// 📊 Chart Helper Class
class ChartHelper {
  ChartHelper._();

  // ==================== Line Chart Helpers ====================

  /// إنشاء Line Chart Data بسيط
  ///
  /// Example:
  /// ```dart
  /// final lineData = ChartHelper.createSimpleLineChart(
  ///   spots: [FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2)],
  ///   color: Colors.blue,
  /// );
  /// ```
  static LineChartData createSimpleLineChart({
    required List<FlSpot> spots,
    Color color = Colors.blue,
    String? title,
    bool showDots = true,
    bool isCurved = true,
    double strokeWidth = 3.0,
    List<Color>? gradientColors,
  }) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                spot.y.toStringAsFixed(1),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: isCurved,
          color: color,
          barWidth: strokeWidth,
          isStrokeCapRound: true,
          dotData: FlDotData(show: showDots),
          belowBarData: BarAreaData(
            show: gradientColors != null,
            gradient: gradientColors != null
                ? LinearGradient(
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  /// إنشاء Line Chart مع عدة خطوط
  static LineChartData createMultiLineChart({
    required List<LineChartBarData> lines,
    String? title,
  }) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toStringAsFixed(1)}',
                TextStyle(color: spot.bar.color, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      lineBarsData: lines,
    );
  }

  // ==================== Bar Chart Helpers ====================

  /// إنشاء Bar Chart Data بسيط
  ///
  /// Example:
  /// ```dart
  /// final barData = ChartHelper.createSimpleBarChart(
  ///   values: [10, 20, 15, 25, 30],
  ///   labels: ['A', 'B', 'C', 'D', 'E'],
  /// );
  /// ```
  static BarChartData createSimpleBarChart({
    required List<double> values,
    List<String>? labels,
    Color barColor = Colors.blue,
    double barWidth = 22,
  }) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: values.reduce((a, b) => a > b ? a : b) * 1.2,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toStringAsFixed(1),
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (labels != null && value.toInt() < labels.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    labels[value.toInt()],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
        },
      ),
      barGroups: List.generate(
        values.length,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: values[index],
              color: barColor,
              width: barWidth,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// إنشاء Bar Chart مع عدة مجموعات
  static BarChartData createGroupedBarChart({
    required List<List<double>> groups,
    List<String>? labels,
    List<Color>? colors,
    double barWidth = 18,
  }) {
    final defaultColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];
    final barColors = colors ?? defaultColors;

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toStringAsFixed(1),
              TextStyle(color: rod.color, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (labels != null && value.toInt() < labels.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    labels[value.toInt()],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(0),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
        },
      ),
      barGroups: List.generate(
        groups.length,
        (groupIndex) => BarChartGroupData(
          x: groupIndex,
          barRods: List.generate(
            groups[groupIndex].length,
            (rodIndex) => BarChartRodData(
              toY: groups[groupIndex][rodIndex],
              color: barColors[rodIndex % barColors.length],
              width: barWidth,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==================== Pie Chart Helpers ====================

  /// إنشاء Pie Chart Data بسيط
  ///
  /// Example:
  /// ```dart
  /// final pieData = ChartHelper.createSimplePieChart(
  ///   values: [40, 30, 20, 10],
  ///   labels: ['A', 'B', 'C', 'D'],
  /// );
  /// ```
  static PieChartData createSimplePieChart({
    required List<double> values,
    List<String>? labels,
    List<Color>? colors,
    double radius = 100,
    bool showPercentage = true,
  }) {
    final defaultColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];
    final sectionColors = colors ?? defaultColors;

    final total = values.fold(0.0, (sum, value) => sum + value);

    return PieChartData(
      sectionsSpace: 2,
      centerSpaceRadius: 0,
      sections: List.generate(values.length, (index) {
        final percentage = (values[index] / total * 100).toStringAsFixed(1);
        return PieChartSectionData(
          value: values[index],
          title: showPercentage ? '$percentage%' : labels?[index] ?? '',
          color: sectionColors[index % sectionColors.length],
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }),
    );
  }

  /// إنشاء Donut Chart (Pie Chart مع مساحة في المنتصف)
  static PieChartData createDonutChart({
    required List<double> values,
    List<String>? labels,
    List<Color>? colors,
    double radius = 100,
    double centerSpaceRadius = 50,
    bool showPercentage = true,
  }) {
    final defaultColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];
    final sectionColors = colors ?? defaultColors;

    final total = values.fold(0.0, (sum, value) => sum + value);

    return PieChartData(
      sectionsSpace: 2,
      centerSpaceRadius: centerSpaceRadius,
      sections: List.generate(values.length, (index) {
        final percentage = (values[index] / total * 100).toStringAsFixed(1);
        return PieChartSectionData(
          value: values[index],
          title: showPercentage ? '$percentage%' : labels?[index] ?? '',
          color: sectionColors[index % sectionColors.length],
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }),
    );
  }

  // ==================== Utility Functions ====================

  /// تحويل قائمة من الأرقام إلى FlSpot للـ Line Chart
  static List<FlSpot> numbersToSpots(List<double> numbers) {
    return List.generate(
      numbers.length,
      (index) => FlSpot(index.toDouble(), numbers[index]),
    );
  }

  /// إنشاء ألوان متدرجة
  static List<Color> createGradientColors(Color startColor, Color endColor) {
    return [startColor, endColor];
  }

  /// الحصول على أقصى قيمة في القائمة
  static double getMaxValue(List<double> values) {
    return values.reduce((a, b) => a > b ? a : b);
  }

  /// الحصول على أقل قيمة في القائمة
  static double getMinValue(List<double> values) {
    return values.reduce((a, b) => a < b ? a : b);
  }

  /// حساب المتوسط
  static double getAverage(List<double> values) {
    return values.fold(0.0, (sum, value) => sum + value) / values.length;
  }

  /// إنشاء بيانات عشوائية للتجربة
  static List<double> generateRandomData(int count, {double max = 100}) {
    return List.generate(
      count,
      (index) => (max * (0.3 + 0.7 * (index % 3) / 2)),
    );
  }
}

/// 📝 شرح الـ Chart Helper:
/// ------------------------
/// 1. createSimpleLineChart: لإنشاء Line Chart بخط واحد
/// 2. createMultiLineChart: لإنشاء Line Chart بعدة خطوط
/// 3. createSimpleBarChart: لإنشاء Bar Chart بسيط
/// 4. createGroupedBarChart: لإنشاء Bar Chart مع عدة مجموعات
/// 5. createSimplePieChart: لإنشاء Pie Chart بسيط
/// 6. createDonutChart: لإنشاء Donut Chart (دائرة مفرغة)
/// 
/// 🎯 Utility Functions:
/// - numbersToSpots: تحويل أرقام إلى نقاط للـ Line Chart
/// - createGradientColors: إنشاء تدرج لوني
/// - getMaxValue / getMinValue: الحصول على أقصى/أقل قيمة
/// - getAverage: حساب المتوسط
/// - generateRandomData: إنشاء بيانات عشوائية للتجربة
/// 
/// ⚠️ ملاحظات:
/// - كل الدوال static للاستخدام المباشر
/// - الألوان الافتراضية جاهزة
/// - يمكن تخصيص كل عنصر
/// - يدعم Touch Interactions و Tooltips
