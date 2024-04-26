import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physicstool/screens/grid_screen.dart';
import 'package:physicstool/screens/text_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    TextScreen(),
    GridScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child:  _pages[_selectedIndex]),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              label: 'textInput',
              icon: Icon(Icons.text_snippet_outlined, color: Colors.black,
            ),),
            BottomNavigationBarItem(
              label: 'SquareInput',
              icon: Icon(Icons.integration_instructions_outlined, color: Colors.black,),
            ),
          ],
        ),
      ),
    );
  }
}
