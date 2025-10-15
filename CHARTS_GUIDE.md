# 📊 دليل الرسوم البيانية (Charts Guide)

دليل شامل لاستخدام الرسوم البيانية في التطبيق باستخدام مكتبة `fl_chart`.

---

## 📦 المكتبة المستخدمة

```yaml
dependencies:
  fl_chart: ^0.69.0
```

**لماذا fl_chart؟**
- ✅ مجانية ومفتوحة المصدر
- ✅ تدعم جميع أنواع الرسوم البيانية
- ✅ قابلة للتخصيص بالكامل
- ✅ أداء ممتاز
- ✅ Animations جميلة
- ✅ تدعم Touch Interactions

---

## 🎯 أنواع الرسوم البيانية المتوفرة

### 1. Line Chart (الخط البياني) 📈
**الاستخدام**: عرض اتجاهات البيانات عبر الوقت

```dart
CustomLineChartWidget(
  data: [10, 20, 15, 25, 30, 22, 28],
  title: 'المبيعات اليومية',
  color: Colors.blue,
  showDots: true,
  isCurved: true,
  gradientColors: [Colors.blue, Colors.lightBlueAccent],
)
```

### 2. Bar Chart (الأعمدة البيانية) 📊
**الاستخدام**: مقارنة البيانات بين فئات مختلفة

```dart
CustomBarChartWidget(
  values: [45, 60, 50, 75, 85],
  labels: ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو'],
  title: 'المبيعات الشهرية',
  barColor: Colors.green,
)
```

### 3. Pie Chart (الدائرة البيانية) 🥧
**الاستخدام**: عرض النسب المئوية والتوزيعات

```dart
CustomPieChartWidget(
  values: [40, 30, 20, 10],
  labels: ['إلكترونيات', 'ملابس', 'أغذية', 'أخرى'],
  title: 'توزيع المبيعات',
  colors: [Colors.blue, Colors.red, Colors.green, Colors.orange],
)
```

### 4. Donut Chart (الدائرة المفرغة) 🍩
**الاستخدام**: مثل Pie Chart لكن مع مساحة في المنتصف

```dart
CustomDonutChartWidget(
  values: [40, 30, 20, 10],
  labels: ['فئة أ', 'فئة ب', 'فئة ج', 'فئة د'],
  title: 'التوزيع النسبي',
  centerWidget: Column(
    children: [
      Text('100', style: TextStyle(fontSize: 24)),
      Text('المجموع'),
    ],
  ),
)
```

### 5. Grouped Bar Chart (أعمدة مجمعة) 📊📊
**الاستخدام**: مقارنة عدة مجموعات في نفس الوقت

```dart
// في الكود مباشرة
BarChart(
  ChartHelper.createGroupedBarChart(
    groups: [
      [65, 70, 55], // يناير - 3 فروع
      [75, 80, 60], // فبراير - 3 فروع
      [85, 75, 70], // مارس - 3 فروع
    ],
    labels: ['يناير', 'فبراير', 'مارس'],
    colors: [Colors.blue, Colors.red, Colors.green],
  ),
)
```

### 6. Multi Line Chart (خطوط متعددة) 📈📈
**الاستخدام**: مقارنة عدة اتجاهات في نفس الوقت

```dart
LineChart(
  ChartHelper.createMultiLineChart(
    lines: [
      LineChartBarData(
        spots: [FlSpot(0, 3), FlSpot(1, 4), FlSpot(2, 5)],
        color: Colors.blue,
      ),
      LineChartBarData(
        spots: [FlSpot(0, 2), FlSpot(1, 3), FlSpot(2, 4)],
        color: Colors.red,
      ),
    ],
  ),
)
```

---

## 🛠️ ChartHelper - الدوال المساعدة

### تحويل البيانات

```dart
// تحويل أرقام إلى نقاط Line Chart
List<FlSpot> spots = ChartHelper.numbersToSpots([10, 20, 15, 25]);

// إنشاء تدرج لوني
List<Color> gradient = ChartHelper.createGradientColors(
  Colors.blue,
  Colors.lightBlue,
);
```

### تحليل البيانات

