import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'view/from_left_drawer/quiz.dart';
import 'view/from_left_drawer/word_favourites.dart';
import 'view/from_left_drawer/word_known.dart';
import 'view/from_left_drawer/word_unknown.dart';
import 'view/home/word_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<List<int>>('knownWords');
  await Hive.openBox<List<int>>('favouriteWords');
  await Hive.openBox<List<int>>('unknownWords');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => WordPage(),
        '/known': (context) => Known(),
        '/favourites': (context) => Favourites(),
        '/unknown': (context) => Unknown(),
        '/quiz': (context) => Quiz(),
      },
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
