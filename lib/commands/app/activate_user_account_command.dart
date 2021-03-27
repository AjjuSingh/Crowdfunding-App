import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/commands/commands.dart';

class ActivateUserCommand extends BaseAppCommand {
  Future<bool> run({
    required String email,
    required String otp,
  }) async {
    try {
      var resp = await authentication.activateAccount(code: otp, email: email);
      if (resp != null) {
        return true;
      }
    } on Exception catch (e) {
      safePrint(e.toString());
    }
    return false;
  }
}
