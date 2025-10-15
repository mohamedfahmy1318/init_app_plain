/// ========================================================
/// Custom Search Bar - شريط بحث مخصص
/// ========================================================

import 'package:flutter/material.dart';
import '../utils/debouncer.dart';

class CustomSearchBar extends StatefulWidget {
  final String? hint;
  final Function(String) onSearch;
  final Duration debounceDuration;
  final VoidCallback? onClear;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    this.hint = 'ابحث...',
    required this.onSearch,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.onClear,
    this.controller,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _debouncer = Debouncer(delay: widget.debounceDuration);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        _debouncer.run(() => widget.onSearch(value));
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  widget.onSearch('');
                  widget.onClear?.call();
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
