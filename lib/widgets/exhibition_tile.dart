import 'package:flutter/material.dart';
import '../models/exhibition.dart'; // Exhibition 모델을 가져옴

// 각 전시회 정보를 타일 형식으로 보여주는 위젯
class ExhibitionTile extends StatelessWidget {
  final Exhibition exhibition; // 전시회 객체를 받음

  ExhibitionTile({required this.exhibition});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exhibition.title), // 전시 제목을 표시
      subtitle: Text('${exhibition.place}, ${exhibition.status}'), // 전시 장소와 상태를 표시
      trailing: Image.network(
        exhibition.imgUrl, // 전시 이미지 URL을 표시
        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image), // 이미지 로딩 실패 시 아이콘 표시
      ),
      onTap: () {
        // 클릭 시 전시회 상세 페이지로 이동하는 로직을 추가할 수 있음
      },
    );
  }
}
