import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Rating Widget with customizable stars
class RatingWidget extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool allowHalfRating;
  final ValueChanged<double>? onRatingChanged;
  final bool readOnly;
  final MainAxisAlignment alignment;
  final IconData? icon;

  const RatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = true,
    this.onRatingChanged,
    this.readOnly = false,
    this.alignment = MainAxisAlignment.start,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final activeColorValue = activeColor ?? Colors.amber;
    final inactiveColorValue = inactiveColor ?? Colors.grey.shade300;

    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starPosition = index + 1;
        final iconData = icon ?? Icons.star;

        return GestureDetector(
          onTap: readOnly
              ? null
              : () {
                  if (onRatingChanged != null) {
                    onRatingChanged!(starPosition.toDouble());
                  }
                },
          child: Icon(
            _getStarIcon(starPosition, iconData),
            size: size,
            color: _getStarColor(starPosition, activeColorValue, inactiveColorValue),
          ),
        );
      }),
    );
  }

  IconData _getStarIcon(int position, IconData baseIcon) {
    if (rating >= position) {
      return baseIcon;
    } else if (allowHalfRating && rating >= position - 0.5) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  Color _getStarColor(int position, Color active, Color inactive) {
    if (rating >= position) {
      return active;
    } else if (allowHalfRating && rating >= position - 0.5) {
      return active;
    } else {
      return inactive;
    }
  }
}

/// Interactive Rating Widget
class InteractiveRatingWidget extends StatefulWidget {
  final double initialRating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final ValueChanged<double> onRatingChanged;
  final MainAxisAlignment alignment;
  final IconData? icon;
  final bool showLabel;
  final String? labelText;

  const InteractiveRatingWidget({
    super.key,
    this.initialRating = 0,
    this.maxRating = 5,
    this.size = 32,
    this.activeColor,
    this.inactiveColor,
    required this.onRatingChanged,
    this.alignment = MainAxisAlignment.center,
    this.icon,
    this.showLabel = false,
    this.labelText,
  });

  @override
  State<InteractiveRatingWidget> createState() => _InteractiveRatingWidgetState();
}

class _InteractiveRatingWidgetState extends State<InteractiveRatingWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.labelText ?? 'اختر التقييم',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
        ],
        RatingWidget(
          rating: _currentRating,
          maxRating: widget.maxRating,
          size: widget.size,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          alignment: widget.alignment,
          icon: widget.icon,
          readOnly: false,
          onRatingChanged: (rating) {
            setState(() {
              _currentRating = rating;
            });
            widget.onRatingChanged(rating);
          },
        ),
        if (widget.showLabel) ...[
          SizedBox(height: 8.h),
          Text(
            '$_currentRating / ${widget.maxRating}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}

/// Rating Bar with Labels
class RatingBarWithLabels extends StatelessWidget {
  final double rating;
  final int maxRating;
  final int totalReviews;
  final double size;
  final Color? activeColor;
  final bool showRatingNumber;
  final bool showReviewsCount;

  const RatingBarWithLabels({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.totalReviews = 0,
    this.size = 20,
    this.activeColor,
    this.showRatingNumber = true,
    this.showReviewsCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showRatingNumber) ...[
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4.w),
        ],
        RatingWidget(
          rating: rating,
          maxRating: maxRating,
          size: size,
          activeColor: activeColor,
          readOnly: true,
        ),
        if (showReviewsCount && totalReviews > 0) ...[
          SizedBox(width: 4.w),
          Text(
            '($totalReviews)',
            style: TextStyle(
              fontSize: size * 0.7,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}

/// Rating Summary Widget (like app stores)
class RatingSummaryWidget extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution; // {5: 100, 4: 50, 3: 20, 2: 10, 1: 5}
  final Color? activeColor;

  const RatingSummaryWidget({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeColorValue = activeColor ?? Colors.amber;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Average rating
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingWidget(
                      rating: averageRating,
                      size: 20,
                      activeColor: activeColorValue,
                      readOnly: true,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$totalReviews تقييم',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Distribution bars
              Expanded(
                flex: 3,
                child: Column(
                  children: List.generate(5, (index) {
                    final stars = 5 - index;
                    final count = ratingDistribution[stars] ?? 0;
                    final percentage = totalReviews > 0 ? count / totalReviews : 0.0;
                    
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Row(
                        children: [
                          Text(
                            '$stars',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: activeColorValue,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: LinearProgressIndicator(
                                value: percentage,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  activeColorValue,
                                ),
                                minHeight: 8.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            width: 30.w,
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
