/// ========================================================
/// List Extensions
/// ========================================================
/// Extensions مفيدة للـ Lists
/// ========================================================

extension ListExtensions<T> on List<T> {
  /// فلترة null values
  List<T> get removeNulls {
    return where((item) => item != null).toList();
  }

  /// الحصول على عنصر آمن (بدون exception)
  T? safeGet(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  /// تقسيم القائمة لمجموعات
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// إزالة التكرار
  List<T> get unique {
    return toSet().toList();
  }

  /// إزالة التكرار حسب خاصية معينة
  List<T> uniqueBy<E>(E Function(T) selector) {
    final seen = <E>{};
    return where((item) => seen.add(selector(item))).toList();
  }

  /// البحث عن عنصر
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  /// تبديل عنصرين
  void swap(int i, int j) {
    if (i >= 0 && i < length && j >= 0 && j < length) {
      final temp = this[i];
      this[i] = this[j];
      this[j] = temp;
    }
  }

  /// إضافة عنصر بين كل عنصرين
  List<T> insertBetween(T separator) {
    if (length <= 1) return this;
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) result.add(separator);
    }
    return result;
  }

  /// التحويل لـ Map حسب key
  Map<K, T> toMapBy<K>(K Function(T) keySelector) {
    return Map.fromEntries(map((item) => MapEntry(keySelector(item), item)));
  }

  /// المجموع (للأرقام)
  num sumBy(num Function(T) selector) {
    return isEmpty ? 0 : map(selector).reduce((a, b) => a + b);
  }

  /// المتوسط (للأرقام)
  double averageBy(num Function(T) selector) {
    return isEmpty ? 0 : sumBy(selector) / length;
  }

  /// الحد الأقصى
  T? maxBy<E extends Comparable>(E Function(T) selector) {
    if (isEmpty) return null;
    return reduce((a, b) => 
      selector(a).compareTo(selector(b)) > 0 ? a : b
    );
  }

  /// الحد الأدنى
  T? minBy<E extends Comparable>(E Function(T) selector) {
    if (isEmpty) return null;
    return reduce((a, b) => 
      selector(a).compareTo(selector(b)) < 0 ? a : b
    );
  }

  /// التجميع حسب خاصية
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final map = <K, List<T>>{};
    for (final item in this) {
      final key = keySelector(item);
      (map[key] ??= []).add(item);
    }
    return map;
  }

  /// هل القائمة تحتوي على جميع العناصر
  bool containsAll(Iterable<T> elements) {
    return elements.every((element) => contains(element));
  }

  /// هل القائمة تحتوي على أي عنصر من العناصر
  bool containsAny(Iterable<T> elements) {
    return elements.any((element) => contains(element));
  }
}

extension ListWidgetExtensions<T> on List<T> {
  /// إضافة Divider بين العناصر (للـ Widgets)
  List<T> separatedBy(T separator) {
    return insertBetween(separator);
  }
}

extension ListStringExtensions on List<String> {
  /// دمج العناصر بفاصل
  String joinWithComma() => join(', ');
  
  /// دمج العناصر بـ "و"
  String joinWithAnd() {
    if (isEmpty) return '';
    if (length == 1) return first;
    final allButLast = sublist(0, length - 1);
    return '${allButLast.join('، ')} و ${last}';
  }
}
