import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final mealItem = DUMMY_MEALS.where((element) {
      return element.id.contains(mealId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('${mealItem[0].title}'),
      ),
      body: Text('body'),
    );
  }
}
