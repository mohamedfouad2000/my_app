import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final bool visible;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({super.key, required this.visible, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: visible
          ? Padding(
              key: const ValueKey('search_field'),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: onChanged,
              ),
            )
          : const SizedBox.shrink(
              key: ValueKey('empty'),
            ),
    );
  }
}
