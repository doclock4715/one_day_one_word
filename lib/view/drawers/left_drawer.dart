import 'package:flutter/material.dart';
import '../../components/gradient_box_decoration.dart';

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.all(0), children: [
        Expanded(
          child: DrawerHeader(
            decoration: buildGradientBoxDecoration(),
            child: Text('Menü',
                style: Theme.of(context).textTheme.headline3.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.white)),
          ),
        ),
        buildMenuItem(context,
            icon: Icon(Icons.check_circle_sharp, color: Colors.green),
            stringTitle: 'Bildiğim Kelimeler',
            toWhichPage: '/known'),
        buildMenuItem(context,
            icon: Icon(Icons.star_sharp, color: Colors.yellow[600]),
            stringTitle: 'Favori Kelimelerim',
            toWhichPage: '/favourites'),
        buildMenuItem(context,
            icon: Icon(Icons.cancel_sharp, color: Colors.red),
            stringTitle: 'Bilmediğim Kelimeler',
            toWhichPage: '/unknown'),
        buildMenuItem(context,
            icon: Icon(Icons.help_outline),
            stringTitle: 'Quiz',
            toWhichPage: '/quiz')
      ]),
    );
  }

  ListTile buildMenuItem(BuildContext context,
      {@required Icon icon,
      @required String stringTitle,
      @required String toWhichPage}) {
    return ListTile(
        leading: icon,
        title: Text(stringTitle),
        onTap: () => Navigator.pushNamed(context, toWhichPage));
  }
}
