import 'package:json_annotation/json_annotation.dart';

part 'post_response_model.g.dart';

@JsonSerializable()
class PostResponse {
  final bool? error;
  final String? message;

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  PostResponse(this.error, this.message);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
