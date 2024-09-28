import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Major 전시 정보를 가져오는 서비스 추가
import '../models/exhibition.dart';

class MajorExhibitionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Major 전시 정보 로딩
    final apiService = ApiService();
    final Future<List<Exhibition>> majorExhibitions = apiService.fetchMajorExhibitions(page: 0, pageSize: 10);

    return FutureBuilder<List<Exhibition>>(
      future: majorExhibitions,
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
                subtitle: Text(exhibition.place),
                trailing: Image.network(
                  exhibition.imgUrl,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                ),
              );
            },
          );
        }
      },
    );
  }
}
