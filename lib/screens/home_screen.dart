import 'package:flutter/material.dart'; // Flutter 위젯을 사용하기 위한 라이브러리
import 'package:provider/provider.dart'; // 상태 관리를 위한 Provider 패키지
import '../providers/exhibition_provider.dart'; // ExhibitionProvider를 가져옴
import '../widgets/exhibition_tile.dart'; // ExhibitionTile 위젯을 가져옴

// 홈 화면을 정의하는 StatefulWidget
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// HomeScreen의 상태를 관리하는 클래스
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // 초기 데이터 로드를 위해 Provider에서 데이터를 불러온다
    final provider = Provider.of<ExhibitionProvider>(context, listen: false);
    provider.loadExhibitions(); // 전시회 데이터를 로드하는 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    // Consumer를 사용하여 ExhibitionProvider의 상태 변화를 감지
    return Scaffold(
      appBar: AppBar(
        title: Text('전시회 정보'), // 앱바 제목
      ),
      body: Consumer<ExhibitionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator()); // 로딩 중일 때의 표시
          } else if (provider.errorMessage != null) {
            return Center(child: Text('오류 발생: ${provider.errorMessage}')); // 오류 발생 시 메시지 표시
          } else if (provider.exhibitions.isEmpty) {
            return Center(child: Text('데이터가 없습니다.')); // 데이터가 없을 경우 표시
          } else {
            // ListView.builder를 사용하여 전시회 데이터를 나열
            return ListView.builder(
              itemCount: provider.exhibitions.length, // 전시회의 수
              itemBuilder: (context, index) {
                final exhibition = provider.exhibitions[index]; // 각 전시회 데이터
                return ListTile(
                  title: Text(exhibition.title), // 전시 제목
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${exhibition.getFormattedStartDate()} ~ ${exhibition.getFormattedEndDate()}', // 시작 날짜 ~ 종료 날짜
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text('${exhibition.place} | ${exhibition.area}'), // 장소
                      Text('${exhibition.getLocalizedStatus()}'), // 상태 (예정, 전시중, 종료)
                    ],
                  ),
                  trailing: Image.network(
                    exhibition.imgUrl, // 이미지 URL
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image), // 이미지 오류 처리
                  ),
                  onTap: () {
                    // 상세 정보 페이지로 이동 기능 추가 가능
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
