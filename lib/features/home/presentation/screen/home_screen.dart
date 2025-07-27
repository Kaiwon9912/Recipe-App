import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';

import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_categories/get_categories_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_ingredients/get_ingredients_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_meal/get_meal_bloc.dart';
import 'package:repice_app/features/meal/presentation/widgets/category_selector.dart';
import 'package:repice_app/features/meal/presentation/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MealEntity> _suggestions = [];

  @override
  void initState() {
    // TODO: implement initState

    context.read<GetCategoriesBloc>().add(GetCategories());
    context.read<GetMealBloc>().add(GetMealsByCategory('Beef'));
    context.read<GetIngredientsBloc>().add(GetIngredients());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocListener<GetMealBloc, GetMealState>(
        listener: (context, state) {
          if (state is GetMealListSuccess) {
            setState(() {
              _suggestions = state.meals;
            });
          } else if (state is GetMealError) {
            setState(() {
              _suggestions = [];
            });
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SearchMealsBar(),
                  ),

                  SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TP. Hồ Chí Minh',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildVideoList(),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Danh mục',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                    builder: (context, state) {
                      if (state is GetCategoriesLoading) {
                        return CircularProgressIndicator();
                      } else if (state is GetCategoriesSuccess) {
                        final categories = state.categories;

                        return SizedBox(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: CategorySelector(
                                  categories: categories,
                                  onSelected: (value) {
                                    context.read<GetMealBloc>().add(
                                      GetMealsByCategory(value),
                                    );
                                    setState(() {});
                                  },
                                ),
                              ),
                              BlocBuilder<GetMealBloc, GetMealState>(
                                builder: (context, state) {
                                  if (state is GetMealListSuccess) {
                                    return _buidMealCategoryList(state.meals);
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (state is GetCategoriesError) {
                        return Text(
                          'Error: ${state.error?.message ?? "Unknown error"}',
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'Công thức gần đây',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  _buildRecentRecipeList(),

                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'Nguyên liệu',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<GetIngredientsBloc, GetIngredientsState>(
                    builder: (context, state) {
                      if (state is GetIngredientsSuccess) {
                        return _buildIngredientList(state.ingredients);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildIngredientList(List<IngredientEntity> ingredients) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 9,
          childAspectRatio: 120 / 50,
        ),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final item = ingredients[index];

          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.3),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildRecentRecipeList() {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 8,

        itemBuilder: (context, index) {
          return SizedBox(
            width: 133,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/recent.jpg',
                    fit: BoxFit.cover,
                    height: 133,
                    width: 133,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Trứng chiên',
                  style: TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 9,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Hồ Quốc Khánh',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0, 45, 15, 1),
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildVideoList() {
    return SizedBox(
      height: 252,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Container(
            color: Theme.of(context).colorScheme.surfaceBright,
            width: 206,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/videoThumbnail.jpg'),
                ),
                const SizedBox(height: 7.5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    '1 tiếng 20 phút',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.all(6),
                  child: Text(
                    'Cách chiên trứng một cách cung phu',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Hồ Quốc Khánh',
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _buidMealCategoryList(List<MealEntity> meals) {
    return SizedBox(
      height: 213,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: meals.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final meal = meals[index];
          return Column(
            children: [
              SizedBox(
                height: 213,
                width: 150,
                child: Stack(
                  children: [
                    Positioned(
                      top: 58,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 32),
                            Text(
                              meal.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Tạo bởi',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Hồ Quốc Khanh',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 33),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 35,
                      right: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          meal.thumbnail!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '20 phút',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(Icons.sticky_note_2_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
