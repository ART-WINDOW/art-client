import 'dart:convert';

import 'package:intl/intl.dart';

class Exhibition {
  final int id;                   // ID
  final String title;             // 제목
  final String description;       // 설명
  final String imgUrl;            // 이미지 URL
  final String area;              // 지역
  final DateTime startDate;       // 시작 일자
  final DateTime endDate;         // 종료 일자
  final String place;             // 장소
  final String status;            // 전시 상태 (예정, 진행 중, 종료)
  final String storageUrl;

  Exhibition({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.area,
    required this.startDate,
    required this.endDate,
    required this.place,
    required this.status,
    required this.storageUrl,
  });

  // 날짜를 보기 좋은 형식으로 변환
  String getFormattedStartDate() {
    return DateFormat('yyyy.MM.dd').format(startDate);
  }

  String getFormattedEndDate() {
    return DateFormat('yyyy.MM.dd').format(endDate);
  }

  // 전시 상태를 한글로 변환
  String getLocalizedStatus() {
    switch (status) {
      case 'SCHEDULED':
        return '전시 예정';
      case 'ONGOING':
        return '전시 중';
      case 'COMPLETED':
        return '전시 종료';
      default:
        return status; // 정의되지 않은 상태가 있으면 그대로 표시
    }
  }

  // JSON 데이터를 Dart 객체로 변환하는 메서드
  factory Exhibition.fromJson(Map<String, dynamic> json) {
    return Exhibition(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      area: json['area'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      place: json['place'] ?? '',
      status: json['status'] ?? '',
      storageUrl: json['storageUrl'] ?? '',
    );
  }
}
