// Museum 모델 클래스
class Museum {
  final int id;              // 미술관 ID
  final String name;         // 미술관 이름
  final String area;         // 미술관 지역
  final String gpsX;         // X 좌표 (위도)
  final String gpsY;         // Y 좌표 (경도)
  final String contactInfo;  // 연락처 정보
  final String website;      // 웹사이트 URL

  Museum({
    required this.id,
    required this.name,
    required this.area,
    required this.gpsX,
    required this.gpsY,
    required this.contactInfo,
    required this.website,
  });

  // JSON 데이터를 Dart 객체로 변환하는 메서드
  factory Museum.fromJson(Map<String, dynamic> json) {
    return Museum(
      id: json['id'] as int,
      name: json['name'] ?? '',
      area: json['area'] ?? '',
      gpsX: json['gpsX'] ?? '',
      gpsY: json['gpsY'] ?? '',
      contactInfo: json['contactInfo'] ?? '',
      website: json['website'] ?? '',
    );
  }

  // Dart 객체를 JSON으로 변환하는 메서드 (필요 시 사용)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'area': area,
      'gpsX': gpsX,
      'gpsY': gpsY,
      'contactInfo': contactInfo,
      'website': website,
    };
  }
}
