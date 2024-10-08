import 'package:flutter/material.dart';
import '../services/api_service.dart'; // 미술관 정보를 가져오는 서비스
import '../models/museum.dart';

class MuseumScreen extends StatefulWidget {
  @override
  _MuseumScreenState createState() => _MuseumScreenState();
}

class _MuseumScreenState extends State<MuseumScreen> {
  final ScrollController _scrollController = ScrollController(); // 스크롤 컨트롤러
  final ApiService _apiService = ApiService(); // API 서비스 인스턴스
  List<Museum> _museums = []; // 미술관 리스트
  bool _isLoading = false; // 로딩 상태
  int _currentPage = 0; // 현재 페이지
  final int _pageSize = 10; // 페이지 크기

  @override
  void initState() {
    super.initState();
    _fetchMuseums(); // 초기 데이터 로드
    _scrollController.addListener(_onScroll); // 스크롤 리스너 추가
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 스크롤 컨트롤러 해제
    super.dispose();
  }

  void _onScroll() {
    // 스크롤이 리스트의 끝에 도달했을 때 추가 데이터 로드
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _fetchMuseums();
    }
  }

  Future<void> _fetchMuseums() async {
    setState(() {
      _isLoading = true; // 로딩 상태로 설정
    });

    try {
      final newMuseums = await _apiService.fetchMuseums(page: _currentPage, pageSize: _pageSize); // 새로운 미술관 데이터 로드
      setState(() {
        _museums.addAll(newMuseums); // 기존 리스트에 추가
        _currentPage++; // 페이지 증가
      });
    } catch (error) {
      // 오류 처리 로직 추가 가능
    } finally {
      setState(() {
        _isLoading = false; // 로딩 상태 해제
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('미술관 목록'),
      ),
      body: ListView.builder(
        controller: _scrollController, // 스크롤 컨트롤러 설정
        itemCount: _museums.length + (_isLoading ? 1 : 0), // 로딩 중일 때 로딩 아이콘을 표시하기 위해 아이템 수 조정
        itemBuilder: (context, index) {
          if (index == _museums.length) {
            return Center(child: CircularProgressIndicator()); // 로딩 아이콘 표시
          }
          final museum = _museums[index];
          return ListTile(
            title: Text(museum.name), // 미술관 이름 표시
            subtitle: Text(museum.area), // 미술관 지역 표시
            trailing: Icon(Icons.museum), // 미술관 아이콘 표시
          );
        },
      ),
    );
  }
}