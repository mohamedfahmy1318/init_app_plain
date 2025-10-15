import 'package:flutter/material.dart';

/// Animation Helper with pre-built animations
class AnimationHelper {
  /// Fade in animation
  static Widget fadeIn({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeIn,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Fade out animation
  static Widget fadeOut({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Slide in from left
  static Widget slideInFromLeft({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(-1, 0), end: Offset.zero),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return FractionalTranslation(
          translation: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Slide in from right
  static Widget slideInFromRight({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(1, 0), end: Offset.zero),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return FractionalTranslation(
          translation: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Slide in from top
  static Widget slideInFromTop({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(0, -1), end: Offset.zero),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return FractionalTranslation(
          translation: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Slide in from bottom
  static Widget slideInFromBottom({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(0, 1), end: Offset.zero),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return FractionalTranslation(
          translation: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Scale animation
  static Widget scale({
    required Widget child,
    double begin = 0.0,
    double end = 1.0,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: end),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  /// Rotate animation
  static Widget rotate({
    required Widget child,
    double begin = 0.0,
    double end = 1.0,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: end),
      duration: duration,
      curve: curve,
      onEnd: onComplete,
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 6.283185307179586, // 2 * pi
          child: child,
        );
      },
      child: child,
    );
  }

  /// Bounce animation
  static Widget bounce({
    required Widget child,
    Duration duration = const Duration(milliseconds: 1000),
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.bounceOut,
      onEnd: onComplete,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -50 * (1 - value)),
          child: child,
        );
      },
      child: child,
    );
  }

  /// Shake animation
  static Widget shake({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    double offset = 10.0,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.elasticIn,
      onEnd: onComplete,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(offset * (0.5 - value).abs() * 4, 0),
          child: child,
        );
      },
      child: child,
    );
  }

  /// Flip animation
  static Widget flip({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Axis direction = Axis.horizontal,
    VoidCallback? onComplete,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.easeInOut,
      onEnd: onComplete,
      builder: (context, value, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(direction == Axis.horizontal ? value * 3.14159 : 0)
            ..rotateX(direction == Axis.vertical ? value * 3.14159 : 0),
          child: child,
        );
      },
      child: child,
    );
  }
}

/// Animated Widget with controller
class AnimatedWidget extends StatefulWidget {
  final Widget child;
  final AnimationType type;
  final Duration duration;
  final Curve curve;
  final bool autoStart;
  final VoidCallback? onComplete;

  const AnimatedWidget({
    super.key,
    required this.child,
    this.type = AnimationType.fadeIn,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.autoStart = true,
    this.onComplete,
  });

  @override
  State<AnimatedWidget> createState() => AnimatedWidgetState();
}

class AnimatedWidgetState extends State<AnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (widget.autoStart) {
      _controller.forward();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void start() {
    _controller.forward(from: 0);
  }

  void reverse() {
    _controller.reverse();
  }

  void reset() {
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        switch (widget.type) {
          case AnimationType.fadeIn:
            return Opacity(
              opacity: _animation.value,
              child: child,
            );
          case AnimationType.fadeOut:
            return Opacity(
              opacity: 1 - _animation.value,
              child: child,
            );
          case AnimationType.slideInFromLeft:
            return FractionalTranslation(
              translation: Offset(-1 + _animation.value, 0),
              child: child,
            );
          case AnimationType.slideInFromRight:
            return FractionalTranslation(
              translation: Offset(1 - _animation.value, 0),
              child: child,
            );
          case AnimationType.slideInFromTop:
            return FractionalTranslation(
              translation: Offset(0, -1 + _animation.value),
              child: child,
            );
          case AnimationType.slideInFromBottom:
            return FractionalTranslation(
              translation: Offset(0, 1 - _animation.value),
              child: child,
            );
          case AnimationType.scale:
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          case AnimationType.rotate:
            return Transform.rotate(
              angle: _animation.value * 6.283185307179586,
              child: child,
            );
        }
      },
      child: widget.child,
    );
  }
}

/// Animation types
enum AnimationType {
  fadeIn,
  fadeOut,
  slideInFromLeft,
  slideInFromRight,
  slideInFromTop,
  slideInFromBottom,
  scale,
  rotate,
}
