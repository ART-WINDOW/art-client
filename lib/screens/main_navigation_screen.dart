import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/major_exhibitions_screen.dart';
import '../screens/help_screen.dart';
import '../screens/area_screen.dart';
import '../providers/modal_state_provider.dart';
import 'package:provider/provider.dart';

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<String> areas = ['서울', '경기', '인천', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'];

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

  void _showAreaMenu(BuildContext context) {
    final modalProvider = Provider.of<ModalStateProvider>(context, listen: false);
    modalProvider.setModalVisible(true);  // 모달 열기 전에 상태 설정

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              '지역 선택',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          actions: areas.map((area) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  modalProvider.setModalVisible(false);  // 상태 업데이트
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AreaScreen(area: area),
                    ),
                  );
                },
                child: Text(
                  area,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            );
          }).toList(),
          cancelButton: Padding(
            padding: EdgeInsets.only(),
            child: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                modalProvider.setModalVisible(false);  // 상태 업데이트
              },
              child: Text('취소'),
            ),
          ),
        );
      },
    ).whenComplete(() {
      modalProvider.setModalVisible(false);  // 모달이 어떤 방식으로든 닫힐 때
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
                      CupertinoIcons.star,
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
              SizedBox(width: 16),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _showAreaMenu(context),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.map,
                      size: 18,
                      color: CupertinoColors.black,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '지역별',
                      style: TextStyle(
                        color: CupertinoColors.black,
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
                          CupertinoIcons.star,
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
                  GestureDetector(
                    onTap: () => _showAreaMenu(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.map,
                          color: CupertinoColors.black,
                        ),
                        Text(
                          '지역별',
                          style: TextStyle(
                            color: CupertinoColors.black,
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