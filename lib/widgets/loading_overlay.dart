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
      children: [
        child,
        if (isLoading)
          Container(
            color: CupertinoColors.systemBackground.withOpacity(0.7),
            child: const Center(
              child: CupertinoActivityIndicator(
                radius: 20.0,
              ),
            ),
          ),
      ],
    );
  }
}