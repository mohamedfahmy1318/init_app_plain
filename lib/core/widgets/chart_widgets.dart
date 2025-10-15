/// ========================================================
/// Chart Widgets - Widgets جاهزة للرسوم البيانية
/// ========================================================
/// Widgets معدّة مسبقاً للاستخدام المباشر
/// ========================================================

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../helpers/chart_helper.dart';

// ==================== Custom Line Chart Widget ====================

/// Widget جاهز لعرض Line Chart
///
/// Example:
/// ```dart
/// CustomLineChartWidget(
///   data: [10, 20, 15, 25, 30],
///   title: 'المبيعات اليومية',
///   color: Colors.blue,
/// )
/// ```
class CustomLineChartWidget extends StatelessWidget {
  final List<double> data;
  final String? title;
  final Color color;
  final bool showDots;
  final bool isCurved;
  final List<Color>? gradientColors;
  final double height;

  const CustomLineChartWidget({
    super.key,
    required this.data,
    this.title,
    this.color = Colors.blue,
    this.showDots = true,
    this.isCurved = true,
    this.gradientColors,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              height: height,
              child: LineChart(
                ChartHelper.createSimpleLineChart(
                  spots: ChartHelper.numbersToSpots(data),
                  color: color,
                  showDots: showDots,
                  isCurved: isCurved,
                  gradientColors: gradientColors,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== Custom Bar Chart Widget ====================

/// Widget جاهز لعرض Bar Chart
///
/// Example:
/// ```dart
/// CustomBarChartWidget(
///   values: [10, 20, 15, 25, 30],
///   labels: ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'],
///   title: 'المبيعات الأسبوعية',
/// )
/// ```
class CustomBarChartWidget extends StatelessWidget {
  final List<double> values;
  final List<String>? labels;
  final String? title;
  final Color barColor;
  final double height;
  final double barWidth;

  const CustomBarChartWidget({
    super.key,
    required this.values,
    this.labels,
    this.title,
    this.barColor = Colors.blue,
    this.height = 250,
    this.barWidth = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              height: height,
              child: BarChart(
                ChartHelper.createSimpleBarChart(
                  values: values,
                  labels: labels,
                  barColor: barColor,
                  barWidth: barWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== Custom Pie Chart Widget ====================

/// Widget جاهز لعرض Pie Chart
///
/// Example:
/// ```dart
/// CustomPieChartWidget(
///   values: [40, 30, 20, 10],
///   labels: ['منتج أ', 'منتج ب', 'منتج ج', 'منتج د'],
///   title: 'توزيع المبيعات',
/// )
/// ```
class CustomPieChartWidget extends StatelessWidget {
  final List<double> values;
  final List<String>? labels;
  final String? title;
  final List<Color>? colors;
  final double radius;
  final bool showPercentage;
  final double height;

  const CustomPieChartWidget({
    super.key,
    required this.values,
    this.labels,
    this.title,
    this.colors,
    this.radius = 100,
    this.showPercentage = true,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              height: height,
              child: Row(
                children: [
                  // Pie Chart
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      ChartHelper.createSimplePieChart(
                        values: values,
                        labels: labels,
                        colors: colors,
                        radius: radius,
                        showPercentage: showPercentage,
                      ),
                    ),
                  ),
                  // Legend
                  if (labels != null)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          values.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color:
                                        colors?[index] ??
                                        _getDefaultColor(index),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    labels![index],
                                    style: const TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDefaultColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];
    return colors[index % colors.length];
  }
}

// ==================== Custom Donut Chart Widget ====================

/// Widget جاهز لعرض Donut Chart
///
/// Example:
/// ```dart
/// CustomDonutChartWidget(
///   values: [40, 30, 20, 10],
///   labels: ['فئة أ', 'فئة ب', 'فئة ج', 'فئة د'],
///   title: 'التوزيع النسبي',
/// )
/// ```
class CustomDonutChartWidget extends StatelessWidget {
  final List<double> values;
  final List<String>? labels;
  final String? title;
  final List<Color>? colors;
  final double radius;
  final double centerSpaceRadius;
  final bool showPercentage;
  final double height;
  final Widget? centerWidget;

  const CustomDonutChartWidget({
    super.key,
    required this.values,
    this.labels,
    this.title,
    this.colors,
    this.radius = 100,
    this.centerSpaceRadius = 50,
    this.showPercentage = true,
    this.height = 250,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    final total = values.fold(0.0, (sum, value) => sum + value);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              height: height,
              child: Row(
                children: [
                  // Donut Chart
                  Expanded(
                    flex: 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          ChartHelper.createDonutChart(
                            values: values,
                            labels: labels,
                            colors: colors,
                            radius: radius,
                            centerSpaceRadius: centerSpaceRadius,
                            showPercentage: showPercentage,
                          ),
                        ),
                        // Center Widget
                        if (centerWidget != null)
                          centerWidget!
                        else
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                total.toStringAsFixed(0),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'المجموع',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  // Legend
                  if (labels != null)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          values.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color:
                                        colors?[index] ??
                                        _getDefaultColor(index),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    labels![index],
                                    style: const TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDefaultColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];
    return colors[index % colors.length];
  }
}

// ==================== Stats Card Widget ====================

/// Widget لعرض إحصائية واحدة
///
/// Example:
/// ```dart
/// StatsCard(
///   title: 'إجمالي المبيعات',
///   value: '12,450',
///   icon: Icons.attach_money,
///   color: Colors.green,
/// )
/// ```
class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final VoidCallback? onTap;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color = Colors.blue,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: color, size: 32),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 📝 شرح الـ Chart Widgets:
/// -------------------------
/// 1. CustomLineChartWidget: Line Chart جاهز للاستخدام
/// 2. CustomBarChartWidget: Bar Chart جاهز للاستخدام
/// 3. CustomPieChartWidget: Pie Chart مع Legend
/// 4. CustomDonutChartWidget: Donut Chart مع المجموع في المنتصف
/// 5. StatsCard: كارت لعرض إحصائية واحدة
/// 
/// 🎯 المميزات:
/// - كل Widget معدّ مسبقاً وجاهز للاستخدام
/// - يمكن تخصيص الألوان والأحجام
/// - يدعم العربية
/// - تصميم Material Design
/// - Responsive
/// 
/// ⚠️ ملاحظات:
/// - استخدم ChartHelper للتخصيص المتقدم
/// - كل Widget يأتي مع Card وPadding
/// - يمكن تخصيص الـ height لكل Widget
