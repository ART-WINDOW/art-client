import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/exhibition_provider.dart';
import '../widgets/exhibition_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ExhibitionProvider>(context, listen: false);
      provider.loadExhibitions();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = Provider.of<ExhibitionProvider>(context, listen: false);
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !provider.isLoading) {
      provider.loadExhibitions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth / 400).floor(); // 각 아이템의 너비를 400으로 가정

    return CupertinoPageScaffold(
      child: Consumer<ExhibitionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.exhibitions.isEmpty) {
            return Center(child: CupertinoActivityIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('오류 발생: ${provider.errorMessage}'));
          } else if (provider.exhibitions.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          } else {
            final ongoingExhibitions = provider.exhibitions.where((exhibition) => exhibition.status != 'COMPLETED').toList();
            return GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // 화면 너비에 따라 열 수를 동적으로 설정
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7, // 카드의 가로 세로 비율 조정
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
          }
        },
      ),
    );
  }
}