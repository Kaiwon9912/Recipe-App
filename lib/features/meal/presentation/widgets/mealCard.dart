import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';

class MealCard extends StatefulWidget {
  const MealCard({super.key, required this.meal});
  final MealEntity meal;

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  bool isFavorite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final box = Hive.box<MealEntity>('favorites');
    isFavorite = box.containsKey(widget.meal.id);
  }

  void _toggleFavorite() async {
    final box = Hive.box<MealEntity>('favorites');

    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await box.put(widget.meal.id, widget.meal);
    } else {
      await box.delete(widget.meal.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/detail', extra: widget.meal);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 148,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(widget.meal.thumbnail!),
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(191),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.redAccent : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
              child: Center(
                child: Text(
                  widget.meal.name,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Text(
                    'By Little Pony',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  Spacer(),
                  Icon(Icons.access_time, size: 14, color: Colors.amber[800]),
                  SizedBox(width: 4),
                  Text(
                    '20m',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
