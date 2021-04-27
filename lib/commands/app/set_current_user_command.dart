import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/commands/commands.dart';
import 'package:crowdfund_app/models/app_user_model.dart';

class SetCurrentUserCommand extends BaseAppCommand {
  Future<void> run(AppUser? user) async {
    safePrint("SetCurrentUserCommand: $user");

    /// TODO: Update appController with new user. If user is null, this acts as logout command
    authentication.token = user!.accessToken;

    /// In app model update current user
    appModel.currentUser = user;

    if (user != null) {
      appModel.currentUser = user;

      safePrint("User loaded: ${user.toJson()}");
    }

    if (appModel.currentUser == null) {
      // Reset currentUser to null
      appModel.reset();
    }
    appModel.save();
  }
}
