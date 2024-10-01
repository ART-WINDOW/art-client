import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exhibition_provider.dart';
import '../widgets/exhibition_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding을 사용하여 프레임이 완료된 후에 데이터를 로드하도록 한다
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ExhibitionProvider>(context, listen: false);
      provider.loadExhibitions(); // 전시회 데이터를 로드
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전시회 정보'),
      ),
      body: Consumer<ExhibitionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('오류 발생: ${provider.errorMessage}'));
          } else if (provider.exhibitions.isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          } else {
            return ListView.builder(
              itemCount: provider.exhibitions.length,
              itemBuilder: (context, index) {
                final exhibition = provider.exhibitions[index];
                return ExhibitionTile(exhibition: exhibition);
              },
            );
          }
        },
      ),
    );
  }
}
