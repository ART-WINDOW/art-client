import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'major_exhibitions_screen.dart';
import 'museum_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // 현재 선택된 인덱스

  final List<Widget> _pages = [
    HomeScreen(),          // 홈 화면
    MajorExhibitionsScreen(), // 주요 전시 화면
    MuseumScreen(),        // 미술관 목록 화면
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // 선택된 탭으로 변경
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // 홈 탭
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Major Exhibitions', // 주요 전시 탭
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.museum),
            label: 'Museums', // 미술관 목록 탭
          ),
        ],
      ),
    );
  }
}
