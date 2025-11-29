import 'package:maps_project/core/utils/debug/color_log.dart';

import 'package:flutter/material.dart';

import 'package:maps_project/core/widgets/custom_bottom_nav_bar.dart';
import 'package:maps_project/core/widgets/pages/data_page.dart';
import 'package:maps_project/core/widgets/pages/map_page.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = const [
    MapPage(),
    // SearchPage(),
    DataPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}