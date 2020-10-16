import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/settings_screen.dart';
import './screens/tabs_on_top_screen.dart';
import './screens/tabs_screen.dart';

import './screens/category_meals_screen.dart';
import './tools/constants.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegitarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favourites = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten'] && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !element.isVegan) {
          return false;
        }
        if (_filters['vegitarian'] && !element.isVegetarian) {
          return false;
        }
        //other cases --> _filters['gluten'] && element.isGlutenFree
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    // indexWhere return 1 if true if false returns -1
    // so in our case if element is not exist in favourites we will add to the list
    // otherwise remove
    //Returns the first index in the list that satisfies the provided [test].
    ///
// Searches the list from index [start] to the end of the list.
// The first time an object o is encountered so that test(o) is true, the index of o is returned.

    final exisingIndex =
        _favourites.indexWhere((element) => element.id == mealId);
    if (exisingIndex >= 0) {
      //remove from the list that index item
      setState(() {
        _favourites.removeAt(exisingIndex);
      });
    } else {
      //add to the list
      setState(() {
        _favourites.add(
          DUMMY_MEALS.firstWhere((element) => element.id == mealId),
        );
      });
    }
  }

  bool _isMealFavourite(String mealId){
    return _favourites.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 250, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      //you can set initial route CHAR and default value is '/'
      // initialRoute: '/',
      routes: {
        Constants.mainRoute: (ctx) => TabsScreen(_favourites),
        Constants.categoriesRoute: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        Constants.mealsRoute: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        Constants.settingsRoute: (ctx) => SettingsScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
      // on crash called (as 404 page does not exist)
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
