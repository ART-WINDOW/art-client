import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/major_exhibitions_screen.dart';
import '../screens/help_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MajorExhibitionsScreen(),
    HelpScreen(),
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
        middle: Center(
          child: Row(
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
                          : CupertinoColors.black,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '전체 목록',
                      style: TextStyle(
                        color: _selectedIndex == 0
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.black,
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
                          : CupertinoColors.black,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '주요 전시',
                      style: TextStyle(
                        color: _selectedIndex == 1
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _onItemTapped(2),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.question_circle,
                      size: 18,
                      color: _selectedIndex == 2
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.black,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '도움말',
                      style: TextStyle(
                        color: _selectedIndex == 2
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    )
        : Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.separator,
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.info,
                          color: _selectedIndex == 0
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.black,
                        ),
                        Text(
                          '전체 목록',
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.zoom_in,
                          color: _selectedIndex == 1
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.black,
                        ),
                        Text(
                          '주요 전시',
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.question_circle,
                          color: _selectedIndex == 2
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.black,
                        ),
                        Text(
                          '도움말',
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}