/// ========================================================
/// Charts Demo Page - صفحة تجريبية للرسوم البيانية
/// ========================================================
/// صفحة شاملة تعرض جميع أنواع الرسوم البيانية
/// مع أمثلة عملية وتفاعلية
/// ========================================================

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../helpers/chart_helper.dart';
import '../../../../widgets/app_widgets.dart';

class ChartsDemoPage extends StatefulWidget {
  static const String routeName = '/charts-demo';

  const ChartsDemoPage({super.key});

  @override
  State<ChartsDemoPage> createState() => _ChartsDemoPageState();
}

class _ChartsDemoPageState extends State<ChartsDemoPage> {
  int _selectedChartType = 0;

  // بيانات المبيعات الأسبوعية
  final List<double> _weeklySales = [10, 60, -12, 75, 85, 70, 90];
  final List<String> _weekDays = [
    'السبت',
    'الأحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  // بيانات توزيع المنتجات
  final List<double> _productDistribution = [40, 30, 20, 10];
  final List<String> _productNames = ['إلكترونيات', 'ملابس', 'أغذية', 'أخرى'];
  final List<Color> _productColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  // بيانات الأداء الشهري (3 فروع)
  final List<List<double>> _branchPerformance = [
    [65, 70, 55], // يناير
    [75, 80, 60], // فبراير
    [85, 75, 70], // مارس
    [90, 85, 75], // أبريل
  ];
  final List<String> _months = ['يناير', 'فبراير', 'مارس', 'أبريل'];
  final List<Color> _branchColors = [Colors.blue, Colors.red, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الرسوم البيانية - أمثلة شاملة لجميع أنواع Charts',
      ),
      body: Column(
        children: [
          // Chart Type Selector
          _buildChartTypeSelector(),

          // Charts Display
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Stats Cards
                  _buildStatsSection(),
                  const SizedBox(height: 16),

                  // Selected Chart
                  _buildSelectedChart(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// بناء محدد نوع الرسم البياني
  Widget _buildChartTypeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.grey[100],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildChartTypeButton(
              icon: Icons.show_chart,
              label: 'خط بياني',
              index: 0,
            ),
            _buildChartTypeButton(
              icon: Icons.bar_chart,
              label: 'أعمدة بيانية',
              index: 1,
            ),
            _buildChartTypeButton(
              icon: Icons.pie_chart,
              label: 'دائرة بيانية',
              index: 2,
            ),
            _buildChartTypeButton(
              icon: Icons.donut_large,
              label: 'دونات',
              index: 3,
            ),
            _buildChartTypeButton(
              icon: Icons.stacked_bar_chart,
              label: 'أعمدة مجمعة',
              index: 4,
            ),
            _buildChartTypeButton(
              icon: Icons.multiline_chart,
              label: 'خطوط متعددة',
              index: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartTypeButton({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedChartType == index;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Material(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: isSelected ? 4 : 1,
        child: InkWell(
          onTap: () => setState(() => _selectedChartType = index),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.blue,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// قسم الإحصائيات
  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الإحصائيات الرئيسية',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatsCard(
                title: 'إجمالي المبيعات',
                value: '475',
                icon: Icons.attach_money,
                color: Colors.green,
                subtitle: '+12%',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatsCard(
                title: 'عدد الطلبات',
                value: '1,234',
                icon: Icons.shopping_cart,
                color: Colors.blue,
                subtitle: '+8%',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatsCard(
                title: 'العملاء الجدد',
                value: '856',
                icon: Icons.people,
                color: Colors.orange,
                subtitle: '+15%',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatsCard(
                title: 'المنتجات',
                value: '342',
                icon: Icons.inventory,
                color: Colors.purple,
                subtitle: '+5%',
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// بناء الرسم البياني المختار
  Widget _buildSelectedChart() {
    switch (_selectedChartType) {
      case 0:
        return _buildLineChart();
      case 1:
        return _buildBarChart();
      case 2:
        return _buildPieChart();
      case 3:
        return _buildDonutChart();
      case 4:
        return _buildGroupedBarChart();
      case 5:
        return _buildMultiLineChart();
      default:
        return _buildLineChart();
    }
  }

  /// Line Chart - المبيعات الأسبوعية
  Widget _buildLineChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Line Chart - المبيعات الأسبوعية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'رسم بياني يوضح تطور المبيعات خلال أيام الأسبوع',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        CustomLineChartWidget(
          data: _weeklySales,
          title: 'المبيعات (بالألف جنيه)',
          color: Colors.blue,
          gradientColors: [Colors.blue, Colors.lightBlueAccent],
          height: 300,
        ),
        const SizedBox(height: 16),
        _buildChartInfo([
          'الخط البياني يوضح الاتجاه العام للمبيعات',
          'أعلى مبيعات: ${ChartHelper.getMaxValue(_weeklySales).toStringAsFixed(0)} ألف',
          'المتوسط: ${ChartHelper.getAverage(_weeklySales).toStringAsFixed(1)} ألف',
          'يدعم Touch Interaction لعرض التفاصيل',
        ]),
      ],
    );
  }

  /// Bar Chart - المبيعات الأسبوعية
  Widget _buildBarChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bar Chart - المبيعات الأسبوعية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'رسم بياني بالأعمدة لمقارنة المبيعات اليومية',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        CustomBarChartWidget(
          values: _weeklySales,
          labels: _weekDays,
          title: 'المبيعات اليومية (بالألف)',
          barColor: Colors.green,
          height: 300,
        ),
        const SizedBox(height: 16),
        _buildChartInfo([
          'الأعمدة تسهل المقارنة المباشرة بين الأيام',
          'أفضل يوم: الجمعة (${_weeklySales.last.toStringAsFixed(0)} ألف)',
          'اضغط على أي عمود لرؤية القيمة الدقيقة',
        ]),
      ],
    );
  }

  /// Pie Chart - توزيع المنتجات
  Widget _buildPieChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pie Chart - توزيع المنتجات',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'رسم دائري يوضح النسب المئوية لكل فئة',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        CustomPieChartWidget(
          values: _productDistribution,
          labels: _productNames,
          colors: _productColors,
          title: 'توزيع المبيعات حسب الفئة',
          height: 250,
        ),
        const SizedBox(height: 16),
        _buildChartInfo([
          'الدائرة البيانية تعرض النسب المئوية',
          'الفئة الأكثر مبيعاً: إلكترونيات (40%)',
          'Legend على الجانب لتوضيح الفئات',
        ]),
      ],
    );
  }

  /// Donut Chart - توزيع المنتجات
  Widget _buildDonutChart() {
    final total = _productDistribution.fold(0.0, (sum, value) => sum + value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Donut Chart - توزيع المنتجات',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'رسم دائري مفرغ مع إجمالي في المنتصف',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        CustomDonutChartWidget(
          values: _productDistribution,
          labels: _productNames,
          colors: _productColors,
          title: 'توزيع المبيعات (Donut)',
          height: 250,
          centerWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                total.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Text(
                'المجموع',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildChartInfo([
          'Donut Chart مثل Pie لكن مع مساحة في المنتصف',
          'يمكن عرض معلومات إضافية في المركز',
          'أنيق للعرض وسهل القراءة',
        ]),
      ],
    );
  }

  /// Grouped Bar Chart - أداء الفروع
  Widget _buildGroupedBarChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Grouped Bar Chart - أداء الفروع',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'مقارنة أداء 3 فروع على مدار 4 أشهر',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أداء الفروع الشهري',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('الفرع الأول', _branchColors[0]),
                    const SizedBox(width: 16),
                    _buildLegendItem('الفرع الثاني', _branchColors[1]),
                    const SizedBox(width: 16),
                    _buildLegendItem('الفرع الثالث', _branchColors[2]),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: BarChart(
                    ChartHelper.createGroupedBarChart(
                      groups: _branchPerformance,
                      labels: _months,
                      colors: _branchColors,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildChartInfo([
          'الأعمدة المجمعة تسمح بمقارنة عدة عناصر',
          'كل شهر يحتوي على 3 أعمدة (واحد لكل فرع)',
          'مفيد لتحليل الأداء المقارن',
        ]),
      ],
    );
  }

  /// Multi Line Chart - خطوط متعددة
  Widget _buildMultiLineChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Multi Line Chart - خطوط متعددة',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'مقارنة أداء 3 فروع بخطوط بيانية متعددة',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أداء الفروع (خطوط)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('الفرع الأول', _branchColors[0]),
                    const SizedBox(width: 16),
                    _buildLegendItem('الفرع الثاني', _branchColors[1]),
                    const SizedBox(width: 16),
                    _buildLegendItem('الفرع الثالث', _branchColors[2]),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: LineChart(
                    ChartHelper.createMultiLineChart(
                      lines: [
                        // الفرع الأول
                        LineChartBarData(
                          spots: List.generate(
                            _branchPerformance.length,
                            (i) =>
                                FlSpot(i.toDouble(), _branchPerformance[i][0]),
                          ),
                          color: _branchColors[0],
                          barWidth: 3,
                          isCurved: true,
                          dotData: const FlDotData(show: true),
                        ),
                        // الفرع الثاني
                        LineChartBarData(
                          spots: List.generate(
                            _branchPerformance.length,
                            (i) =>
                                FlSpot(i.toDouble(), _branchPerformance[i][1]),
                          ),
                          color: _branchColors[1],
                          barWidth: 3,
                          isCurved: true,
                          dotData: const FlDotData(show: true),
                        ),
                        // الفرع الثالث
                        LineChartBarData(
                          spots: List.generate(
                            _branchPerformance.length,
                            (i) =>
                                FlSpot(i.toDouble(), _branchPerformance[i][2]),
                          ),
                          color: _branchColors[2],
                          barWidth: 3,
                          isCurved: true,
                          dotData: const FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildChartInfo([
          'الخطوط المتعددة تعرض الاتجاهات المختلفة',
          'كل خط يمثل فرع وتطور أدائه',
          'سهولة رؤية التقاطعات والفروقات',
        ]),
      ],
    );
  }

  /// Legend Item
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// معلومات عن الرسم البياني
  Widget _buildChartInfo(List<String> points) {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'معلومات',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...points.map(
              (point) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: Colors.blue)),
                    Expanded(
                      child: Text(point, style: const TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 📝 شرح الـ Charts Demo Page:
/// -----------------------------
/// 1. يعرض جميع أنواع الرسوم البيانية المتاحة
/// 2. يحتوي على بيانات واقعية للتجربة
/// 3. يدعم التبديل بين أنواع مختلفة
/// 4. يعرض Stats Cards في البداية
/// 5. كل رسم بياني مع شرح وتوضيحات
/// 
/// 🎯 أنواع الرسوم:
/// - Line Chart: خط بياني واحد
/// - Bar Chart: أعمدة بيانية
/// - Pie Chart: دائرة بيانية
/// - Donut Chart: دائرة مفرغة
/// - Grouped Bar Chart: أعمدة مجمعة
/// - Multi Line Chart: خطوط متعددة
/// 
/// 📊 البيانات:
/// - بيانات مبيعات أسبوعية
/// - توزيع منتجات
/// - أداء فروع شهري
/// 
/// ⚠️ ملاحظات:
/// - استخدم ChartHelper للمساعدة
/// - استخدم Chart Widgets الجاهزة
/// - يمكن تخصيص كل عنصر
/// - يدعم Touch Interactions
