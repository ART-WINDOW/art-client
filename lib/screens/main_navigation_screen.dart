import 'package:flutter/cupertino.dart';
import '../screens/home_screen.dart';
import '../screens/major_exhibitions_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MajorExhibitionsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return screenWidth > 600
        ? CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _onItemTapped(0),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.info,
                    size: 18,
                    color: _selectedIndex == 0
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.inactiveGray,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '전체 목록',
                    style: TextStyle(
                      color: _selectedIndex == 0
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _onItemTapped(1),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.zoom_in,
                    size: 18,
                    color: _selectedIndex == 1
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.inactiveGray,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '주요 전시',
                    style: TextStyle(
                      color: _selectedIndex == 1
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    )
        : CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
            label: '전체 목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.zoom_in),
            label: '주요 전시',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return _widgetOptions.elementAt(index);
      },
    );
  }
}