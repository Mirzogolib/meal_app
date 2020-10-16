import 'package:flutter/material.dart';
import '../widgets/my_drawer.dart';

class SettingsScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> filtersFromMain;
  SettingsScreen(this.filtersFromMain, this.saveFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _isGlutenFree = false;
  var _isVegitarian = false;
  var _isVegan = false;
  var _isLactoseFree = false;

  

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  void initState() {
    _isGlutenFree = widget.filtersFromMain['gluten'];
    _isVegitarian = widget.filtersFromMain['vegitarian'];
    _isVegan = widget.filtersFromMain['vegan'];
    _isLactoseFree = widget.filtersFromMain['lactose'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegitarian': _isVegitarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchTile(
                  'Gluten free',
                  'Only include gluten free meals',
                  _isGlutenFree,
                  (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegitarian',
                  'Only include vegitarian meals',
                  _isVegitarian,
                  (newValue) {
                    setState(() {
                      _isVegitarian = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegan',
                  'Only include vegan meals',
                  _isVegan,
                  (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Lactose-free',
                  'Only include lactose free meals',
                  _isLactoseFree,
                  (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
