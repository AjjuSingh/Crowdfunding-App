// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    social_links: (json['social_links'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    username: json['username'] as String?,
    about: json['about'] as String?,
    profilePicture: json['profilePicture'] as String?,
    id: json['id'] as String?,
    gender: json['gender'] as String?,
    city: json['city'] as String?,
    user_role: json['user_role'] as String?,
    pId: json['pId'] as String?,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'social_links': instance.social_links,
      'username': instance.username,
      'about': instance.about,
      'profilePicture': instance.profilePicture,
      'id': instance.id,
      'gender': instance.gender,
      'city': instance.city,
      'user_role': instance.user_role,
      'pId': instance.pId,
    };
