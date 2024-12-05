import 'dart:math' show max;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/exhibition_provider.dart';
import '../widgets/exhibition_card.dart';
import '../widgets/loading_overlay.dart';

class SearchResultScreen extends StatefulWidget {
  final String keyword;

  const SearchResultScreen({Key? key, required this.keyword}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.keyword);
    _scrollController.addListener(_onScroll);
    // 초기 검색 실행
    context.read<ExhibitionProvider>().searchExhibitions(
      keyword: widget.keyword,
      area: null,
    );
  }

  void _onScroll() {
    final provider = Provider.of<ExhibitionProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        !provider.isLoading) {
      provider.searchExhibitions(
        keyword: _searchController.text,
        area: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSearchTextField(
          controller: _searchController,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              final provider = context.read<ExhibitionProvider>();
              provider.clearSearch();
              provider.searchExhibitions(
                keyword: value,
                area: null,
              );
            }
          },
        ),
      ),
      child: Consumer<ExhibitionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.searchResults.isEmpty) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (!provider.isLoading && provider.searchResults.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '검색 결과가 없습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '다른 검색어를 입력해보세요.',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            );
          }

          Widget mainContent = screenWidth <= 600
              ? ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 90, left: 8, right: 8, bottom: 8),
            itemCount: provider.searchResults.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.searchResults.length) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              return ExhibitionCard(exhibition: provider.searchResults[index]);
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
            itemCount: provider.searchResults.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.searchResults.length) {
                return Center(
                    child: CupertinoActivityIndicator(
                      radius: 13,
                    ));
              }
              return ExhibitionCard(exhibition: provider.searchResults[index]);
            },
          );

          return LoadingOverlay(
            isLoading: provider.isLoading && provider.searchResults.isEmpty,
            child: mainContent,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}