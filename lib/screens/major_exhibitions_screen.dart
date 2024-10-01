import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Major 전시 정보를 가져오는 서비스 추가
import '../models/exhibition.dart'; // Exhibition 모델을 가져옴
import 'package:intl/intl.dart'; // 날짜 포맷을 위한 라이브러리

// 주요 전시 정보를 보여주는 화면
class MajorExhibitionsScreen extends StatelessWidget {
  // 전시 상태를 한글로 변환하는 메서드
  String getStatusText(String status) {
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

  // 날짜 포맷을 설정하는 메서드
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    // ApiService 인스턴스를 생성하여 Major 전시 데이터를 가져옴
    final apiService = ApiService();

    // Major 전시 데이터를 가져오는 Future 객체
    final Future<List<Exhibition>> majorExhibitions = apiService.fetchMajorExhibitions(page: 0, pageSize: 10);

    return FutureBuilder<List<Exhibition>>(
      future: majorExhibitions, // Future 객체를 전달하여 데이터를 비동기로 로드
      builder: (context, snapshot) {
        // 데이터를 로딩 중일 때 표시할 위젯
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // 로딩 중일 때 로딩 아이콘을 표시
        }
        // 오류 발생 시 표시할 위젯
        else if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}')); // 오류 메시지 표시
        }
        // 데이터가 없거나 빈 경우에 표시할 위젯
        else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('데이터가 없습니다.')); // 데이터가 없는 경우 메시지 표시
        }
        // 데이터를 성공적으로 불러온 경우 리스트뷰로 전시 정보를 표시
        else {
          return ListView.builder(
            itemCount: snapshot.data!.length, // 전시 개수를 기준으로 리스트 항목을 생성
            itemBuilder: (context, index) {
              final exhibition = snapshot.data![index]; // 각 전시 데이터를 가져옴
              return ListTile(
                title: Text(exhibition.title), // 전시 제목 표시
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${formatDate(exhibition.startDate)} ~ ${formatDate(exhibition.endDate)}'), // 전시 날짜 표시
                    Text('${exhibition.place}'), // 전시 장소와 상태 표시
                    Text('${getStatusText(exhibition.status)}'),
                    Text('${exhibition.area}'),
                  ],
                ),
                trailing: Image.network(
                  exhibition.imgUrl, // 전시 이미지 표시
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image), // 이미지 로딩 실패 시 아이콘 표시
                ),
              );
            },
          );
        }
      },
    );
  }
}
