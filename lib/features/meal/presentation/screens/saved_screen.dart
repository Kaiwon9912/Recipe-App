import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/presentation/widgets/mealCard.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MealEntity> favorites = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final box = Hive.box<MealEntity>('favorites');
    setState(() {
      favorites = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Công thức'))),
      body: Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary,
            ),
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Tab(child: Text('Video')),
              ),
              Padding(padding: EdgeInsets.all(6), child: Text('Công thức')),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [videoScreen(), recipeScreen()],
            ),
          ),
        ],
      ),
    );
  }

  Widget videoScreen() {
    return ListView.builder(
      itemCount: 4,

      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/video.jpg',
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Colors.white, size: 14),
                          SizedBox(width: 2),

                          Text(
                            '5',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Play button
                  const Positioned.fill(
                    child: Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '1 tiếng 20 phút',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    const Text(
                      'Cách chiên trứng một cách cung phu',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage(
                            'assets/images/avatar.png',
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Đinh Trọng Phúc',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget recipeScreen() {
    if (favorites.isEmpty) {
      return const Center(child: Text('Chưa có công thức nào được lưu'));
    }
    final itemWidth = (MediaQuery.of(context).size.width - 32 - 16) / 2;
    final aspectRatio = itemWidth / 213;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        childAspectRatio: aspectRatio,
      ),
      itemCount: favorites.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final meal = favorites[index];
        return MealCard(meal: meal);
      },
    );
  }
}
