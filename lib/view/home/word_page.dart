import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import '../../components/app_bar.dart';
import '../../components/gradient_box_decoration.dart';
import '../../components/toast_message.dart';
import '../../constants/lists.dart';
import '../drawers/left_drawer.dart';
import '../drawers/right_drawer.dart';
import '../from_left_drawer/word_favourites.dart';
import '../from_left_drawer/word_known.dart';
import '../from_left_drawer/word_unknown.dart';

class WordPage extends StatefulWidget {
  static Box<List<int>> knownWordsBox;
  static Box<List<int>> favouriteWordsBox;
  static Box<List<int>> unknownWordsBox;
  @override
  _WordPageState createState() => _WordPageState();
}

int wordCounter = 0;

class _WordPageState extends State<WordPage> {
  final FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    WordPage.knownWordsBox = Hive.box<List<int>>('knownWords');
    WordPage.favouriteWordsBox = Hive.box<List<int>>('favouriteWords');
    WordPage.unknownWordsBox = Hive.box<List<int>>('unknownWords');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'One Day One Word'),
      drawer: LeftDrawer(),
      endDrawer: RightDrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        children: [
          buildLowSizedBoxHeight(context),
          Center(
              child: Text('${wordCounter + 1}. ${wordEnglish[wordCounter]}',
                  style: Theme.of(context).textTheme.headline4)),
          buildLowSizedBoxHeight(context),
          buildSpeakRow(context),
          buildLowSizedBoxHeight(context),
          Center(
              child: Text(wordTurkish[wordCounter],
                  style: Theme.of(context).textTheme.headline4)),
          buildLowSizedBoxHeight(context),
          Center(
              child: Text(wordMeaning[wordCounter],
                  style: Theme.of(context).textTheme.headline6)),
        ],
      ),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      child: Container(
        decoration: buildGradientBoxDecoration(),
        child: Row(
          children: [
            buildMyBottomAppBarbutton(
                icon: Icons.arrow_back_sharp,
                onPressed: () {
                  if (wordCounter != 0) {
                    setState(() {
                      wordCounter--;
                    });
                  }
                }),
            buildMyBottomAppBarbutton(
                icon: Icons.check_circle_sharp,
                iconColor: Colors.green,
                onPressed: () {
                  var currentNumber = wordCounter;
                  if (!Known.known.contains(currentNumber)) {
                    Known.known.add(currentNumber);
                    WordPage.knownWordsBox.put('knowns', Known.known);
                    buildMyToastMessage(
                        color: Colors.green, text: 'Bildiklerime eklendi');
                  } else {
                    buildMyToastMessage(
                        color: Colors.green,
                        text: 'Önceden eklenmişti zaten');
                  }
                }),
            buildMyBottomAppBarbutton(
                icon: Icons.star_sharp,
                iconColor: Colors.yellow[600],
                onPressed: () {
                  var currentNumber = wordCounter;
                  if (!Favourites.favourites.contains(currentNumber)) {
                    Favourites.favourites.add(currentNumber);
                    WordPage.favouriteWordsBox
                        .put('favourites', Favourites.favourites);
                    buildMyToastMessage(
                      color: Colors.yellow[600],
                      text: 'Favori Kelimlerime eklendi',
                    );
                  } else {
                    buildMyToastMessage(
                        color: Colors.yellow[600],
                        text: 'Önceden eklenmişti zaten');
                  }
                }),
            buildMyBottomAppBarbutton(
                icon: Icons.cancel_sharp,
                iconColor: Colors.red,
                onPressed: () {
                  var currentNumber = wordCounter;
                  if (!Unknown.unknown.contains(currentNumber)) {
                    Unknown.unknown.add(currentNumber);
                    WordPage.unknownWordsBox.put('unknowns', Unknown.unknown);
                    buildMyToastMessage(
                        color: Colors.red, text: 'Bilmediklerime eklendi');
                  } else {
                    buildMyToastMessage(
                        color: Colors.red, text: 'Önceden eklenmişti zaten');
                  }
                }),
            buildMyBottomAppBarbutton(
                icon: Icons.arrow_forward_sharp,
                onPressed: () {
                  if (wordCounter == wordEnglish.length - 1) {
                  } else {
                    setState(() {
                      wordCounter++;
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }

  Row buildSpeakRow(BuildContext context) {
    void speak({@required String accentName}) {
      flutterTts.setLanguage(accentName);
      flutterTts.speak(wordEnglish[wordCounter]);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(Icons.volume_up_sharp),
            onPressed: () => speak(accentName: 'en-US')),
        Text(
          'Amerikan Aksanı',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.15),
        IconButton(
            icon: Icon(Icons.volume_up_sharp),
            onPressed: () => speak(accentName: 'en-GB')),
        Text(
          'İngiliz Aksanı',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }

  Expanded buildMyBottomAppBarbutton(
      {@required IconData icon,
      Color iconColor,
      @required VoidCallback onPressed}) {
    return Expanded(
        child: FlatButton(
      onPressed: onPressed,
      child: Icon(icon, color: iconColor, size: 40),
    ));
  }

  SizedBox buildLowSizedBoxHeight(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.01);
}
