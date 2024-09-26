import 'dart:convert'; // JSON 처리
import 'package:html/parser.dart' as html_parser;

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
  });

  // JSON 데이터를 Dart 객체로 변환하는 메서드
  factory Exhibition.fromJson(Map<String, dynamic> json) {
    // HTML 엔터티를 디코딩하는 부분 추가
    String decodeHtml(String input) {
      return html_parser.parse(input).body?.text ?? input;
    }

    return Exhibition(
      id: json['id'] as int,
      title: decodeHtml(json['title'] ?? ''),
      description: decodeHtml(json['description'] ?? ''),
      imgUrl: decodeHtml(json['imgUrl'] ?? ''),
      area: decodeHtml(json['area'] ?? ''),
      startDate: DateTime.parse(json['startDate'] ?? ''),
      endDate: DateTime.parse(json['endDate'] ?? ''),
      place: decodeHtml(json['place'] ?? ''),
      status: json['status'] ?? '',
    );
  }
}
