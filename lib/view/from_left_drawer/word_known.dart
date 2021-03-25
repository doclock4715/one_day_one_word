import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import '../../components/app_bar.dart';
import '../../constants/lists.dart';
import '../home/word_page.dart';

class Known extends StatefulWidget {
  static List<int> known = [];

  @override
  _KnownState createState() => _KnownState();
}

class _KnownState extends State<Known> {
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
      appBar: MyAppBar(title: 'Bildiğim Kelimeler'),
      body: ListView.builder(
        itemCount: Known.known.length,
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
                      '${wordEnglish[Known.known[i]]} - ${wordTurkish[Known.known[i]]}');
                },
              )
            ],
            secondaryActions: [
              IconSlideAction(
                caption: 'Sil',
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
                  '${Known.known[i] + 1}. ${wordEnglish[Known.known[i]]} - ${wordTurkish[Known.known[i]]}'),
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
