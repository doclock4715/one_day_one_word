import 'package:flutter/material.dart';
import 'package:one_day_one_word/core/base/base_state.dart';
import 'package:one_day_one_word/core/components/app_bar.dart';
import 'package:share/share.dart';
import '../home/word_page_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Favourites extends StatefulWidget {
  static List<int> favourites = [];

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> with BaseState {
  @override
  void initState() {
    WordPage.favouriteWordsBox.get('favourites') != null
        ? Favourites.favourites = WordPage.favouriteWordsBox.get('favourites')
        : null;
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: applicationStrings.titleFav),
      body: ListView.builder(
        itemCount: Favourites.favourites.length,
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
                      '${wordContent.wordEnglish[Favourites.favourites[i]]} - ${wordContent.wordTurkish[Favourites.favourites[i]]}');
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
                      var temp = WordPage.favouriteWordsBox.get('favourites');
                      temp.removeAt(i);
                      WordPage.favouriteWordsBox.put('favourites', temp);
                    },
                  );
                },
              )
            ],
            child: ListTile(
              title: Text(
                  '${Favourites.favourites[i] + 1}. ${wordContent.wordEnglish[Favourites.favourites[i]]} - ${wordContent.wordTurkish[Favourites.favourites[i]]}'),
              onTap: () {
                wordCounter = Favourites.favourites[i];
                Navigator.pushNamed(context, '/');
              },
            ),
          );
        },
      ),
    );
  }
}
