// To parse this JSON data, do
//
//     final campaign = campaignFromJson(jsonString);

import 'dart:convert';

Campaign campaignFromJson(String str) => Campaign.fromJson(json.decode(str));

String campaignToJson(Campaign data) => json.encode(data.toJson());

class Campaign {
  Campaign({
    this.title,
    this.subTitle,
    this.category,
    this.location,
    this.image,
    this.launchDate,
    this.campaignDuration,
    this.funding,
    this.story,
    this.people,
    this.bankAccount,
  });

  String? title;
  String? subTitle;
  String? category;
  String? location;
  String? image;
  String? launchDate;
  String? campaignDuration;
  String? funding;
  Story? story;
  People? people;
  BankAccount? bankAccount;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        title: json["title"],
        subTitle: json["subTitle"],
        category: json["category"],
        location: json["location"],
        image: json["image"],
        launchDate: json["launchDate"],
        campaignDuration: json["campaignDuration"],
        funding: json["funding"],
        story: Story.fromJson(json["story"]),
        people: People.fromJson(json["people"]),
        bankAccount: BankAccount.fromJson(json["bankAccount"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "category": category,
        "location": location,
        "image": image,
        "launchDate": launchDate,
        "campaignDuration": campaignDuration,
        "funding": funding,
        "story": story!.toJson(),
        "people": people!.toJson(),
        "bankAccount": bankAccount!.toJson(),
      };
}

class BankAccount {
  BankAccount({
    this.fullName,
    this.ifsc,
    this.accountNumber,
  });

  String? fullName;
  String? ifsc;
  int? accountNumber;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        fullName: json["fullName"],
        ifsc: json["ifsc"],
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "ifsc": ifsc,
        "accountNumber": accountNumber,
      };
}

class People {
  People({
    this.fullName,
    this.email,
    this.photo,
    this.biography,
    this.identity,
  });

  String? fullName;
  String? email;
  String? photo;
  String? biography;
  Identity? identity;

  factory People.fromJson(Map<String, dynamic> json) => People(
        fullName: json["fullName"],
        email: json["email"],
        photo: json["photo"],
        biography: json["biography"],
        identity: Identity.fromJson(json["identity"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "photo": photo,
        "biography": biography,
        "identity": identity!.toJson(),
      };
}

class Identity {
  Identity({
    this.firstName,
    this.lastName,
    this.dob,
    this.address,
    this.city,
    this.postalCode,
    this.country,
    this.phoneNumber,
  });

  String? firstName;
  String? lastName;
  String? dob;
  String? address;
  String? city;
  int? postalCode;
  String? country;
  int? phoneNumber;

  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["dob"],
        address: json["address"],
        city: json["city"],
        postalCode: json["postalCode"],
        country: json["country"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "address": address,
        "city": city,
        "postalCode": postalCode,
        "country": country,
        "phoneNumber": phoneNumber,
      };
}

class Story {
  Story({
    this.description,
    this.environmentCommitment,
  });

  String? description;
  List<String>? environmentCommitment;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        description: json["description"],
        environmentCommitment:
            List<String>.from(json["environment_commitment"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "environment_commitment":
            List<dynamic>.from(environmentCommitment!.map((x) => x)),
      };
}
