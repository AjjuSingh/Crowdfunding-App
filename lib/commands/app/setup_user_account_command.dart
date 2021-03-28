import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/models/response/post_response_model.dart';
import 'package:dartz/dartz.dart';

import '../commands.dart';

class SetupUserAccountCommand extends BaseAppCommand {
  Future<PostResponse?> run(
      {required String gender,
      required String city,
      required String user_role,
      required Map<String, dynamic> social_links}) async {
    PostResponse? response;

    response = await authentication.setupAccount(
        city: city,
        gender: gender,
        user_role: user_role,
        social_links: social_links);

    return response;
  }
}
