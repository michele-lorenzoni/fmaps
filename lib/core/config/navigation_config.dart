import 'package:flutter/material.dart';
import 'package:maps_project/core/widgets/pages/map_page.dart';
import 'package:maps_project/core/widgets/pages/data_page.dart';
// import 'package:maps_project/core/widgets/pages/search_page.dart';

class NavigationConfig {
  static const List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Mappa',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Cerca',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.show_chart),
      label: 'Data',
    ),
  ];

  static final List<Widget> pages = [
    const MapPage(),
    const Center(child: Text('Search Page - TODO')), // Placeholder
    const DataPage(),
  ];
}