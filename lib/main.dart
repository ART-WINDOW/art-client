import 'package:ART_WINDOW/screens/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'providers/exhibition_provider.dart';
import 'providers/major_exhibition_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExhibitionProvider()),
        ChangeNotifierProvider(create: (_) => MajorExhibitionProvider()),
      ],
      child: CupertinoApp(
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.systemIndigo,
        ),
        home: LoadingScreen(
          child: MainNavigationScreen(),
        ),
      ),
    );
  }
}