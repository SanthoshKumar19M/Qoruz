import 'package:flutter/material.dart';
import 'package:qoruz/views/marketplace/plackholderscreendisplay.dart';
import 'marketplace/marketplace_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    PlaceHolderScreen(
      title: "Explore",
    ),
    MarketplacePage(),
    PlaceHolderScreen(
      title: "Search",
    ),
    PlaceHolderScreen(
      title: "Activity",
    ),
    PlaceHolderScreen(
      title: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: _selectedIndex == 0 ? Colors.red : Colors.grey,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.storefront, size: 30),
                Positioned(
                  right: -25,
                  top: -2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _selectedIndex == 2 ? Colors.red : Colors.grey,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: _selectedIndex == 3 ? Colors.red : Colors.grey,
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 4 ? Colors.red : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
