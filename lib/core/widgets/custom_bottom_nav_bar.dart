import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
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
      ],
    );
  }
}