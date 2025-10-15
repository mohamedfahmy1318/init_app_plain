import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer Loading Widget for various use cases
class ShimmerLoading extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      child: child,
    );
  }
}

/// Pre-built shimmer shapes
class ShimmerShapes {
  /// Rectangular shimmer
  static Widget rectangular({
    required double width,
    required double height,
    double borderRadius = 8.0,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return ShimmerLoading(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  /// Circular shimmer
  static Widget circular({
    required double size,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return ShimmerLoading(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  /// Text line shimmer
  static Widget textLine({
    double width = 100,
    double height = 16,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return ShimmerLoading(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// Pre-built shimmer templates
class ShimmerTemplates {
  /// List item shimmer
  static Widget listItem({
    bool showLeading = true,
    bool showTrailing = false,
    int titleLines = 1,
    int subtitleLines = 1,
    double? height,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLeading) ...[
            ShimmerShapes.circular(size: 48),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  titleLines,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ShimmerShapes.textLine(
                      width: double.infinity,
                      height: 16,
                    ),
                  ),
                ),
                ...List.generate(
                  subtitleLines,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: ShimmerShapes.textLine(
                      width: double.infinity,
                      height: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showTrailing) ...[
            const SizedBox(width: 16),
            ShimmerShapes.rectangular(width: 60, height: 30, borderRadius: 4),
          ],
        ],
      ),
    );
  }

  /// Card shimmer
  static Widget card({
    double? width,
    double? height,
    bool showImage = true,
    int titleLines = 1,
    int contentLines = 2,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showImage) ...[
            ShimmerShapes.rectangular(
              width: double.infinity,
              height: 150,
              borderRadius: 8,
            ),
            const SizedBox(height: 12),
          ],
          ...List.generate(
            titleLines,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ShimmerShapes.textLine(width: double.infinity, height: 18),
            ),
          ),
          const SizedBox(height: 4),
          ...List.generate(
            contentLines,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: ShimmerShapes.textLine(
                width: index == contentLines - 1 ? 150 : double.infinity,
                height: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Grid item shimmer
  static Widget gridItem({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ShimmerShapes.rectangular(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 8,
            ),
          ),
          const SizedBox(height: 8),
          ShimmerShapes.textLine(width: double.infinity, height: 14),
          const SizedBox(height: 4),
          ShimmerShapes.textLine(width: 80, height: 12),
        ],
      ),
    );
  }

  /// Profile header shimmer
  static Widget profileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ShimmerShapes.circular(size: 100),
          const SizedBox(height: 16),
          ShimmerShapes.textLine(width: 150, height: 20),
          const SizedBox(height: 8),
          ShimmerShapes.textLine(width: 200, height: 14),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ShimmerShapes.textLine(width: 60, height: 24),
                  const SizedBox(height: 4),
                  ShimmerShapes.textLine(width: 60, height: 12),
                ],
              ),
              Column(
                children: [
                  ShimmerShapes.textLine(width: 60, height: 24),
                  const SizedBox(height: 4),
                  ShimmerShapes.textLine(width: 60, height: 12),
                ],
              ),
              Column(
                children: [
                  ShimmerShapes.textLine(width: 60, height: 24),
                  const SizedBox(height: 4),
                  ShimmerShapes.textLine(width: 60, height: 12),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Product item shimmer
  static Widget productItem({bool horizontal = false}) {
    if (horizontal) {
      return Container(
        width: 150,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerShapes.rectangular(
              width: double.infinity,
              height: 150,
              borderRadius: 8,
            ),
            const SizedBox(height: 8),
            ShimmerShapes.textLine(width: double.infinity, height: 14),
            const SizedBox(height: 4),
            ShimmerShapes.textLine(width: 80, height: 16),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ShimmerShapes.rectangular(width: 80, height: 80, borderRadius: 8),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerShapes.textLine(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                ShimmerShapes.textLine(width: 150, height: 14),
                const SizedBox(height: 8),
                ShimmerShapes.textLine(width: 100, height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Form shimmer
  static Widget form({int fieldsCount = 3}) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            fieldsCount,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerShapes.textLine(width: 100, height: 14),
                  const SizedBox(height: 8),
                  ShimmerShapes.rectangular(
                    width: double.infinity,
                    height: 50,
                    borderRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ShimmerShapes.rectangular(
            width: double.infinity,
            height: 50,
            borderRadius: 25,
          ),
        ],
      ),
    );
  }
}
