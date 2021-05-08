import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:one_day_one_word/core/base/base_state.dart';
import 'package:one_day_one_word/core/components/app_bar.dart';
import 'package:share/share.dart';
import '../home/word_page_view.dart';

class Unknown extends StatefulWidget {
  static List<int> unknown = [];

  @override
  _UnknownState createState() => _UnknownState();
}

class _UnknownState extends State<Unknown> with BaseState{
  @override
  void initState() {
    WordPage.unknownWordsBox.get('unknowns') != null
        ? Unknown.unknown = WordPage.unknownWordsBox.get('unknowns')
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: applicationStrings.titleUnknown),
      body: ListView.builder(
        itemCount: Unknown.unknown.length,
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
                      '${wordContent.wordEnglish[Unknown.unknown[i]]} - ${wordContent.wordTurkish[Unknown.unknown[i]]}');
                },
              ),
            ],
            secondaryActions: [
              IconSlideAction(
                caption: applicationStrings.delete,
                color: Colors.redAccent,
                icon: Icons.delete_forever,
                onTap: () {
                  setState(
                    () {
                      var temp = WordPage.unknownWordsBox.get('unknowns');
                      temp.removeAt(i);
                      WordPage.unknownWordsBox.put('unknowns', temp);
                    },
                  );
                },
              )
            ],
            child: ListTile(
              title: Text(
                  '${Unknown.unknown[i] + 1}. ${wordContent.wordEnglish[Unknown.unknown[i]]} - ${wordContent.wordTurkish[Unknown.unknown[i]]}'),
              onTap: () {
                wordCounter = Unknown.unknown[i];
                Navigator.pushNamed(context, '/');
              },
            ),
          );
        },
      ),
    );
  }
}
