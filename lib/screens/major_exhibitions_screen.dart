import 'dart:math' show max;
import 'package:flutter/cupertino.dart';
import '../models/exhibition.dart';
import '../widgets/exhibition_card.dart';
import '../services/api_service.dart';
import '../widgets/loading_overlay.dart';

class MajorExhibitionsScreen extends StatefulWidget {
  @override
  _MajorExhibitionsScreenState createState() => _MajorExhibitionsScreenState();
}

class _MajorExhibitionsScreenState extends State<MajorExhibitionsScreen> {
  final ScrollController _scrollController = ScrollController();
  final ApiService _apiService = ApiService();
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 스크롤 위치가 최대 스크롤 범위의 절반 이상일 때 데이터를 로드합니다.
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent / 2 &&
        !_isLoading) {
      _loadExhibitions(); // 추가 데이터 로드 함수 호출
    }
  }

  Future<void> _loadExhibitions() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newExhibitions = await _apiService.fetchMajorExhibitions(
          page: _currentPage, pageSize: _pageSize);
      setState(() {
        _exhibitions.addAll(newExhibitions.where((newExhibition) {
          return !_exhibitions
              .any((existing) => existing.id == newExhibition.id);
        }).toList());
        _currentPage++;
      });
    } catch (error) {
      print('Error loading exhibitions: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget mainContent = screenWidth <= 600
        ? ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(8),
            itemCount: _exhibitions.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _exhibitions.length) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoActivityIndicator(
                      radius: 11,
                    ),
                  ),
                );
              }
              final exhibition = _exhibitions[index];
              return ExhibitionCard(exhibition: exhibition);
            },
          )
        : GridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: max(1, (screenWidth / 400).floor()),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.67,
            ),
            itemCount: _exhibitions.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _exhibitions.length) {
                return Center(
                    child: CupertinoActivityIndicator(
                  radius: 13,
                ));
              }
              final exhibition = _exhibitions[index];
              return ExhibitionCard(exhibition: exhibition);
            },
          );

    return CupertinoPageScaffold(
      child: LoadingOverlay(
        isLoading: _isLoading && _exhibitions.isEmpty,
        child: mainContent,
      ),
    );
  }
}
