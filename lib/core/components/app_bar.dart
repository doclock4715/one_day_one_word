import 'package:flutter/material.dart';
import 'gradient_box_decoration.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({@required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: LinearGradientBoxDecoration().buildGradientBoxDecoration(),
      ),
      title: Text('$title',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
