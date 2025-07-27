import 'package:flutter/material.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';

class FilterSelector extends StatefulWidget {
  final List<dynamic> listItem;
  final String selectedValue;
  final Function(String) onSelected;
  final String title;

  const FilterSelector({
    super.key,
    required this.listItem,
    required this.selectedValue,
    required this.onSelected,
    required this.title,
  });

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.quickreply_rounded),
            const SizedBox(width: 6),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 115,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 9,
              crossAxisSpacing: 9,
              childAspectRatio: 114 / 34,
            ),
            itemCount: widget.listItem.length,
            itemBuilder: (context, index) {
              final item = widget.listItem[index];
              final isSelected = item.name == widget.selectedValue;

              return GestureDetector(
                onTap: () {
                  widget.onSelected(item.name);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Center(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 17,
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
