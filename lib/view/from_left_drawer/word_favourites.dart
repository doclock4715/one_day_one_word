import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../../components/app_bar.dart';
import '../../constants/lists.dart';
import '../home/word_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Favourites extends StatefulWidget {
  static List<int> favourites = [];

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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
      appBar: MyAppBar(title: 'Favori Kelimelerim'),
      body: ListView.builder(
        itemCount: Favourites.favourites.length,
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
                      '${wordEnglish[Favourites.favourites[i]]} - ${wordTurkish[Favourites.favourites[i]]}');
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
                  '${Favourites.favourites[i] + 1}. ${wordEnglish[Favourites.favourites[i]]} - ${wordTurkish[Favourites.favourites[i]]}'),
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
