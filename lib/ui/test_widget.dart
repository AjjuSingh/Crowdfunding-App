import 'package:crowdfund_app/models/app_model.dart';
import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WhoAreYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppUser? user = context.watch<AppModel>().currentUser;
    return Scaffold(
      body: Container(
        child: user?.accessToken == null
            ? Text("null")
            : Text(user!.accessToken ?? ""),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AppModel>().reset();
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        },
        child: Text("Logout"),
      ),
    );
  }
}
