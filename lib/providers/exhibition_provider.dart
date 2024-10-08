import 'package:flutter/material.dart';
import '../models/exhibition.dart'; // 모델을 가져옴
import '../services/api_service.dart'; // API 서비스를 가져옴

// 전시회 데이터를 관리하는 Provider 클래스
class ExhibitionProvider with ChangeNotifier {
  final ApiService _apiService = ApiService(); // ApiService 인스턴스

  List<Exhibition> _exhibitions = []; // 전시회 리스트를 저장하는 변수
  bool _isLoading = false; // 데이터를 로드 중인지 여부를 나타냄
  String? _errorMessage; // 오류 메시지
  int _currentPage = 0; // 현재 페이지 번호

  List<Exhibition> get exhibitions => _exhibitions; // 전시회 데이터를 반환
  bool get isLoading => _isLoading; // 로딩 상태를 반환
  String? get errorMessage => _errorMessage; // 오류 메시지를 반환

  // 전시회 데이터를 로드하는 메서드
  Future<void> loadExhibitions({int pageSize = 10}) async {
    if (_isLoading) return; // 이미 로딩 중이면 중복 호출 방지

    _isLoading = true; // 로딩 시작
    _errorMessage = null; // 오류 메시지 초기화
    notifyListeners(); // 상태 변경 알림

    try {
      // API에서 데이터를 불러와서 exhibitions 리스트에 추가
      final newExhibitions = await _apiService.fetchExhibitions(page: _currentPage, pageSize: pageSize);

      // 중복 데이터 필터링
      final uniqueExhibitions = newExhibitions.where((newExhibition) {
        return !_exhibitions.any((existingExhibition) => existingExhibition.id == newExhibition.id);
      }).toList();

      _exhibitions.addAll(uniqueExhibitions);
      _currentPage++; // 페이지 번호 증가
    } catch (e) {
      _errorMessage = '데이터를 불러오는 중 오류가 발생했습니다: $e'; // 오류 발생 시 메시지 저장
    } finally {
      _isLoading = false; // 로딩 종료
      notifyListeners(); // 상태 변경 알림
    }
  }

  // 전시회 목록을 초기화하는 메서드
  void resetExhibitions() {
    _exhibitions = [];
    _currentPage = 0; // 페이지 번호 초기화
    notifyListeners(); // 상태 변경 알림
  }
}