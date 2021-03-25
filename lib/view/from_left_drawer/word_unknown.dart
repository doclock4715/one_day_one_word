import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import '../../components/app_bar.dart';
import '../../constants/lists.dart';
import '../home/word_page.dart';

class Unknown extends StatefulWidget {
  static List<int> unknown = [];

  @override
  _UnknownState createState() => _UnknownState();
}

class _UnknownState extends State<Unknown> {
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
      appBar: MyAppBar(title: 'Bilmediğim Kelimeler'),
      body: ListView.builder(
        itemCount: Unknown.unknown.length,
        itemBuilder: (context, i) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: [
              IconSlideAction(
                caption: 'Paylaş',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () {
                  Share.share(
                      '${wordEnglish[Unknown.unknown[i]]} - ${wordTurkish[Unknown.unknown[i]]}');
                },
              ),
            ],
            secondaryActions: [
              IconSlideAction(
                caption: 'Delete',
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
                  '${Unknown.unknown[i] + 1}. ${wordEnglish[Unknown.unknown[i]]} - ${wordTurkish[Unknown.unknown[i]]}'),
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
