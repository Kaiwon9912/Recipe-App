import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';

class MealDetailScreen extends StatefulWidget {
  final MealEntity meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = false;

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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final box = Hive.box<MealEntity>('favorites');
    isFavorite = box.containsKey(widget.meal.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 393,
              pinned: true,

              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(
                      height: 288,
                      width: double.infinity,
                      child: Image.network(
                        widget.meal.thumbnail!,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.white,
                          child: SizedBox(
                            height: 70,
                            child: ListView.separated(
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 16),
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/slide.jpg',
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Info Section
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.meal.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.meal.name,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFFFCC00)),
                        SizedBox(width: 4),
                        Text('4.2'),
                        VerticalDivider(),
                        Text('120 Đánh giá'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'assets/images/avatar.png',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Hồ Quốc Khánh',
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  controller: _tabController,
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 31.5,
                        vertical: 12,
                      ),
                      child: Tab(text: 'Nguyên liệu'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 31.5,
                        vertical: 12,
                      ),
                      child: Tab(text: 'Chế biến'),
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                ),
              ),
            ),

            // TabBar Content
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: widget.meal.ingredients.length,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemBuilder: (context, index) {
                                final ingredient =
                                    widget.meal.ingredients[index];
                                return ListTile(title: Text(ingredient));
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              widget.meal.instructions ?? "NO instruction",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          228,
                          212,
                          161,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Xem Video',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
