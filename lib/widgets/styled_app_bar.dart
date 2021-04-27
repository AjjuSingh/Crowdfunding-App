import 'package:crowdfund_app/routing/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext? context;
  final String? title;
  final List<Widget>? actions;

  const VAppBar({Key? key, this.context, this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: actions,
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kTextTabBarHeight);
}
