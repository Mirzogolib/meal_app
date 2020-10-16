import 'package:flutter/material.dart';
import 'favourites_screen.dart';
import 'categories_screen.dart';


class TabsOnTopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Category',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favourite',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // CategoriesScreen(),
            // FavouritesScreen(),
          ],
        ),
      ),
    );
  }
}
