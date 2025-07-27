import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repice_app/features/meal/domain/entities/area_entity.dart';
import 'package:repice_app/features/meal/domain/entities/category_entity.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_area/get_area_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_categories/get_categories_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_ingredients/get_ingredients_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_meal/get_meal_bloc.dart';
import 'package:repice_app/features/meal/presentation/widgets/filter_selector.dart';
import 'package:repice_app/features/meal/presentation/widgets/mealCard.dart';
import 'package:repice_app/features/meal/presentation/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<GetAreaBloc>().add(GetArea());
    context.read<GetIngredientsBloc>().add(GetIngredients());
  }

  String selectedIngredient = "";
  String selectedCategory = "";
  String seletedArea = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Expanded(
              child: SearchMealsBar(
                onSubmitted: (value) => {
                  context.read<GetMealBloc>().add(SearchMeals(value)),
                },
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              icon: Icon(
                Icons.filter_alt,
                color: Theme.of(context).colorScheme.primary,
                size: 36,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetMealBloc, GetMealState>(
          builder: (context, state) {
            if (state is GetMealListSuccess) {
              final meals = state.meals;
              if (meals.isEmpty) {
                return Center(child: Text('Không có kết quả'));
              } else {
                final itemWidth =
                    (MediaQuery.of(context).size.width - 32 - 16) / 2;
                final aspectRatio = itemWidth / 213;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return MealCard(meal: meal);
                  },
                );
              }
            } else {
              if (state is GetMealLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return SizedBox();
              }
            }
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, bottomSetState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lọc',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          bottomSetState(() {
                            selectedIngredient = '';
                            selectedCategory = '';
                            seletedArea = '';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[100],
                          elevation: 0,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.tertiaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Đặt lại',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 24),

                  BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                    builder: (context, state) {
                      if (state is GetCategoriesSuccess) {
                        return FilterSelector(
                          title: 'Danh mục',
                          selectedValue: selectedCategory,
                          listItem: state.categories,
                          onSelected: (value) {
                            bottomSetState(() {
                              selectedCategory = value;
                              context.read<GetMealBloc>().add(
                                GetMealsByCategory(value),
                              );
                              Navigator.pop(context);
                            });
                          },
                        );
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }
                    },
                  ),
                  BlocBuilder<GetIngredientsBloc, GetIngredientsState>(
                    builder: (context, state) {
                      if (state is GetIngredientsSuccess) {
                        return FilterSelector(
                          title: 'Nguyên liệu',
                          selectedValue: selectedIngredient,
                          listItem: state.ingredients,
                          onSelected: (value) {
                            bottomSetState(() {
                              selectedIngredient = value;
                              context.read<GetMealBloc>().add(
                                GetMealsByIngredient(value),
                              );
                              Navigator.pop(context);
                            });
                          },
                        );
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }
                    },
                  ),
                  BlocBuilder<GetAreaBloc, GetAreaState>(
                    builder: (context, state) {
                      if (state is GetAreaSuccess) {
                        return FilterSelector(
                          title: 'Khu vực',
                          selectedValue: seletedArea,
                          listItem: state.areas,
                          onSelected: (value) {
                            bottomSetState(() {
                              seletedArea = value;
                              context.read<GetMealBloc>().add(
                                GetMealsByArea(value),
                              );
                              Navigator.pop(context);
                            });
                          },
                        );
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
