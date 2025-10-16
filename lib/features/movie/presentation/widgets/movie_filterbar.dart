import 'package:app_movie/features/movie/presentation/widgets/filterbar.dart';
import 'package:flutter/material.dart';

class MovieFilterBar extends StatelessWidget {
  final Function(String) onFilterSelected;
  final String? selectedFilter;

  const MovieFilterBar({
    super.key,
    required this.onFilterSelected,
    this.selectedFilter,
  });

  static const List<String> movieFilters = [
    'Todos',
    'Acción',
    'Comedia',
    'Drama',
    'Terror',
    'Ciencia Ficción',
    'Romance',
    'Aventura',
  ];

  @override
  Widget build(BuildContext context) {
    return FilterBar(
      filters: movieFilters,
      selectedFilter: selectedFilter ?? 'Todos',
      onFilterSelected: onFilterSelected,
      selectedColor: Colors.red.shade600,
      unselectedColor: Colors.grey.shade800,
      selectedTextColor: Colors.white,
      unselectedTextColor: Colors.grey.shade400,
    );
  }
}
