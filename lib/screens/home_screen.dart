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
    final provider = Provider.of<ExhibitionProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        !provider.isLoading) {
      provider.loadExhibitions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Consumer<ExhibitionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.exhibitions.isEmpty) {
            return Center(child: CupertinoActivityIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('${provider.errorMessage}'));
          } else if (provider.exhibitions.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          }

          final ongoingExhibitions = provider.exhibitions
              .where((exhibition) => exhibition.status != 'COMPLETED')
              .toList();

          Widget mainContent = screenWidth <= 600
              ? ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(8),
            itemCount:
            ongoingExhibitions.length + (provider.isLoading ? 1 : 0),
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
            itemCount:
            ongoingExhibitions.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == ongoingExhibitions.length) {
                return Center(child: CupertinoActivityIndicator());
              }
              final exhibition = ongoingExhibitions[index];
              return ExhibitionCard(exhibition: exhibition);
            },
          );

          return LoadingOverlay(
            isLoading: provider.isLoading && provider.exhibitions.isEmpty,
            child: mainContent,
          );

        },
      ),
    );
  }
}