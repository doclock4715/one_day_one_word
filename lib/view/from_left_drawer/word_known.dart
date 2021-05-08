import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:one_day_one_word/core/base/base_state.dart';
import 'package:one_day_one_word/core/components/app_bar.dart';
import 'package:share/share.dart';
import '../home/word_page_view.dart';

class Known extends StatefulWidget {
  static List<int> known = [];

  @override
  _KnownState createState() => _KnownState();
}

class _KnownState extends State<Known> with BaseState {
  @override
  void initState() {
    WordPage.knownWordsBox.get('knowns') != null
        ? Known.known = WordPage.knownWordsBox.get('knowns')
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: applicationStrings.titleKnown),
      body: ListView.builder(
        itemCount: Known.known.length,
        itemBuilder: (context, i) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: [
              IconSlideAction(
                caption: applicationStrings.share,
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () {
                  Share.share(
                      '${wordContent.wordEnglish[Known.known[i]]} - ${wordContent.wordTurkish[Known.known[i]]}');
                },
              )
            ],
            secondaryActions: [
              IconSlideAction(
                caption: applicationStrings.delete,
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  setState(
                    () {
                      var temp = WordPage.knownWordsBox.get('knowns');
                      temp.removeAt(i);
                      WordPage.knownWordsBox.put('knowns', temp);
                    },
                  );
                },
              ),
            ],
            child: ListTile(
              title: Text(
                  '${Known.known[i] + 1}. ${wordContent.wordEnglish[Known.known[i]]} - ${wordContent.wordTurkish[Known.known[i]]}'),
              onTap: () {
                wordCounter = Known.known[i];
                Navigator.pushNamed(context, '/');
              },
            ),
          );
        },
      ),
    );
  }
}
