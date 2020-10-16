import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favourites;
  FavouritesScreen(this.favourites);
  @override
  Widget build(BuildContext context) {
    if (favourites.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            'You don\'t have favourite meals yet. Start adding some!',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
            
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          final meal = favourites[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imageURL: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
          );
        },
        itemCount: favourites.length,
      );
    }
  }
}
