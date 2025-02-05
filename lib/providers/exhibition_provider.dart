import 'package:flutter/material.dart';
import '../models/exhibition.dart'; // 모델을 가져옴
import '../services/api_service.dart'; // API 서비스를 가져옴

// 전시회 데이터를 관리하는 Provider 클래스
class ExhibitionProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Exhibition> _exhibitions = [];
  List<Exhibition> _searchResults = []; // 검색 결과를 별도로 관리
  bool _isLoading = false;
  String? _errorMessage;
  int _currentPage = 0;
  int _searchPage = 0;
  String _lastSearchKeyword = '';
  bool _hasMoreSearchResults = true;

  String get lastSearchKeyword => _lastSearchKeyword;

  List<Exhibition> get exhibitions => _exhibitions;

  List<Exhibition> get searchResults => _searchResults;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> searchExhibitions(
      {required String keyword, String? area}) async {
    if (_isLoading || !_hasMoreSearchResults) return;

    // 검색어가 비었을 때는 검색 결과를 초기화하고 전체 전시가 보이도록
    if (keyword.trim().isEmpty) {
      clearSearch();
      return;
    }

    // 새로운 검색어인 경우 초기화
    if (keyword != _lastSearchKeyword) {
      _searchResults = [];
      _searchPage = 0;
      _lastSearchKeyword = keyword;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newExhibitions = await _apiService.searchExhibitions(
        keyword: keyword,
        area: area,
        page: _searchPage,
      );

      if (newExhibitions.isEmpty) {
        _hasMoreSearchResults = false;
      } else {
        // 중복 제거하면서 결과 추가
        final uniqueExhibitions = newExhibitions.where((newExhibition) {
          return !_searchResults.any((existing) => existing.id == newExhibition.id);
        }).toList();
        _searchResults.addAll(uniqueExhibitions);
        _searchPage++;
      }
    } catch (e) {
      _errorMessage = '검색 중 오류가 발생했습니다: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    _searchPage = 0;
    _lastSearchKeyword = '';
    _hasMoreSearchResults = true;
    notifyListeners();
  }

  // 기존 loadExhibitions 메소드는 그대로 유지
  Future<void> loadExhibitions({int pageSize = 12}) async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newExhibitions = await _apiService.fetchExhibitions(
          page: _currentPage, pageSize: pageSize);

      final uniqueExhibitions = newExhibitions.where((newExhibition) {
        return !_exhibitions.any((existing) => existing.id == newExhibition.id);
      }).toList();

      _exhibitions.addAll(uniqueExhibitions);
      _currentPage++;
    } catch (e) {
      _errorMessage = '서버가 잠시 점검중이에요.\n다음에 다시 방문해주세요.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
