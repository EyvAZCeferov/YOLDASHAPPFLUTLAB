import "dart:convert";
import "package:flutter/widgets.dart";

class Users {
  const Users({
    this.id,
    this.nameSurname,
    this.email,
    this.phone,
    this.status,
    this.provider,
    this.providerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.additionalinfo,
    this.statusActions,
  });

  factory Users.fromMap(Map<String, dynamic> map) => Users(
        id: map["id"],
        nameSurname: map["name_surname"],
        email: map["email"],
        phone: map["phone"],
        status: map["status"],
        provider: map["provider"],
        providerId: map["provider_id"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
        additionalinfo: map["additionalinfo"] == null
            ? null
            : Additionalinfo.fromMap(map["additionalinfo"]),
        statusActions: map["status_actions"] == null
            ? null
            : List<StatusActions>.from(
                map["status_actions"].map((e) => StatusActions.fromMap(e))),
      );

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  final int? id;
  final String? nameSurname;
  final String? email;
  final String? phone;
  final bool? status;
  final dynamic provider;
  final int? providerId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final Additionalinfo? additionalinfo;
  final List<StatusActions>? statusActions;

  @override
  int get hashCode => hashValues(
      id,
      nameSurname,
      email,
      phone,
      status,
      provider,
      providerId,
      createdAt,
      updatedAt,
      deletedAt,
      additionalinfo,
      statusActions);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name_surname": nameSurname,
        "email": email,
        "phone": phone,
        "status": status,
        "provider": provider,
        "provider_id": providerId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "additionalinfo": additionalinfo?.toMap(),
        "status_actions": statusActions?.map((e) => e?.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Users &&
        other.id == id &&
        other.nameSurname == nameSurname &&
        other.email == email &&
        other.phone == phone &&
        other.status == status &&
        other.provider == provider &&
        other.providerId == providerId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.additionalinfo == additionalinfo &&
        other.statusActions == statusActions;
  }
}

class Additionalinfo {
  const Additionalinfo({
    this.id,
    this.userId,
    this.image,
    this.birthday,
    this.gender,
    this.description,
    this.knownLanguages,
    this.originalPassword,
    this.createdAt,
    this.updatedAt,
  });

  factory Additionalinfo.fromMap(Map<String, dynamic> map) => Additionalinfo(
        id: map["id"],
        userId: map["user_id"],
        image: map["image"],
        birthday: map["birthday"],
        gender: map["gender"],
        description: map["description"],
        knownLanguages: (map["known_languages"] as List<dynamic>?)
          ?.map<String>((dynamic item) => item.toString())?.toList(),
        originalPassword: map["original_password"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
      );

  factory Additionalinfo.fromJson(String str) =>
      Additionalinfo.fromMap(json.decode(str));

  final int? id;
  final int? userId;
  final String? image;
  final String? birthday;
  final int? gender;
  final String? description;
  final List<String>? knownLanguages;
  final String? originalPassword;
  final String? createdAt;
  final String? updatedAt;

  @override
  int get hashCode => hashValues(id, userId, image, birthday, gender,
      description, knownLanguages, originalPassword, createdAt, updatedAt);

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "image": image,
        "birthday": birthday,
        "gender": gender,
        "description": description,
        "known_languages": knownLanguages,
        "original_password": originalPassword,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Additionalinfo &&
        other.id == id &&
        other.userId == userId &&
        other.image == image &&
        other.birthday == birthday &&
        other.gender == gender &&
        other.description == description &&
        other.knownLanguages == knownLanguages &&
        other.originalPassword == originalPassword &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}

class StatusActions {
  const StatusActions(
      {this.id,
      this.userId,
      this.status,
      this.type,
      this.createdAt,
      this.updatedAt});

  factory StatusActions.fromMap(Map<String, dynamic> map) => StatusActions(
        id: map["id"],
        userId: map["user_id"],
        status: map["status"],
        type: map["type"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
      );

  factory StatusActions.fromJson(String str) =>
      StatusActions.fromMap(json.decode(str));

  final int? id;
  final int? userId;
  final String? status;
  final String? type;
  final String? createdAt;
  final String? updatedAt;

  @override
  int get hashCode =>
      hashValues(id, userId, status, type, createdAt, updatedAt);

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is StatusActions &&
        other.id == id &&
        other.userId == userId &&
        other.status == status &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
