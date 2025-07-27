import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_meal/get_meal_bloc.dart';

class SearchMealsBar extends StatefulWidget {
  const SearchMealsBar({super.key, this.onSubmitted});
  final ValueChanged<String>? onSubmitted;

  @override
  State<SearchMealsBar> createState() => _SearchBarLayoutState();
}

class _SearchBarLayoutState extends State<SearchMealsBar> {
  List<MealEntity> _suggestions = [];
  final SearchController _searchController = SearchController();
  void _onQueryChanged(String value) {
    if (value.isNotEmpty) {
      context.read<GetMealBloc>().add(SearchMeals(value));
    }
  }

  void _onSubmitted(String value) {
    widget.onSubmitted;
    _searchController.closeView(value);
    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetMealBloc, GetMealState>(
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
      child: SizedBox(
        height: 36,
        child: SearchAnchor.bar(
          searchController: _searchController,
          barHintText: 'Tìm kiếm món ăn...',
          barElevation: WidgetStateProperty.all(1),
          viewBackgroundColor: Colors.white,
          barShape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          barBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.grey.shade200;
            }
            return Colors.white;
          }),

          suggestionsBuilder: (context, controller) {
            final query = controller.text;

            if (query.isEmpty || _suggestions.isEmpty) {
              return [];
            }

            return _suggestions.map((meal) {
              return ListTile(
                title: Text(
                  meal.name,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                onTap: () {
                  context.push('/detail', extra: meal);
                  controller.clear();
                  FocusScope.of(context).unfocus();
                },
              );
            }).toList();
          },
          onSubmitted: _onSubmitted,
          onTap: () {},
          onChanged: _onQueryChanged,
        ),
      ),
    );
  }
}
