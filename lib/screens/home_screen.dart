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
    final apiService = ApiService(baseUrl: 'https://openapi.gg.go.kr/GGCULTUREVENTSTUS');
    exhibitions = apiService.fetchExhibitions();
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
                  title: Text(exhibition.title),
                  subtitle: Text(exhibition.instNm),
                  trailing: Image.network(exhibition.imageUrl),
                  onTap: () {
                    // 전시회 상세 정보 보기 등 추가 기능 구현 가능
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
