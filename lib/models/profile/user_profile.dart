import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class Profile {
  final Map<String, String>? social_links;
  final String? username;
  final String? about;
  final String? profilePicture;
  final String? id;
  final String? gender;
  final String? city;
  final String? user_role;
  final String? pId;

  Profile(
      {this.social_links,
      this.username,
      this.about,
      this.profilePicture,
      this.id,
      this.gender,
      this.city,
      this.user_role,
      this.pId});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}


/**
 * {
    "error": false,
    "result": {
        "social_links": {
            "github": null,
            "linkedin": "linkedin.orgs"
        },
        "username": "AjjSingh",
        "about": "Tell us about yourself",
        "profilePicture": "https://www.sketchappsources.com/resources/source-image/profile-illustration-gunaldi-yunus.png",
        "_id": "6059e47547e3353e44a153e0",
        "gender": "Male",
        "city": "Lucknow",
        "user_role": "Developer",
        "pId": "d44e3f39-db58-4817-ac88-6567e14780c0",
        "__v": 0
    }
}
 */
