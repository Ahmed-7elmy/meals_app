import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';
import '../providers/nav_bar_provider.dart';
import '../widgets/main_drawer.dart';

import 'categories_screen.dart';
import 'filters_screen.dart';
import 'meals_screen.dart';

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> availableMeals = ref.watch(filteredMealsProvider);
    final int selectedPageIndex = ref.watch(navBarProvider);

    Widget activePage = CategoriesScreeen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Pick your category';

    if (selectedPageIndex == 1) {
      final List<Meal> favoriteMeal = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: (String identifier) {
        Navigator.of(context).pop();
        if (identifier == 'filters') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const FiltersScreen(),
            ),
          );
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ref.read(navBarProvider.notifier).selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Cateories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
