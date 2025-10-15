/// ========================================================
/// Pagination Grid View - شبكة مع تصفح صفحات
/// ========================================================

import 'package:flutter/material.dart';

class PaginationGridView<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Future<void> Function() onLoadMore;
  final bool hasMore;
  final bool isLoading;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final SliverGridDelegate gridDelegate;

  const PaginationGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.hasMore,
    required this.gridDelegate,
    this.isLoading = false,
    this.emptyWidget,
    this.loadingWidget,
    this.controller,
    this.padding,
  });

  @override
  State<PaginationGridView<T>> createState() => _PaginationGridViewState<T>();
}

class _PaginationGridViewState<T> extends State<PaginationGridView<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore && !widget.isLoading) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && !widget.isLoading) {
      return widget.emptyWidget ?? const Center(child: Text('لا توجد عناصر'));
    }

    return GridView.builder(
      controller: _scrollController,
      padding: widget.padding,
      gridDelegate: widget.gridDelegate,
      itemCount: widget.items.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          return widget.loadingWidget ??
              Center(
                child: Text(
                  'جاري تحميل المزيد...',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              );
        }

        return widget.itemBuilder(context, widget.items[index], index);
      },
    );
  }
}
