import "dart:convert";
import "package:flutter/widgets.dart";

class Users {
  const Users({
      this.id,
      this.nameSurname,
      this.email,
      this.phone,
      this.type,
      this.status,
      this.provider,
      this.providerId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.additionalinfo,
  });
  
  factory Users.fromMap(Map<String, dynamic> map) => Users(
      id: map["id"],
      nameSurname: map["name_surname"],
      email: map["email"],
      phone: map["phone"],
      type: map["type"],
      status: map["status"],
      provider: map["provider"],
      providerId: map["provider_id"],
      createdAt: map["created_at"],
      updatedAt: map["updated_at"],
      deletedAt: map["deleted_at"],
      additionalinfo: map["additionalinfo"] == null ? null : Additionalinfo.fromMap(map["additionalinfo"]),
  );
  
  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));
  
  final int? id;
  final String? nameSurname;
  final String? email;
  final String? phone;
  final String? type;
  final bool? status;
  final dynamic provider;
  final dynamic providerId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final Additionalinfo? additionalinfo;
  
  @override
  int get hashCode => hashValues(id, nameSurname, email, phone, type, status, provider, providerId, createdAt, updatedAt, deletedAt, additionalinfo);
  
  Map<String, dynamic> toMap() => {
      "id": id,
      "name_surname": nameSurname,
      "email": email,
      "phone": phone,
      "type": type,
      "status": status,
      "provider": provider,
      "provider_id": providerId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "deleted_at": deletedAt,
      "additionalinfo": additionalinfo?.toMap(),
  };
  
  String toJson() => json.encode(toMap());
  
  Users copyWith({
      int? id,
      String? nameSurname,
      String? email,
      String? phone,
      String? type,
      bool? status,
      dynamic? provider,
      dynamic? providerId,
      String? createdAt,
      String? updatedAt,
      dynamic? deletedAt,
      Additionalinfo? additionalinfo,
  }) => Users(
      id: id ?? this.id,
      nameSurname: nameSurname ?? this.nameSurname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      status: status ?? this.status,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      additionalinfo: additionalinfo ?? this.additionalinfo,
  );
  
  @override
  String toString() => "Users(id: $id, nameSurname: $nameSurname, email: $email, phone: $phone, type: $type, status: $status, provider: $provider, providerId: $providerId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, additionalinfo: $additionalinfo)";
  
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
        other.type == type &&
        other.status == status &&
        other.provider == provider &&
        other.providerId == providerId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.additionalinfo == additionalinfo;
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
      knownLanguages: map["known_languages"],
      originalPassword: map["original_password"],
      createdAt: map["created_at"],
      updatedAt: map["updated_at"],
  );
  
  factory Additionalinfo.fromJson(String str) => Additionalinfo.fromMap(json.decode(str));
  
  final int? id;
  final int? userId;
  final dynamic image;
  final String? birthday;
  final int? gender;
  final dynamic description;
  final dynamic knownLanguages;
  final dynamic originalPassword;
  final String? createdAt;
  final String? updatedAt;
  
  @override
  int get hashCode => hashValues(id, userId, image, birthday, gender, description, knownLanguages, originalPassword, createdAt, updatedAt);
  
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
  
  Additionalinfo copyWith({
      int? id,
      int? userId,
      dynamic? image,
      String? birthday,
      int? gender,
      dynamic? description,
      dynamic? knownLanguages,
      dynamic? originalPassword,
      String? createdAt,
      String? updatedAt,
  }) => Additionalinfo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      image: image ?? this.image,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      description: description ?? this.description,
      knownLanguages: knownLanguages ?? this.knownLanguages,
      originalPassword: originalPassword ?? this.originalPassword,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
  );
  
  @override
  String toString() => "Additionalinfo(id: $id, userId: $userId, image: $image, birthday: $birthday, gender: $gender, description: $description, knownLanguages: $knownLanguages, originalPassword: $originalPassword, createdAt: $createdAt, updatedAt: $updatedAt)";
  
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

