import 'package:flutter/material.dart';
import '../services/api_service.dart'; // 미술관 정보를 가져오는 서비스
import '../models/museum.dart';

class MuseumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 미술관 정보 로딩
    final apiService = ApiService();
    final Future<List<Museum>> museums = apiService.fetchMuseums();

    return FutureBuilder<List<Museum>>(
      future: museums,
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
              final museum = snapshot.data![index];
              return ListTile(
                title: Text(museum.name),
                subtitle: Text(museum.area),
                trailing: Icon(Icons.museum),
              );
            },
          );
        }
      },
    );
  }
}
