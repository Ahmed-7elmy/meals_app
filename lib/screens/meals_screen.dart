import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

import 'meal_detail_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return title == null
        ? content(context)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content(context),
          );
  }

  SingleChildScrollView content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map(
              (meal) => MealItem(
                meal: meal,
                onSelectMeal: (Meal meal) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => MealDetailScreen(meal: meal),
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
