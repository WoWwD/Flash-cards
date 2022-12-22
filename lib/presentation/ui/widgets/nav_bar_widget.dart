import 'package:flash_cards/presentation/ui/screens/cards_screen.dart';
import 'package:flash_cards/presentation/ui/screens/collection_screen.dart';
import 'package:flash_cards/presentation/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  State<NavBarWidget> createState() => _NavBarWidget();
}

class _NavBarWidget extends State<NavBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> get _items => [
    const BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Карточки'),
    const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Коллекции слов'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
  ];

  static const List<Widget> _screens = [
    CardsScreen(),
    CollectionScreen(),
    SettingsScreen()
  ];
}