```dart
List<double> data = [10, 20, 15, 25, 30];

// أقصى قيمة
double max = ChartHelper.getMaxValue(data); // 30

// أقل قيمة
double min = ChartHelper.getMinValue(data); // 10

// المتوسط
double avg = ChartHelper.getAverage(data); // 20
```

### بيانات تجريبية

```dart
// إنشاء بيانات عشوائية للتجربة
List<double> randomData = ChartHelper.generateRandomData(7, max: 100);
```

---

## 🎨 التخصيص المتقدم

### تخصيص Line Chart

```dart
LineChartData(
  // Touch Interactions
  lineTouchData: LineTouchData(
    touchTooltipData: LineTouchTooltipData(
      getTooltipItems: (spots) {
        return spots.map((spot) {
          return LineTooltipItem(
            '${spot.y.toStringAsFixed(1)} جنيه',
            TextStyle(color: Colors.white),
          );
        }).toList();
      },
    ),
  ),
  
  // Grid Lines
  gridData: FlGridData(
    show: true,
    horizontalInterval: 10,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: Colors.grey.withOpacity(0.2),
        strokeWidth: 1,
      );
    },
  ),
  
  // Titles
  titlesData: FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text('Day ${value.toInt()}');
        },
      ),
    ),
  ),
  
  // Border
  borderData: FlBorderData(
    show: true,
    border: Border.all(color: Colors.grey),
  ),
  
  // Line Data
  lineBarsData: [
    LineChartBarData(
      spots: spots,
      isCurved: true,
      color: Colors.blue,
      barWidth: 3,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.3),
            Colors.blue.withOpacity(0.0),
          ],
        ),
      ),
    ),
  ],
)
```

### تخصيص Bar Chart

```dart
BarChartData(
  // Bar Touch
  barTouchData: BarTouchData(
    touchTooltipData: BarTouchTooltipData(
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        return BarTooltipItem(
          '${rod.toY.toStringAsFixed(0)} ألف',
          TextStyle(color: Colors.white),
        );
      },
    ),
  ),
  
  // Bar Groups
  barGroups: List.generate(values.length, (i) {
    return BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: values[i],
          color: Colors.blue,
          width: 22,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }),
)
```

### تخصيص Pie Chart

```dart
PieChartData(
  sectionsSpace: 2,
  centerSpaceRadius: 0, // للـ Donut Chart: 50
  sections: List.generate(values.length, (i) {
    return PieChartSectionData(
      value: values[i],
      title: '${percentage[i]}%',
      color: colors[i],
      radius: 100,
      titleStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }),
)
```

---

## 📊 StatsCard - كروت الإحصائيات

```dart
StatsCard(
  title: 'إجمالي المبيعات',
  value: '12,450',
  icon: Icons.attach_money,
  color: Colors.green,
  subtitle: '+12%',
  onTap: () {
    // عند الضغط
  },
)
```

---

## 🎯 أمثلة كاملة

### مثال 1: Dashboard بسيط

```dart
Column(
  children: [
    // Stats Cards
    Row(
      children: [
        Expanded(
          child: StatsCard(
            title: 'المبيعات',
            value: '1,234',
            icon: Icons.shopping_cart,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            title: 'العملاء',
            value: '856',
            icon: Icons.people,
            color: Colors.green,
          ),
        ),
      ],
    ),
    
    SizedBox(height: 16),
    
    // Line Chart
    CustomLineChartWidget(
      data: [45, 60, 50, 75, 85, 70, 90],
      title: 'المبيعات الأسبوعية',
      color: Colors.blue,
    ),
    
    SizedBox(height: 16),
    
    // Pie Chart
    CustomPieChartWidget(
      values: [40, 30, 20, 10],
      labels: ['منتج أ', 'منتج ب', 'منتج ج', 'منتج د'],
      title: 'توزيع المبيعات',
    ),
  ],
)
```

### مثال 2: تقرير شامل

