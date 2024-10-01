import 'package:flutter/material.dart';
import '../models/exhibition.dart';
import '../services/api_service.dart'; // ApiService를 통해 전시 정보를 불러옴

class MajorExhibitionProvider with ChangeNotifier {
  List<Exhibition> _majorExhibitions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Exhibition> get majorExhibitions => _majorExhibitions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 주요 전시 데이터를 불러오는 메소드
  Future<void> loadMajorExhibitions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiService = ApiService();
      _majorExhibitions = await apiService.fetchMajorExhibitions();
    } catch (error) {
      _errorMessage = 'Failed to load major exhibitions: $error';
    }

    _isLoading = false;
    notifyListeners(); // 데이터를 불러온 후 상태를 갱신
  }
}
