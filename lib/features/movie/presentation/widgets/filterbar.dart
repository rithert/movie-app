import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  final List<String> filters;
  final String? selectedFilter;
  final Function(String) onFilterSelected;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  const FilterBar({
    super.key,
    required this.filters,
    required this.onFilterSelected,
    this.selectedFilter,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
  });

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late String _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.selectedFilter ?? widget.filters.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final filter = widget.filters[index];
          final isSelected = filter == _selectedFilter;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
              widget.onFilterSelected(filter);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? (widget.selectedColor ?? Colors.red.shade600)
                    : (widget.unselectedColor ?? Colors.grey.shade800),
                borderRadius: BorderRadius.circular(25),
                border: isSelected
                    ? Border.all(color: Colors.red.shade400, width: 1)
                    : null,
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected
                      ? (widget.selectedTextColor ?? Colors.white)
                      : (widget.unselectedTextColor ?? Colors.grey.shade400),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
