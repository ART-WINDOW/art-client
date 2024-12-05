import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/exhibition_provider.dart';

class ExhibitionSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget searchField = CupertinoSearchTextField(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
      style: TextStyle(fontSize: 14),
      placeholder: '전시회나 미술관으로 검색해주세요',
      placeholderStyle: TextStyle(
        fontSize: 14,
        color: CupertinoColors.systemGrey,
      ),
      prefixInsets: EdgeInsets.only(left: 8),
      suffixInsets: EdgeInsets.only(right: 8),
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          context.read<ExhibitionProvider>().searchExhibitions(
            keyword: value,
            area: null,
          );
        }
      },
      onChanged: (value) {
        if (value.isEmpty) {
          context.read<ExhibitionProvider>().clearSearch();
        }
      },
    );

    if (screenWidth > 600) {
      return Container(
        width: 250,
        height: 35,
        child: searchField,
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: searchField,
      );
    }
  }
}