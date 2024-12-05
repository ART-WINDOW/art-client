import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/exhibition_provider.dart';
import '../widgets/exhibition_card.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('전시 검색'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                placeholder: '전시회 또는 박물관 검색',
                onChanged: (value) {
                  // debounce 처리
                  Timer(Duration(milliseconds: 500), () {
                    context.read<ExhibitionProvider>().searchExhibitions(
                      keyword: value,
                    );
                  });
                },
              ),
            ),
            Expanded(
              child: Consumer<ExhibitionProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading && provider.exhibitions.isEmpty) {
                    return Center(child: CupertinoActivityIndicator());
                  }

                  if (provider.errorMessage != null) {
                    return Center(child: Text(provider.errorMessage!));
                  }

                  if (provider.exhibitions.isEmpty) {
                    return Center(child: Text('검색 결과가 없습니다'));
                  }

                  return ListView.builder(
                    itemCount: provider.exhibitions.length,
                    itemBuilder: (context, index) {
                      return ExhibitionCard(
                        exhibition: provider.exhibitions[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}