```dart
class SalesReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تقرير المبيعات')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // الإحصائيات الرئيسية
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                StatsCard(
                  title: 'المبيعات',
                  value: '475K',
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
                StatsCard(
                  title: 'الطلبات',
                  value: '1,234',
                  icon: Icons.shopping_bag,
                  color: Colors.blue,
                ),
                StatsCard(
                  title: 'العملاء',
                  value: '856',
                  icon: Icons.people,
                  color: Colors.orange,
                ),
                StatsCard(
                  title: 'المنتجات',
                  value: '342',
                  icon: Icons.inventory,
                  color: Colors.purple,
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // المبيعات الشهرية
            CustomBarChartWidget(
              values: [45, 60, 50, 75, 85, 70, 90, 95, 80, 88, 92, 100],
              labels: ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 
                       'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 
                       'نوفمبر', 'ديسمبر'],
              title: 'المبيعات الشهرية (2024)',
              barColor: Colors.blue,
            ),
            
            SizedBox(height: 16),
            
            // توزيع المنتجات
            CustomDonutChartWidget(
              values: [40, 30, 20, 10],
              labels: ['إلكترونيات', 'ملابس', 'أغذية', 'أخرى'],
              title: 'توزيع المنتجات',
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 💡 نصائح وأفضل الممارسات

### 1. اختيار النوع المناسب

| نوع الرسم | أفضل استخدام |
|----------|--------------|
| Line Chart | الاتجاهات عبر الوقت |
| Bar Chart | المقارنات بين فئات |
| Pie/Donut | النسب المئوية |
| Grouped Bar | مقارنة مجموعات متعددة |
| Multi Line | مقارنة اتجاهات متعددة |

### 2. الألوان

```dart
// استخدم ألوان متناسقة
final colors = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.orange,
];

// أو ألوان من Theme
final primaryColor = Theme.of(context).primaryColor;
```

### 3. الأداء

```dart
// لا تعيد بناء Chart بدون داعي
// استخدم const حيثما أمكن
const CustomLineChartWidget(
  data: [10, 20, 30],
);

// أو استخدم StatefulWidget للبيانات المتغيرة
```

### 4. Responsive Design

```dart
// استخدم MediaQuery أو ScreenUtil
SizedBox(
  height: MediaQuery.of(context).size.height * 0.3,
  child: LineChart(...),
)
```

### 5. Accessibility

```dart
// أضف Semantics للمستخدمين ذوي الاحتياجات الخاصة
Semantics(
  label: 'رسم بياني يوضح المبيعات اليومية',
  child: CustomLineChartWidget(...),
)
```

---

## 🐛 حل المشاكل الشائعة

### مشكلة: الرسم البياني لا يظهر
```dart
// الحل: تأكد من وجود حجم محدد
SizedBox(
  height: 300, // ضروري!
  child: LineChart(...),
)
```

### مشكلة: البيانات لا تتحدث
```dart
// الحل: استخدم setState
setState(() {
  data = newData;
});
```

### مشكلة: Labels مقطوعة
```dart
// الحل: زيادة reservedSize
AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    reservedSize: 40, // زيادة المساحة
  ),
)
```

---

## 🎓 صفحة Demo

للاطلاع على جميع الأمثلة العملية:
```dart
Navigator.pushNamed(context, '/charts-demo');
// أو
GoRouter.of(context).push('/charts-demo');
```

---

## 📚 مصادر إضافية

- [fl_chart Documentation](https://pub.dev/packages/fl_chart)
- [fl_chart Examples](https://github.com/imaNNeo/fl_chart/tree/main/example)
- [Chart Design Best Practices](https://www.interaction-design.org/literature/article/data-visualization-best-practices)

---

## ✅ Checklist للاستخدام

- [ ] أضفت `fl_chart` للـ dependencies
- [ ] استوردت `chart_helper.dart` من Core
- [ ] استوردت `chart_widgets.dart` من Core
- [ ] حددت نوع الرسم المناسب
- [ ] أضفت بيانات حقيقية
- [ ] خصصت الألوان والأحجام
- [ ] اختبرت على شاشات مختلفة
- [ ] أضفت Tooltips للتفاصيل
- [ ] راجعت الأداء

---

**تم الإنشاء**: 2024
**آخر تحديث**: أكتوبر 2024
**الإصدار**: 1.0.0
