import 'package:flutter/cupertino.dart';
import '../models/exhibition.dart';
import '../widgets/exhibition_card.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart'; // DateFormat을 사용하기 위해 추가

class MajorExhibitionsScreen extends StatefulWidget {
  @override
  _MajorExhibitionsScreenState createState() => _MajorExhibitionsScreenState();
}

class _MajorExhibitionsScreenState extends State<MajorExhibitionsScreen> {
  final ScrollController _scrollController = ScrollController();
  final ApiService _apiService = ApiService(); // ApiService 인스턴스 추가
  List<Exhibition> _exhibitions = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadExhibitions();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _loadExhibitions();
    }
  }

  Future<void> _loadExhibitions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final newExhibitions = await _apiService.fetchMajorExhibitions(page: _currentPage, pageSize: _pageSize);
      setState(() {
        _exhibitions.addAll(newExhibitions);
        _currentPage++;
      });
    } catch (error) {
      // 오류 처리 로직 추가 가능
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'ONGOING':
        return '전시 중';
      case 'SCHEDULED':
        return '예정';
      case 'COMPLETED':
        return '종료';
      default:
        return '예정';
    }
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy년 MM월 dd일');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? (screenWidth / 300).floor() : (screenWidth / 400).floor(); // 각 아이템의 너비를 300으로 가정

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, // 화면 너비에 따라 열 수를 동적으로 설정
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: screenWidth < 600 ? 0.6 : 0.65, // 카드의 가로 세로 비율 조정
            ),
            itemCount: _exhibitions.length,
            itemBuilder: (context, index) {
              final exhibition = _exhibitions[index];
              return ExhibitionCard(exhibition: exhibition);
            },
          ),
          if (_isLoading)
            Center(child: CupertinoActivityIndicator()), // 로딩 이미지 중앙 배치
        ],
      ),
    );
  }
}