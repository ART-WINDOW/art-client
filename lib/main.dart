import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 상태 관리 패키지
import 'providers/exhibition_provider.dart'; // 전시회 데이터를 관리하는 provider
import 'providers/major_exhibition_provider.dart'; // 전시회 데이터를 관리하는 provider
import 'screens/home_screen.dart'; // 홈 스크린을 보여주는 위젯
import 'screens/major_exhibitions_screen.dart'; //

// Flutter 애플리케이션의 진입점 역할을 하는 함수
void main() {
  runApp(MyApp()); // MyApp을 실행하여 앱을 시작
}

// 전체 앱의 구조를 정의하는 클래스
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MultiProvider를 사용하여 여러 상태를 관리할 수 있음
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider로 ExhibitionProvider를 제공, 상태 관리 역할
        ChangeNotifierProvider(create: (_) => ExhibitionProvider()),
        ChangeNotifierProvider(create: (_) => MajorExhibitionProvider()), // 주요 전시 provider 추가
      ],
      child: MaterialApp(
        // title: '전시회 정보', // 앱의 이름
        theme: ThemeData(
          primarySwatch: Colors.blue, // 앱의 기본 테마 색상
        ),
        home: MainNavigationScreen(), // 처음 보여줄 화면을 MainNavigationScreen으로 설정
      ),
    );
  }
}

// 메인 네비게이션 구조를 담당하는 클래스
class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0; // 현재 선택된 네비게이션 항목의 인덱스

  // 각 네비게이션 항목에 해당하는 위젯들을 리스트로 정의
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // 첫 번째 탭: 홈 스크린
    MajorExhibitionsScreen(), // 두 번째 탭: 주요 전시
    // const Center(child: Text('내 정보', style: TextStyle(fontSize: 30))), // 세 번째 탭: 내 정보
  ];

  // 현재 선택된 네비게이션 항목에 따라 화면을 변경하는 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 탭의 인덱스를 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    // 화면의 가로 크기를 확인하여 웹 또는 모바일에 맞는 네비게이션 바를 선택
    bool isWeb = MediaQuery.of(context).size.width > 600; // 600 이상일 경우 웹으로 간주

    return Scaffold(
      appBar: AppBar(
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // 현재 선택된 화면을 body에 표시
      bottomNavigationBar: isWeb
          ? null // 웹인 경우 하단 네비게이션 바를 사용하지 않음
          : BottomNavigationBar(
        // 하단 네비게이션 바 (모바일용)
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // 홈 아이콘
            label: '홈', // 홈 라벨
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star), // 주요 전시 아이콘
            label: '주요 전시', // 주요 전시 라벨
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person), // 내 정보 아이콘
          //   label: '내 정보', // 내 정보 라벨
          // ),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        selectedItemColor: Colors.blue, // 선택된 항목의 색상
        onTap: _onItemTapped, // 탭 클릭 시 호출되는 함수
      ),
      // 웹인 경우 상단 네비게이션 바를 표시
      drawer: isWeb
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '전시회 정보',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('홈'),
              onTap: () {
                _onItemTapped(0); // 첫 번째 탭 선택
                Navigator.pop(context); // 드로어 닫기
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('주요 전시'),
              onTap: () {
                _onItemTapped(1); // 두 번째 탭 선택
                Navigator.pop(context); // 드로어 닫기
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.person),
            //   title: Text('내 정보'),
            //   onTap: () {
            //     _onItemTapped(2); // 세 번째 탭 선택
            //     Navigator.pop(context); // 드로어 닫기
            //   },
            // ),
          ],
        ),
      )
          : null, // 모바일일 경우 Drawer(드로어)를 사용하지 않음
    );
  }
}
