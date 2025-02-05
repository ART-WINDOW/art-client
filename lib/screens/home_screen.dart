import 'dart:math' show max;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/exhibition_provider.dart';
import '../widgets/exhibition_card.dart';
import '../widgets/loading_overlay.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ExhibitionProvider>(context, listen: false);
      provider.loadExhibitions();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // ExhibitionProvider를 가져옵니다.
    final provider = Provider.of<ExhibitionProvider>(context, listen: false);
    // 스크롤 위치가 최대 범위의 절반 이상이고 로딩 중이 아닐 때 추가 데이터를 로드합니다.
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent / 2 &&
        !provider.isLoading) {
      // 검색 결과가 있는 경우, 검색 페이징 처리
      if (provider.searchResults.isNotEmpty) {
        provider.searchExhibitions(
          keyword: provider.lastSearchKeyword, // lastSearchKeyword를 public 또는 getter로 변경 필요
          area: null,
        );
      } else {
        // 일반 전시 목록 페이징 처리
        provider.loadExhibitions();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Consumer<ExhibitionProvider>(
        builder: (context, provider, child) {
          // 로딩 중일 때는 결과 없음 메시지를 표시하지 않음
          if (provider.lastSearchKeyword.isNotEmpty &&
              provider.searchResults.isEmpty &&
              !provider.isLoading) {  // 로딩 상태 체크 추가
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.search,
                    size: 50,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '"${provider.lastSearchKeyword}" 검색 결과가 없어요..',
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '다른 검색어로 다시 시도해보세요!',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            );
          }

          // 검색 결과가 있으면 검색 결과를, 없으면 전체 전시 목록을 표시
          final displayList = provider.searchResults.isNotEmpty
              ? provider.searchResults
              : provider.exhibitions;

          if (provider.isLoading && displayList.isEmpty) {
            return Center(child: CupertinoActivityIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('${provider.errorMessage}'));
          } else if (displayList.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          }

          final ongoingExhibitions = displayList
              .where((exhibition) => exhibition.status != 'COMPLETED')
              .toList();

          Widget mainContent = screenWidth <= 600
              ? ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(8),
            itemCount: ongoingExhibitions.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == ongoingExhibitions.length) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              final exhibition = ongoingExhibitions[index];
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
            itemCount: ongoingExhibitions.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == ongoingExhibitions.length) {
                return Center(child: CupertinoActivityIndicator());
              }
              final exhibition = ongoingExhibitions[index];
              return ExhibitionCard(exhibition: exhibition);
            },
          );

          return LoadingOverlay(
            isLoading: provider.isLoading && displayList.isEmpty,
            child: mainContent,
          );
        },
      ),
    );
  }
}