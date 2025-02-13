import 'package:flutter/cupertino.dart';
import '../models/exhibition.dart';
import '../widgets/exhibition_card.dart';
import '../services/api_service.dart';
import '../widgets/loading_overlay.dart';

class AreaScreen extends StatefulWidget {
  final String area;

  const AreaScreen({Key? key, required this.area}) : super(key: key);

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  final ScrollController _scrollController = ScrollController();
  final ApiService _apiService = ApiService();
  List<Exhibition> _exhibitions = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _pageSize = 30;

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
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent / 2 && !_isLoading) {
      _loadExhibitions();
    }
  }

  Future<void> _loadExhibitions() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newExhibitions = await _apiService.fetchExhibitionsByArea(
          area: widget.area,
          page: _currentPage,
          pageSize: _pageSize
      );

      setState(() {
        _exhibitions.addAll(newExhibitions.where((newExhibition) {
          return !_exhibitions.any((existing) => existing.id == newExhibition.id);
        }));
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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.area} 전시'),
      ),
      child: LoadingOverlay(
        isLoading: _isLoading && _exhibitions.isEmpty,
        child: screenWidth <= 600
            ? ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 70, left: 8, right: 8, bottom: 8),
          itemCount: _exhibitions.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _exhibitions.length) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            return ExhibitionCard(exhibition: _exhibitions[index]);
          },
        )
            : GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (screenWidth / 400).floor(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: _exhibitions.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _exhibitions.length) {
              return Center(child: CupertinoActivityIndicator());
            }
            return ExhibitionCard(exhibition: _exhibitions[index]);
          },
        ),
      ),
    );
  }
}