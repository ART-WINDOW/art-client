import 'package:flutter/cupertino.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,  // Stack이 전체 화면을 차지하도록 설정
      children: [
        child,
        if (isLoading)
          Positioned.fill(  // 전체 화면을 채우는 오버레이
            child: Container(
              color: CupertinoColors.systemBackground.withOpacity(0.7),
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 13.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}