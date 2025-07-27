import 'package:flutter/material.dart';

import 'package:repice_app/features/meal/domain/entities/category_entity.dart';

class CategorySelector extends StatefulWidget {
  final List<CategoryEntity> categories;
  final ValueChanged<String> onSelected;
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onSelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onSelected(category.name);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? null
                    : Border.all(color: Colors.black.withAlpha(77)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
