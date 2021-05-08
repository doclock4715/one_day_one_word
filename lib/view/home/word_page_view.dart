import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:one_day_one_word/core/base/base_state.dart';
import 'package:one_day_one_word/core/components/app_bar.dart';
import 'package:one_day_one_word/core/components/gradient_box_decoration.dart';
import '../drawers/left_drawer.dart';
import '../drawers/right_drawer.dart';
import '../from_left_drawer/word_favourites.dart';
import '../from_left_drawer/word_known.dart';
import '../from_left_drawer/word_unknown.dart';
import 'word_page_view_model.dart';

class WordPage extends StatefulWidget {
  static Box<List<int>> knownWordsBox;
  static Box<List<int>> favouriteWordsBox;
  static Box<List<int>> unknownWordsBox;
  @override
  _WordPageState createState() => _WordPageState();
}

int wordCounter = 0;

class _WordPageState extends State<WordPage> with BaseState {
  final WordPageViewModel viewModel = WordPageViewModel();
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
          Text('${wordCounter + 1}. ${wordContent.wordEnglish[wordCounter]}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4),
          buildLowSizedBoxHeight(context),
          buildPronunciationRow(context),
          buildLowSizedBoxHeight(context),
          Text(wordContent.wordTurkish[wordCounter],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4),
          buildLowSizedBoxHeight(context),
          Text(wordContent.wordMeaning[wordCounter],
              style: Theme.of(context).textTheme.headline6),
        ],
      ),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  Row buildPronunciationRow(BuildContext context) {
    void speak({@required String accentName}) {
      flutterTts.setLanguage(accentName);
      flutterTts.speak(wordContent.wordEnglish[wordCounter]);
    }

    return Row(
      children: [
        IconButton(
            icon: Icon(Icons.volume_up_sharp),
            onPressed: () => speak(accentName: 'en-US')),
        Text('Amerikan Aksanı', style: Theme.of(context).textTheme.subtitle1),
        SizedBox(width: MediaQuery.of(context).size.width * 0.15),
        IconButton(
            icon: Icon(Icons.volume_up_sharp),
            onPressed: () => speak(accentName: 'en-GB')),
        Text('İngiliz Aksanı', style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      child: Container(
        decoration: LinearGradientBoxDecoration().buildGradientBoxDecoration(),
        child: buildBottomAppBarButonRow(),
      ),
    );
  }

  Row buildBottomAppBarButonRow() {
    return Row(
      children: [
        buildMyBottomAppBarbutton(
          icon: Icons.arrow_back_sharp,
          onPressed: arrowBackOnPressed,
        ),
        buildMyBottomAppBarbutton(
          icon: Icons.check_circle_sharp,
          iconColor: Colors.green,
          onPressed: checkButtonOnPressed,
        ),
        buildMyBottomAppBarbutton(
          icon: Icons.star_sharp,
          iconColor: Colors.yellow[600],
          onPressed: starButtonOnPressed,
        ),
        buildMyBottomAppBarbutton(
          icon: Icons.cancel_sharp,
          iconColor: Colors.red,
          onPressed: cancelButtonOnPressed,
        ),
        buildMyBottomAppBarbutton(
          icon: Icons.arrow_forward_sharp,
          onPressed: arrowForwardOnPressed,
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
      ),
    );
  }

  void arrowBackOnPressed() {
    if (wordCounter != 0) {
      setState(() {
        wordCounter--;
      });
    }
  }

  void checkButtonOnPressed() {
    var currentNumber = wordCounter;
    if (!Known.known.contains(currentNumber)) {
      Known.known.add(currentNumber);
      WordPage.knownWordsBox.put('knowns', Known.known);
      viewModel.buildMyToastMessage(
          color: Colors.green, text: applicationStrings.addedKnown);
    } else {
      viewModel.buildMyToastMessage(
          color: Colors.green, text: applicationStrings.alreadyAdded);
    }
  }

  void starButtonOnPressed() {
    var currentNumber = wordCounter;
    if (!Favourites.favourites.contains(currentNumber)) {
      Favourites.favourites.add(currentNumber);
      WordPage.favouriteWordsBox.put('favourites', Favourites.favourites);
      viewModel.buildMyToastMessage(
        color: Colors.yellow[600],
        text: applicationStrings.addedFav,
      );
    } else {
      viewModel.buildMyToastMessage(
          color: Colors.yellow[600], text: applicationStrings.alreadyAdded);
    }
  }

  void cancelButtonOnPressed() {
    var currentNumber = wordCounter;
    if (!Unknown.unknown.contains(currentNumber)) {
      Unknown.unknown.add(currentNumber);
      WordPage.unknownWordsBox.put('unknowns', Unknown.unknown);
      viewModel.buildMyToastMessage(
          color: Colors.red, text: applicationStrings.addedUnknown);
    } else {
      viewModel.buildMyToastMessage(
          color: Colors.red, text: applicationStrings.alreadyAdded);
    }
  }

  void arrowForwardOnPressed() {
    if (wordCounter == wordContent.wordEnglish.length - 1) {
    } else {
      setState(() {
        wordCounter++;
      });
    }
  }

  SizedBox buildLowSizedBoxHeight(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.01);
}
