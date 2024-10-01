import 'package:flutter/material.dart';
import '../models/exhibition.dart'; // Exhibition 모델을 가져옴
import 'package:intl/intl.dart'; // 날짜 포맷을 위해 사용

// 각 전시회 정보를 타일 형식으로 보여주는 위젯
class ExhibitionTile extends StatelessWidget {
  final Exhibition exhibition; // 전시회 객체를 받음

  ExhibitionTile({required this.exhibition});

  // 상태를 한국어로 변환하는 함수
  String getStatusInKorean(String status) {
    switch (status) {
      case 'ONGOING':
        return '전시중';
      case 'SCHEDULED':
        return '예정';
      case 'COMPLETED':
        return '종료';
      default:
        return '알 수 없음';
    }
  }

  // 날짜를 'yyyy년 MM월 dd일' 형식으로 변환하는 함수
  String formatDate(DateTime date) {
    return DateFormat('yyyy년 MM월 dd일').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exhibition.title), // 전시 제목을 표시
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${formatDate(exhibition.startDate)} ~ ${formatDate(exhibition.endDate)}'), // 전시 시작일과 종료일 표시
          Text('${exhibition.place}'), // 전시 장소 표시
          Text('${getStatusInKorean(exhibition.status)}'),
          Text('${exhibition.area}'),
          SizedBox(height: 4),
        ],
      ),
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
