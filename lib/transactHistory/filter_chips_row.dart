// widgets/filter_chips_row.dart
import 'package:flutter/material.dart';

class FilterChipsRow extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;
  final List<String> statusOptions;
  final String selectedStatus;
  final ValueChanged<String> onStatusSelected;

  const FilterChipsRow({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.statusOptions,
    required this.selectedStatus,
    required this.onStatusSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: categories.map((c) {
            final selected = c == selectedCategory;
            return ChoiceChip(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              label: Text(c),
              selected: selected,
              onSelected: (_) => onCategorySelected(c),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: statusOptions.map((s) {
              final selected = s == selectedStatus;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: selected ? Theme.of(context).primaryColor : Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => onStatusSelected(s),
                  child: Text(s),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
