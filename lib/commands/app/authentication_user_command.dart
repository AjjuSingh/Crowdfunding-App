import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/commands/app/set_current_user_command.dart';
import 'package:crowdfund_app/commands/commands.dart';
import 'package:crowdfund_app/models/app_user_model.dart';
import 'package:crowdfund_app/models/response/post_response_model.dart';
import 'package:dartz/dartz.dart';

class AuthenticationUserCommand extends BaseAppCommand {
  Future<Either<PostResponse, bool>> run(
      {required String email,
      required String password,
      required bool createNew}) async {
    AppUser? user;
    PostResponse? response;

    try {
      var resp = await authentication.signIn(
          email: email, password: password, createAccount: createNew);
      resp.fold((l) => response = l, (r) => user = r);
    } on Exception catch (e) {
      safePrint(e.toString());
    }

    /// Login
    if (user != null) {
      SetCurrentUserCommand().run(user);
      return Right(true);
    }
    return Left(response!);
  }
}
