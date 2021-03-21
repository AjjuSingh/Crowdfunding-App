import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/commands/app/set_current_user_command.dart';
import 'package:crowdfund_app/commands/commands.dart' as Commands;
import 'package:crowdfund_app/models/app_model.dart';
import 'package:flutter/cupertino.dart';

class BootStrapCommand extends Commands.BaseAppCommand {
  Future<void> run(BuildContext context) async {
    if (Commands.mainContext == null) {
      Commands.setContext(context);
    }
    print("Bootstrap Started, v${AppModel.kVersion}");

    // Load app model
    await appModel.load();

    safePrint(
        "BootstrapCommand - AppModel Loaded, user = ${appModel.currentUser}");

    if (authentication.isSignedIn == false && appModel.currentUser != null) {
      await Future<void>.delayed(Duration(seconds: 1));
      if (authentication.isSignedIn == false) {
        appModel.currentUser = null;
      }
    }

    // Login
    if (appModel.currentUser != null) {
      await SetCurrentUserCommand().run(appModel.currentUser);

      /// TODO: Refresh all data
    }
    appModel.hasBootstrapped = true;
    safePrint("BootstrapCommand - Complete");
  }
}
