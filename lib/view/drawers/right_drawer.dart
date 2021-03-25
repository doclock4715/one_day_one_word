import 'package:flutter/material.dart';
import '../../components/gradient_box_decoration.dart';
import '../../constants/lists.dart';
import '../home/word_page.dart';

class RightDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        padding: EdgeInsets.all(0),
        itemCount: wordEnglish.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Expanded(
              child: DrawerHeader(
                  decoration: buildGradientBoxDecoration(),
                  child: Text('Kelime Listesi',
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white))),
            );
          } else {
            return buildWords(i, context);
          }
        },
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                  'Tüm Kelimelere Hızlı Erişim',
                  style: Theme.of(context).textTheme.headline6,
                ));
          } else {
            return Divider();
          }
        },
      ),
    );
  }

  ListTile buildWords(int i, BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.forward),
      title: Text('$i${'. ${wordEnglish[i - 1]} - '}${wordTurkish[i - 1]}'),
      onTap: () {
        wordCounter = i - 1;
        Navigator.pushNamed(context, '/');
      },
    );
  }
}
