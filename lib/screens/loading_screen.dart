import 'package:flutter/cupertino.dart';

class LoadingScreen extends StatefulWidget {
  final Widget child;

  const LoadingScreen({Key? key, required this.child}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadFont();
  }

  Future<void> _loadFont() async {
    // 약간의 지연을 줘서 폰트가 확실히 로드되도록 함
    await Future.delayed(Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return Container(
        color: CupertinoColors.systemBackground,
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return widget.child;
  }
}