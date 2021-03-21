class AppUser {
  bool? success;
  String? message;
  String? accessToken;

  AppUser({this.success, this.message, this.accessToken});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        success: json['success'],
        message: json['message'],
        accessToken: json['accessToken']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
