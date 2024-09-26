import 'package:flutter/material.dart';
import '../models/exhibition.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Exhibition>> exhibitions;

  @override
  void initState() {
    super.initState();
    // 변경된 URL에 맞춘 baseUrl 설정 (API 경로 수정)
    final apiService = ApiService();
    exhibitions = apiService.fetchExhibitions(page: 0, pageSize: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전시회 정보'),
      ),
      body: FutureBuilder<List<Exhibition>>(
        future: exhibitions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final exhibition = snapshot.data![index];
                return ListTile(
                  title: Text(exhibition.title),   // 전시 제목
                  subtitle: Text('${exhibition.place}, ${exhibition.status}'), // 장소와 상태
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
