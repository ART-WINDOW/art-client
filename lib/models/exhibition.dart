class Exhibition {
  final int id;
  final String title;
  final String description;
  final String imgUrl;
  final String area;
  final DateTime startDate;
  final DateTime endDate;
  final String place;
  final String status;
  final String storageUrl;
  final String url;
  final String price;

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
    required this.url,
    required this.price,
  });

  factory Exhibition.fromJson(Map<String, dynamic> json) {
    return Exhibition(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      area: json['area'] ?? '',
      startDate: DateTime(json['startDate'][0], json['startDate'][1], json['startDate'][2]),
      endDate: DateTime(json['endDate'][0], json['endDate'][1], json['endDate'][2]),
      place: json['place'] ?? '',
      price: json['price'] ?? '',
      status: json['status'] ?? '',
      storageUrl: json['storageUrl'] ?? '',
      url: json['url'] ?? '',
    );
  }

  String getFormattedStartDate() {
    return '${startDate.year}.${startDate.month.toString().padLeft(2, '0')}.${startDate.day.toString().padLeft(2, '0')}';
  }

  String getFormattedEndDate() {
    return '${endDate.year}.${endDate.month.toString().padLeft(2, '0')}.${endDate.day.toString().padLeft(2, '0')}';
  }

  String getLocalizedStatus() {
    switch (status) {
      case 'ONGOING':
        return '진행 중';
      case 'UPCOMING':
        return '예정';
      case 'ENDED':
        return '종료';
      default:
        return '알 수 없음';
    }
  }
}